import csv
import subprocess

with open('utilisateurs.csv', 'r') as f:
# Créez un objet CSV reader
reader = csv.reader(f)
# Pour chaque ligne du fichier CSV
for row in reader:
    # Récupérez les valeurs du nom d'utilisateur et du mot de passe
    username = row[0]
    password = row[1]
    
    # Vérifiez si l'utilisateur existe déjà en exécutant la commande "dsquery"
    result = subprocess.run(["dsquery", "user", "cn=" + username], stdout=subprocess.PIPE)
    
    # Si l'utilisateur n'existe pas déjà
    if result.returncode != 0:
        # Créez le compte utilisateur en exécutant la commande "dsadd"
        subprocess.run(["dsadd", "user", "cn=" + username, "-pwd", password])
print("Tous les comptes utilisateurs ont été créés avec succès.")