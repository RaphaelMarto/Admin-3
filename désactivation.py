import csv
import subprocess

with open('utilisateurs.csv', 'r') as f:
# Créez un objet CSV reader
reader = csv.reader(f)

# Pour chaque ligne du fichier CSV
for row in reader:
    # Récupérez la valeur du nom d'utilisateur
    username = row[0]
    
    # Désactivez le compte utilisateur en exécutant la commande "dsmod"
    subprocess.run(["dsmod", "user", "cn=" + username, "-disabled", "yes"])
	
print("Tous les comptes utilisateurs ont été désactivés avec succès.")