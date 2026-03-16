
from ai.recepten_ai import genereer_recept, formatteer_recept
import sys

# User input from the issue report
# "kaas, plate kaas , rundstong steal verse kaas"
# User input from the issue report (exact typos)
ingredienten = ["kaas", "plate kaas", "rundstong steal", "verse kaas"]


with open('debug_output_utf8.txt', 'w', encoding='utf-8') as f:
    f.write(f"Testing with ingredients: {ingredienten}\n")

    recept = genereer_recept(ingredienten)

    if recept:
        f.write("\n=== RAW RESPONSE START ===\n")
        f.write(recept.get('raw_response', 'NO RAW RESPONSE'))
        f.write("\n=== RAW RESPONSE END ===\n\n")
        
        f.write(formatteer_recept(recept))
    else:
        f.write("Recept generation failed (returned None)\n")

