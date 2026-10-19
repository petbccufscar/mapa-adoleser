import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapa_adoleser/core/constants.dart';

/// Largura a partir da qual as seções passam a usar colunas lado a lado.
/// (Troque pelo valor do seu utilitário de tamanhos, se já existir um.)
const double _breakpoint = 860;

/// Cor de fundo dos cartões de todas as seções.
const Color _sectionBackground = Colors.white;

/// ---------------------------------------------------------------
/// Base compartilhada: todas as seções usam o mesmo cartão, os mesmos
/// espaçamentos, o mesmo estilo de título/texto e a mesma cor de destaque
/// (colorScheme.primary).
/// ---------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: _sectionBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Text(
                title,
                style: theme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
              if (subtitle != null) _BodyText(subtitle!),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Texto corrido padrão das seções.
class _BodyText extends StatelessWidget {
  const _BodyText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

/// Coloca os filhos lado a lado em telas largas e empilhados em telas estreitas.
class _AdaptiveLayout extends StatelessWidget {
  const _AdaptiveLayout({required this.children, this.spacing = 32});

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= _breakpoint) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spacing,
            children: [for (final child in children) Expanded(child: child)],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: spacing,
          children: children,
        );
      },
    );
  }
}

/// ---------------------------------------------------------------
/// SOBRE
/// ---------------------------------------------------------------
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppTexts.home;

    return _SectionCard(
      title: texts.aboutTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          _BodyText(texts.aboutText),
          FilledButton(
            onPressed: () => context.go('/sobre'),
            child: Text(texts.aboutButton),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------
/// NÚMEROS
/// ---------------------------------------------------------------
class NumbersSection extends StatelessWidget {
  const NumbersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppTexts.home;
    final theme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return _SectionCard(
      title: texts.knowTitle,
      subtitle: texts.knowText,
      child: Column(
        spacing: 24,
        children: [
          _NumbersGrid(items: texts.numbers),
          Text(
            texts.numbersUpdated,
            style: theme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _NumbersGrid extends StatelessWidget {
  const _NumbersGrid({required this.items});

  final List<(String, String)> items;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= _breakpoint ? 4 : 2;
        const gap = 24.0;
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: 28,
          alignment: WrapAlignment.center,
          children: [
            for (final (value, label) in items)
              SizedBox(
                width: itemWidth,
                child: Column(
                  spacing: 4,
                  children: [
                    Text(
                      value,
                      style: theme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: theme.bodyLarge
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

/// ---------------------------------------------------------------
/// COMO USAR
/// ---------------------------------------------------------------
class HowToUseSection extends StatelessWidget {
  const HowToUseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppTexts.home;

    return _SectionCard(
      title: texts.howToTitle,
      child: _AdaptiveLayout(
        children: [
          for (final (index, (title, description)) in texts.howToSteps.indexed)
            _Step(number: index + 1, title: title, description: description),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.number,
    required this.title,
    required this.description,
  });

  final int number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: colors.primary,
          child: Text(
            '$number',
            style: theme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: theme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        _BodyText(description),
      ],
    );
  }
}

/// ---------------------------------------------------------------
/// UM MAPA PARA CHAMAR DE SEU
/// ---------------------------------------------------------------
class MapForYouSection extends StatelessWidget {
  const MapForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppTexts.home;
    final colors = Theme.of(context).colorScheme;

    return _SectionCard(
      title: texts.mapTitle,
      child: _AdaptiveLayout(
        children: [
          _BodyText(texts.mapText),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              for (final topic in texts.mapTopics)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Icon(Icons.check_circle, size: 22, color: colors.primary),
                    Expanded(child: _BodyText(topic)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
