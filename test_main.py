import unittest
from main import add_to_cart, calculate_total, products

class TestPOS(unittest.TestCase):

    def test_add_to_cart(self):
        cart = {}
        add_to_cart(cart, "1", 2)
        self.assertEqual(cart, {"1": 2})
        add_to_cart(cart, "1", 3)
        self.assertEqual(cart, {"1": 5})
        add_to_cart(cart, "2", 1)
        self.assertEqual(cart, {"1": 5, "2": 1})
        # Test adding an invalid product
        add_to_cart(cart, "99", 1)
        self.assertEqual(cart, {"1": 5, "2": 1})

    def test_calculate_total(self):
        cart = {"1": 2, "3": 1}  # 2 Apples, 1 Orange
        total = calculate_total(cart)
        expected_total = (products["1"]["price"] * 2) + (products["3"]["price"] * 1)
        self.assertEqual(total, expected_total)

        cart_empty = {}
        total_empty = calculate_total(cart_empty)
        self.assertEqual(total_empty, 0)

if __name__ == '__main__':
    unittest.main()
