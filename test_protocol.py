
from ai.recepten_ai import genereer_recept, formatteer_recept
import time


def run_test(name, ingredients):
    with open('protocol_results.txt', 'a', encoding='utf-8') as f:
        f.write(f"\n{'='*60}\n")
        f.write(f"TEST: {name}\n")
        f.write(f"INPUT: {ingredients}\n")
        f.write(f"{'-'*60}\n")
        
        start = time.time()
        recept = genereer_recept(ingredients)
        duration = time.time() - start
        
        if recept:
            f.write(f"MODUS: {'BUITENAARDS' if recept.get('is_easter_egg') else 'NORMAAL'}\n")
            f.write(f"TITEL: {recept.get('titel')}\n")
            f.write(f"CATEGORIE: {recept.get('categorie')}\n")
            f.write(f"\n-- TIP (Check Logic) --\n")
            f.write(f"{recept.get('tip')}\n")
            f.write(f"\n-- RAW OUTPUT (Partial) --\n")
            f.write(f"{recept.get('raw_response')[:200]}...\n")
        else:
            f.write("FAIL: No recipe generated\n")
        
        f.write(f"{'='*60}\n\n")

# Clear file first
with open('protocol_results.txt', 'w', encoding='utf-8') as f:
    f.write("PROTOCOL TEST RESULTS\n")

# 1. De "Probleem" Case (Charcuterie Logic)
run_test("Charcuterie Logic (Kaas + Tong)", ["kaas", "plate kaas", "rundstong steal", "verse kaas"])

# 2. De "Clash" Case (Separation Logic)
run_test("Flavor Clash (Chocolade + Zalm)", ["pure chocolade", "gerookte zalm", "aardappelen"])

# 3. De "Easter Egg" Case (Non-Food)
run_test("Easter Egg (Baksteen)", ["baksteen", "boter", "eieren"])

