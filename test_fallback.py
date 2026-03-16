
from ai.recepten_ai import parse_recept_response, formatteer_recept

# Case 1: Well-formatted response (should parse normally)
good_response = """
MODUS: NORMAAL
TITEL: Normal Test
CATEGORIE: Lunch
TIJD: 10
PERSONEN: 1
INGREDIENTEN:
- Test
BEREIDING:
1. Test
"""

print("=== TEST 1: Good Response ===")
parsed_good = parse_recept_response(good_response)
print(f"Title: {parsed_good['titel']}")
print(f"Ingr count: {len(parsed_good['ingredienten'].splitlines())}")

# Case 2: Bad format (no tags, just text) - simulating "AI forgot the format"
bad_response = """
Hier is een recept voor je.
Verwarm de oven.
Doe alles in een pan.
Eet smakelijk!
"""

print("\n=== TEST 2: Bad Response (Fallback) ===")
parsed_bad = parse_recept_response(bad_response)
print(f"Title: {parsed_bad['titel']}") 
# Should conform to fallback logic: Title="Suggestie van de Chef", Instructions=full text
print(f"Instructions start with 'Hier is': {parsed_bad['instructies'].startswith('Hier is')}")

print("\n=== FORMATTED BAD RESPONSE ===")
print(formatteer_recept(parsed_bad))
