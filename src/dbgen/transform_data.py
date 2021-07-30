import csv
import os
from typing import DefaultDict

def transform_customer():
    # see if the file exists
    if not os.path.isfile("customer.tbl"):
        return
    with open("customer.tbl") as csvfile:
        reader = csv.reader(csvfile, delimiter="|")

        with open("customer.csv", "w") as outfile:
            writer = csv.writer(outfile, delimiter="|")
            for r in reader:
                # keeps custid, name, acct-bal
                writer.writerow((r[0], r[1], r[5]))

def transform_order():
    # see if the file exists
    if not os.path.isfile("orders.tbl"):
        return
    with open("orders.tbl") as csvfile:
        reader = csv.reader(csvfile, delimiter="|")

        with open("orders.csv", "w") as outfile:
            writer = csv.writer(outfile, delimiter="|")
            for r in reader:
                # TODO: translate orderstatus to true or false
                # keeps orderkey, custkey, orderstatus, total_price, order_date
                writer.writerow((r[0], r[1], r[2], r[3], r[4]))


def transform_order_items():
    # see if the file exists
    if not os.path.isfile("lineitem.tbl"):
        return
    with open("lineitem.tbl") as csvfile:
        reader = csv.reader(csvfile, delimiter="|")

        with open("orderitem.csv", "w") as outfile:
            writer = csv.writer(outfile, delimiter="|")
            for r in reader:
                # keeps orderid, itemid, line_number, quantity, price, tax
                writer.writerow((r[0], r[1], r[3], r[4], r[5], r[7]))

def transform_item_inventory():
    # for each item determine the popularity
    popularity = DefaultDict(set)
    with open("lineitem.tbl") as lineitemfile:
        reader = csv.reader(lineitemfile, delimiter="|")
        for r in reader:
            popularity[r[1]].add(r[0])
    popularity_count = DefaultDict(int)
    for key, val in popularity.items():
        popularity_count[key] = len(val)

    # determine the quanitity
    quanitity = DefaultDict(int)
    with open("partsupp.tbl") as partsuppfile:
        reader = csv.reader(partsuppfile, delimiter="|")
        for r in reader:
            quanitity[r[0]] += int(r[2])

    # see if the file exists
    if not os.path.isfile("part.tbl"):
        return
    with open("part.tbl") as csvfile:
        reader = csv.reader(csvfile, delimiter="|")

        with open("iteminventory.csv", "w") as outfile:
            writer = csv.writer(outfile, delimiter="|")
            for r in reader:
                # keeps item id, item_name, price, count, popularity
                writer.writerow((r[0], r[1], r[7], quanitity[r[0]], popularity_count[r[0]]))

transform_customer()
transform_item_inventory()
transform_order()
transform_order_items()
