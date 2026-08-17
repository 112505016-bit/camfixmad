import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_tokens.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus overview'),
        actions: [IconButton(icon: const Icon(Icons.tune), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Spacing.lg, 0, Spacing.lg, Spacing.xxxl),
        children: [
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.05,
            children: const [
              _MetricTile(label: 'Total', value: '284', color: AppColors.primary, icon: Icons.list_alt_outlined),
              _MetricTile(label: 'Pending', value: '41', color: AppColors.info, icon: Icons.schedule_outlined),
              _MetricTile(label: 'In progress', value: '37', color: AppColors.accent, icon: Icons.build_outlined),
              _MetricTile(label: 'Resolved', value: '198', color: AppColors.success, icon: Icons.task_alt_outlined),
              _MetricTile(label: 'Overdue', value: '9', color: AppColors.error, icon: Icons.warning_amber_outlined),
              _MetricTile(label: 'Critical', value: '3', color: AppColors.priorityCritical, icon: Icons.report_gmailerrorred_outlined),
            ],
          ),
          const SizedBox(height: Spacing.xl),

          _ChartCard(
            title: 'SLA compliance',
            trailing: Text('87.4%', style: AppTypography.h3.copyWith(color: AppColors.success)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Radii.pill),
              child: LinearProgressIndicator(
                value: 0.874,
                minHeight: 10,
                backgroundColor: AppColors.surfaceAlt,
                valueColor: const AlwaysStoppedAnimation(AppColors.success),
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          _ChartCard(
            title: 'Complaints by category',
            child: SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 34,
                        sections: [
                          PieChartSectionData(value: 32, color: AppColors.primary, title: '', radius: 26),
                          PieChartSectionData(value: 24, color: AppColors.primaryLight, title: '', radius: 26),
                          PieChartSectionData(value: 18, color: AppColors.accent, title: '', radius: 26),
                          PieChartSectionData(value: 14, color: AppColors.info, title: '', radius: 26),
                          PieChartSectionData(value: 12, color: AppColors.textTertiary, title: '', radius: 26),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _legendDot('Plumbing', AppColors.primary),
                        _legendDot('Electrical', AppColors.primaryLight),
                        _legendDot('IT / Network', AppColors.accent),
                        _legendDot('Cleaning', AppColors.info),
                        _legendDot('Other', AppColors.textTertiary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          _ChartCard(
            title: 'Complaints trend (last 7 days)',
            child: SizedBox(
              height: 160,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primary.withValues(alpha: 0.08),
                      ),
                      spots: const [
                        FlSpot(0, 12), FlSpot(1, 18), FlSpot(2, 14),
                        FlSpot(3, 22), FlSpot(4, 19), FlSpot(5, 27), FlSpot(6, 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          _ChartCard(
            title: 'Department performance',
            subtitle: 'Avg. resolution time (hrs)',
            child: SizedBox(
              height: 170,
              child: BarChart(
                BarChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, meta) {
                          const labels = ['CA', 'CS', 'ME', 'MA', 'PH'];
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(labels[v.toInt() % labels.length], style: AppTypography.caption),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [14, 22, 9, 17, 12].asMap().entries.map((e) {
                    return BarChartGroupData(x: e.key, barRods: [
                      BarChartRodData(
                        toY: e.value.toDouble(),
                        color: AppColors.primaryLight,
                        width: 18,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          _ChartCard(
            title: 'Staff workload',
            child: Column(
              children: const [
                _WorkloadRow(name: 'Ramesh Kumar (Plumber)', value: 0.8, tasks: 8),
                SizedBox(height: 12),
                _WorkloadRow(name: 'Priya Nair (Electrician)', value: 0.55, tasks: 5),
                SizedBox(height: 12),
                _WorkloadRow(name: 'Suresh IT (IT Tech)', value: 0.35, tasks: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendDot(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label, style: AppTypography.bodySm),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label, value;
  final Color color;
  final IconData icon;
  const _MetricTile({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(Radii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: color),
          const Spacer(),
          Text(value, style: AppTypography.h3.copyWith(fontSize: 19)),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;
  const _ChartCard({required this.title, this.subtitle, this.trailing, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.h4),
                    if (subtitle != null) Text(subtitle!, style: AppTypography.caption),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _WorkloadRow extends StatelessWidget {
  final String name;
  final double value;
  final int tasks;
  const _WorkloadRow({required this.name, required this.value, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(name, style: AppTypography.bodySm)),
            Text('$tasks active', style: AppTypography.caption),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(Radii.pill),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 7,
            backgroundColor: AppColors.surfaceAlt,
            valueColor: const AlwaysStoppedAnimation(AppColors.primaryLight),
          ),
        ),
      ],
    );
  }
}
