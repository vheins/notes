products = {
    "1": {"name": "Apple", "price": 1.00},
    "2": {"name": "Banana", "price": 0.50},
    "3": {"name": "Orange", "price": 0.75},
}

def display_products():
    print("Available Products:")
    for product_id, product in products.items():
        print(f"{product_id}: {product['name']} - ${product['price']:.2f}")

def add_to_cart(cart, product_id, quantity):
    if product_id in products:
        if product_id in cart:
            cart[product_id] += quantity
        else:
            cart[product_id] = quantity
        print(f"Added {quantity} of {products[product_id]['name']} to the cart.")
    else:
        print("Invalid product ID.")

def calculate_total(cart):
    total = 0
    for product_id, quantity in cart.items():
        total += products[product_id]["price"] * quantity
    return total

def print_receipt(cart, total):
    print("\n--- Receipt ---")
    for product_id, quantity in cart.items():
        product = products[product_id]
        print(f"{product['name']} x{quantity} - ${product['price'] * quantity:.2f}")
    print("---------------")
    print(f"Total: ${total:.2f}")

def main():
    cart = {}
    while True:
        print("\n--- POS System ---")
        display_products()
        print("\nOptions:")
        print("1. Add item to cart")
        print("2. View cart")
        print("3. Checkout")
        print("4. Exit")

        choice = input("Enter your choice: ")

        if choice == "1":
            product_id = input("Enter product ID: ")
            quantity = int(input("Enter quantity: "))
            add_to_cart(cart, product_id, quantity)
        elif choice == "2":
            print("\n--- Cart ---")
            for product_id, quantity in cart.items():
                product = products[product_id]
                print(f"{product['name']} x{quantity}")
            print("------------")
        elif choice == "3":
            total = calculate_total(cart)
            print_receipt(cart, total)
            break
        elif choice == "4":
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
