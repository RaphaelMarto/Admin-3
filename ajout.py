import csv
import pyad

# Ouvrez le fichier CSV et créez un lecteur CSV
with open('utilisateurs.csv', 'r') as f:
    reader = csv.reader(f)
    
    # Pour chaque ligne du fichier CSV
    for row in reader:
        # Récupérez les informations sur l'utilisateur à partir de la ligne CSV
        nom_utilisateur = row[0]
        prenom_utilisateur = row[1]
        nom_complet = f"{prenom_utilisateur} {nom_utilisateur}"
        nom_compte = row[2]
        mot_de_passe = row[3]
        
        # Vérifiez si le compte utilisateur existe déjà dans Active Directory
        user = pyad.aduser.ADUser.from_cn(nom_compte)
        if not user:
            # Si le compte n'existe pas, créez-le avec pyad dans l'OU "utilisateurs"
            user = pyad.aduser.ADUser.create(nom_compte, ou='ou=utilisateurs,dc=l2-4,dc=lab')
            
            # Affectez les propriétés de l'objet utilisateur
            user.set_givenName(prenom_utilisateur)
            user.set_surname(nom_utilisateur)
            user.set_displayName(nom_complet)
            user.set_password(mot_de_passe)
            
            # Enregistrez les modifications de l'objet utilisateur dans Active Directory
            user.update_changes()
        else:
            # Si le compte existe déjà, affichez un message d'erreur
            print(f"Le compte {nom_compte} existe déjà dans Active Directory.")
