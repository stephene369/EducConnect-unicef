import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            appProvider.userName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Niveau 3 - Intermédiaire',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 30),
          _buildInfoCard(
            'Informations personnelles',
            [
              _buildInfoRow(Icons.person, 'Nom', appProvider.userName),
              _buildInfoRow(Icons.school, 'École', 'École Primaire de Dakar'),
              _buildInfoRow(Icons.location_on, 'Région', 'Dakar, Sénégal'),
              _buildInfoRow(Icons.language, 'Langue préférée', appProvider.language == 'fr' ? 'Français' : 'English'),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            'Progression',
            [
              _buildInfoRow(Icons.book, 'Cours suivis', '7'),
              _buildInfoRow(Icons.check_circle, 'Cours terminés', '4'),
              _buildInfoRow(Icons.star, 'Récompenses obtenues', '3'),
              _buildInfoRow(Icons.trending_up, 'Progression globale', '65%'),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            'Préférences d\'apprentissage',
            [
              _buildInfoRow(Icons.access_time, 'Temps d\'étude préféré', 'Après-midi'),
              _buildInfoRow(Icons.category, 'Matière préférée', 'Mathématiques'),
              _buildInfoRow(Icons.speed, 'Rythme d\'apprentissage', 'Modéré'),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              // Fonction pour synchroniser les données (fictive)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Synchronisation des données...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.sync),
            label: const Text('Synchroniser mes données'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}