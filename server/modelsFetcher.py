# Imports
from dotenv import load_dotenv
import csv
import requests
import os
import time

# Get Shopify access key as environment variable
load_dotenv()
SHOPIFY_ACCESS_KEY = os.getenv('SHOPIFY_ACCESS_KEY')
print(SHOPIFY_ACCESS_KEY)

url = "https://bakers-paradise-6276.myshopify.com/admin/api/2023-07/orders.json"

headers = {
    'Content-Type': 'application/json',
    'X-Shopify-Access-Token': SHOPIFY_ACCESS_KEY,
}

params = {
    'fields': 'order_number,line_items',
}

# Global variables
database_name = "database.csv"
database_rel_path = f"../{database_name}"
order_numbers = []
missing_sku_warning = False
missing_model_file = False
items = []

# Main infinite loop
def periodicly_fetch_orders(interval=10):
    secondsInterval = interval * 60
    while True:

        response = requests.request("GET", url, headers=headers , params=params)
        if response.status_code == 200:

            # Get last order number from database
            with open(database_rel_path, 'r') as file:
                reader = csv.reader(file)
                try:
                    row = next(reader)
                    last_order_number = int(row[0])
                    print(f"Last order number: {last_order_number}")
                except StopIteration:
                    print(f"{database_name} is empty or does not contain valid data.")
                except ValueError:
                    print(f"{database_name} does not contain a valid order number.")

            # Do some stuff with the orders
            # Get orders from Shopify
            orders = response.json()["orders"]
            for order in orders:

                # Use only new orders
                order_number = order["order_number"]
                if order_number <= last_order_number:
                    continue
                else:
                    order_numbers.append(order_number)
                    line_items = order["line_items"]
                    
                    # Get SKU from each item
                    for line_item in line_items:
                        item_name = line_item["name"]
                        sku = line_item["sku"]

                        # handle platba dobírkou
                        if sku is None:
                            continue

                        # handle the new format of platba dobírkou
                        elif sku == "DOBIRKA":
                            continue

                        # handle no SKU
                        elif sku == "":
                            missing_sku_warning = True
                            print("No SKU for item: " + item_name)

                        else:
                            # Create full item object
                            full_item = {
                                "sku": sku,
                                "item_name": item_name,
                                "order_number": order_number
                            }
                            for x in range(line_item["fulfillable_quantity"]):

                                items.append(full_item)

            # If there are new orders
            if order_numbers:
                # Get last order number
                sorted_order_numbers = sorted(order_numbers, reverse=True)
                last_order_number = sorted_order_numbers[0]

                # Write the order number to the database
                with open( database_rel_path, "w", newline='') as file:
                   writer = csv.writer(file)
                   writer.writerow([last_order_number])


            else:
                print("No new orders.")

        else:
            print(f"Error: Unable to fetch orders - {response.status_code}")
            print(response.text)

        time.sleep(secondsInterval)

# Call the main loop
# periodicly_fetch_orders(0.01)
