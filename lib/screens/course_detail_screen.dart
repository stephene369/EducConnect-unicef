import 'package:flutter/material.dart';

class CourseDetailScreen extends StatefulWidget {
  final String title;
  final String imageUrl;

  const CourseDetailScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  int _currentPage = 0;
  final int _totalPages = 3;
  bool _showQuiz = false;
  int? _selectedAnswer;
  bool _hasSubmitted = false;

  final List<String> _pageContents = [
    "Bienvenue dans ce cours! Nous allons explorer les concepts fondamentaux et vous aider à maîtriser ce sujet étape par étape. Ce contenu est disponible hors ligne pour que vous puissiez apprendre n'importe où, même sans connexion internet.",
    "Dans cette section, nous abordons les principes clés que vous devez comprendre. Prenez votre temps pour assimiler ces informations et n'hésitez pas à revenir en arrière si nécessaire. La pratique régulière est essentielle pour progresser.",
    "Félicitations pour avoir terminé cette partie du cours! Maintenant, testons vos connaissances avec un petit quiz pour voir ce que vous avez retenu. Cela vous aidera à identifier les points à revoir si nécessaire.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _showQuiz ? _buildQuiz() : _buildCoursePage(),
    );
  }

  Widget _buildCoursePage() {
    return Column(
      children: [
        Image.network(
          widget.imageUrl,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.title} - Page ${_currentPage + 1}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      _pageContents[_currentPage],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentPage--;
                          });
                        },
                        child: const Text('Précédent'),
                      )
                    else
                      const SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage < _totalPages - 1) {
                          setState(() {
                            _currentPage++;
                          });
                        } else {
                          setState(() {
                            _showQuiz = true;
                          });
                        }
                      },
                      child: Text(_currentPage < _totalPages - 1 ? 'Suivant' : 'Quiz'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuiz() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quiz',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Question: Quelle est la principale caractéristique d\'EduConnect?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          _buildQuizOption(0, 'Fonctionne uniquement avec une connexion internet rapide'),
          _buildQuizOption(1, 'Permet d\'apprendre même sans connexion internet'),
          _buildQuizOption(2, 'Ne propose que des cours en anglais'),
          _buildQuizOption(3, 'Est disponible uniquement sur ordinateur'),
          const SizedBox(height: 20),
          if (_hasSubmitted)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _selectedAnswer == 1 ? Colors.green[100] : Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _selectedAnswer == 1 ? Icons.check_circle : Icons.cancel,
                    color: _selectedAnswer == 1 ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selectedAnswer == 1
                          ? 'Correct! EduConnect est conçu pour fonctionner sans connexion internet.'
                          : 'Incorrect. La bonne réponse est: Permet d\'apprendre même sans connexion internet.',
                      style: TextStyle(
                        color: _selectedAnswer == 1 ? Colors.green[800] : Colors.red[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showQuiz = false;
                    _currentPage = _totalPages - 1;
                    _hasSubmitted = false;
                    _selectedAnswer = null;
                  });
                },
                child: const Text('Retour au cours'),
              ),
              if (!_hasSubmitted)
                ElevatedButton(
                  onPressed: _selectedAnswer != null
                      ? () {
                          setState(() {
                            _hasSubmitted = true;
                          });
                        }
                      : null,
                  child: const Text('Vérifier'),
                )
              else
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Terminer'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuizOption(int value, String text) {
    final bool isSelected = _selectedAnswer == value;
    final bool isCorrect = value == 1;
    final bool showResult = _hasSubmitted;

    Color? backgroundColor;
    if (showResult) {
      if (isSelected) {
        backgroundColor = isCorrect ? Colors.green[100] : Colors.red[100];
      } else if (isCorrect) {
        backgroundColor = Colors.green[50];
      }
    } else if (isSelected) {
      backgroundColor = Colors.blue[100];
    }

    return GestureDetector(
      onTap: _hasSubmitted
          ? null
          : () {
              setState(() {
                _selectedAnswer = value;
              });
            },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              showResult
                  ? (isCorrect ? Icons.check_circle : Icons.cancel)
                  : (isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
              color: showResult
                  ? (isCorrect ? Colors.green : Colors.red)
                  : (isSelected ? Colors.blue : Colors.grey),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}