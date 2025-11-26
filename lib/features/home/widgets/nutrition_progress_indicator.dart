import 'package:flutter/material.dart';

class NutritionProgressIndicator extends StatelessWidget {
  final String nutrientName;
  final double recommended;
  final double consumed;
  final String unit;
  final Color? color;

  const NutritionProgressIndicator({
    super.key,
    required this.nutrientName,
    required this.recommended,
    required this.consumed,
    required this.unit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = recommended > 0 ? (consumed / recommended).clamp(0.0, 2.0) : 0.0;
    final status = _getNutrientStatus(percentage);
    final statusColor = _getStatusColor(status);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  nutrientName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  status,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage.clamp(0.0, 1.0),
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  minHeight: 6,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                child: Text(
                  '${(percentage * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Consumed: ${consumed.toStringAsFixed(1)} $unit',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'Goal: ${recommended.toStringAsFixed(1)} $unit',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getNutrientStatus(double percentage) {
    if (percentage < 0.67) {
      return 'Deficient';
    } else if (percentage <= 1.33) {
      return 'Adequate';
    } else {
      return 'Excessive';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Deficient':
        return Colors.red;
      case 'Adequate':
        return Colors.green;
      case 'Excessive':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class NutritionSummaryCard extends StatelessWidget {
  final Map<String, double> recommended;
  final Map<String, double> consumed;
  final Map<String, String> units;

  const NutritionSummaryCard({
    super.key,
    required this.recommended,
    required this.consumed,
    required this.units,
  });

  @override
  Widget build(BuildContext context) {
    final overallScore = _calculateOverallScore();
    final scoreColor = _getScoreColor(overallScore);
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nutrition Score',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: scoreColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: scoreColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    '${overallScore.toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scoreColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: overallScore / 100,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
              minHeight: 8,
            ),
            const SizedBox(height: 16),
            Text(
              _getScoreMessage(overallScore),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateOverallScore() {
    if (recommended.isEmpty) return 0;
    
    double totalScore = 0;
    int validNutrients = 0;
    
    for (final nutrient in recommended.keys) {
      final rec = recommended[nutrient] ?? 0;
      final cons = consumed[nutrient] ?? 0;
      
      if (rec > 0) {
        final percentage = (cons / rec).clamp(0.0, 2.0);
        // Score based on how close to 100% the intake is
        final score = percentage <= 1.0 
            ? percentage * 100 
            : 100 - ((percentage - 1.0) * 50); // Penalty for excess
        totalScore += score.clamp(0.0, 100.0);
        validNutrients++;
      }
    }
    
    return validNutrients > 0 ? totalScore / validNutrients : 0;
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  String _getScoreMessage(double score) {
    if (score >= 80) {
      return 'Excellent! Your nutrition intake is well-balanced.';
    } else if (score >= 60) {
      return 'Good progress! Consider improving some nutrient intakes.';
    } else {
      return 'Needs improvement. Focus on meeting daily nutrition goals.';
    }
  }
}
