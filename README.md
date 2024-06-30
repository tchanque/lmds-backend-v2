# La Maison des Sons


Lien vers l'application : [LaMaisonDesSons](https://lmds-frontend-v2.vercel.app/)
Liens utiles : 
- [schéma de la base de données](https://dbdiagram.io/d/La-Maison-des-Sons-V2-666185f39713410b05e9c768)
- [Trello](https://trello.com/b/fY4jeeMN/la-maison-des-sons)
- [Figma](https://www.figma.com/design/g7GD8GKHoqFvCwWgg9Htke/la-maison-des-sons-v2?node-id=0-1&t=WY6DTXbo36pwLt5J-0)


## Présentation du projet :

La Maison des Sons, une association musicale vibrante au cœur de Paris, souhaite moderniser et dynamiser sa communication et son organisation interne. 

Dans ce but, nous leur proposons une application qui permettra aux membres de visualiser facilement tous les événements à venir, de s'y inscrire, d'accéder à un agenda personnel ainsi qu'aux news proposées par l'association.


## Base de données

la base de données comprends différentes tables :
- **users** : infos des usagers (profil utilisateur)
- **events** : infos concernant les évènements (titre, date, description ...)
- **publications** : infos diverses proposées par l'association
- **instruments** : les différents instruments proposés par l'école

ainsi que des tables de liaisons :
- **skills** : permet de rattacher un instrument et un niveau à un usager
- **event instruments** : permet d'ajouter la notion d'instrument et de niveau requis pour les évènements qui le nécessitent.
- **attendances** : gère les inscriptions (+ liste d'attente) des utilisateurs aux évènements

## Prérequis

Avant de commencer, assurez-vous d'avoir installé les outils suivants sur votre système :

- [Ruby](https://www.ruby-lang.org/en/) (version recommandée spécifiée dans le Gemfile)
- [Ruby on Rails](https://rubyonrails.org/) (version spécifiée dans le Gemfile)
- [PostgreSQL](https://www.postgresql.org/) (avec les informations de connexion appropriées)


## Installation

1. **Clôner le dépôt**

   ```bash
   git clone git@github.com:tchanque/lmds-backend-v2.git
   cd lmds-backend-v2
   ```

2. **Installer les dépendances Ruby**

```bash
    bundle install
```
3. **Créer les bases de données**

```bash
    rails db:create
    rails db:migrate
    rails db:seed
```

4. **Lancer le serveur**

```bash
  rails s
  ```
  




### 🚀 About us

- [Thomas Audevie](https://github.com/tchanque)
- [Damien Generet](https://github.com/Damien-Generet)
- [Raphaël Marcarini](https://github.com/Marcaraph)
- [Alexia Scherer](https://github.com/evarellapucky)