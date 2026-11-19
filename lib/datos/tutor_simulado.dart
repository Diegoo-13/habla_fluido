import '../dominio/nivel.dart';
import '../dominio/reglas.dart';
import '../dominio/tutor.dart';

class _Regla {
  final RegExp patron;
  final String Function(Match) reemplazo;
  final String explicacion;
  const _Regla(this.patron, this.reemplazo, this.explicacion);
}

const _pasado = {
  'go': 'went',
  'eat': 'ate',
  'see': 'saw',
  'buy': 'bought',
  'have': 'had',
  'do': 'did',
  'make': 'made',
  'take': 'took',
  'come': 'came',
  'get': 'got',
  'write': 'wrote',
  'speak': 'spoke',
  'drink': 'drank',
  'run': 'ran',
  'sleep': 'slept',
  'feel': 'felt',
  'think': 'thought',
};

const _terceraPersona = {
  'go': 'goes',
  'have': 'has',
  'do': 'does',
  'like': 'likes',
  'want': 'wants',
  'live': 'lives',
  'play': 'plays',
  'work': 'works',
  'study': 'studies',
  'eat': 'eats',
  'drink': 'drinks',
  'speak': 'speaks',
  'need': 'needs',
  'love': 'loves',
  'make': 'makes',
  'take': 'takes',
  'watch': 'watches',
};

const _ortografiaComun = {
  'frend': 'friend',
  'freind': 'friend',
  'familly': 'family',
  'famili': 'family',
  'becouse': 'because',
  'becuase': 'because',
  'beutiful': 'beautiful',
  'beatiful': 'beautiful',
  'tomorow': 'tomorrow',
  'tommorrow': 'tomorrow',
  'yestarday': 'yesterday',
  'peaple': 'people',
  'peopel': 'people',
  'studing': 'studying',
  'writting': 'writing',
  'hapy': 'happy',
  'realy': 'really',
  'wich': 'which',
  'wiht': 'with',
  'dont': "don't",
  'doesnt': "doesn't",
  'didnt': "didn't",
  'cant': "can't",
  'im': "I'm",
  'ive': "I've",
  'alot': 'a lot',
};

final List<_Regla> _reglas = [
  // Concordancia con "I"
  _Regla(RegExp(r'\bi am agree\b', caseSensitive: false), (_) => 'I agree',
      '"agree" ya es un verbo: no lleva "am". Se dice "I agree".'),
  _Regla(RegExp(r'\bi (is|are)\b', caseSensitive: false), (_) => 'I am',
      'Con "I" se usa "am": I am.'),
  _Regla(RegExp(r'\bi has\b', caseSensitive: false), (_) => 'I have',
      'Con "I" se usa "have", no "has".'),

  // Concordancia con he / she / it
  _Regla(
      RegExp(
          r'\b(he|she|it) (go|have|do|like|want|live|play|work|study|eat|drink|speak|need|love|make|take|watch)\b',
          caseSensitive: false),
      (m) => '${m[1]} ${_terceraPersona[m[2]!.toLowerCase()]}',
      'Con he/she/it, el verbo en presente lleva -s (o -es): he goes, she has.'),
  _Regla(RegExp(r'\b(he|she|it) (are|am)\b', caseSensitive: false), (m) => '${m[1]} is',
      'Con he/she/it se usa "is", no "are" ni "am".'),
  _Regla(RegExp(r"\b(he|she|it) don't\b", caseSensitive: false), (m) => "${m[1]} doesn't",
      'En negativo con he/she/it se usa "doesn\'t", no "don\'t".'),

  // Concordancia con you / we / they
  _Regla(RegExp(r'\b(you|we|they) (is|am|was)\b', caseSensitive: false),
      (m) => '${m[1]} ${m[2]!.toLowerCase() == 'was' ? 'were' : 'are'}',
      'Con you/we/they se usa "are" (presente) o "were" (pasado).'),
  _Regla(RegExp(r'\b(you|we|they) has\b', caseSensitive: false), (m) => '${m[1]} have',
      'Con you/we/they se usa "have", no "has".'),

  // Comparativos dobles y sustantivos irregulares
  _Regla(RegExp(r'\bmore better\b', caseSensitive: false), (_) => 'better',
      '"better" ya es comparativo; no necesita "more".'),
  _Regla(RegExp(r'\bmore easier\b', caseSensitive: false), (_) => 'easier',
      '"easier" ya es comparativo; no necesita "more".'),
  _Regla(RegExp(r'\bmore bigger\b', caseSensitive: false), (_) => 'bigger',
      '"bigger" ya es comparativo; no necesita "more".'),
  _Regla(RegExp(r'\bpeoples\b', caseSensitive: false), (_) => 'people',
      '"people" ya es plural (personas); no lleva "s" al final.'),
  _Regla(RegExp(r'\bchilds\b', caseSensitive: false), (_) => 'children',
      'El plural irregular de "child" es "children".'),
  _Regla(RegExp(r'\b(five|two|three|four|six|seven|eight|nine|ten|many) person\b', caseSensitive: false),
      (m) => '${m[1]} people',
      'Después de números mayores a uno o "many" se usa el plural "people".'),

  // Pasado simple con expresiones de tiempo pasado
  _Regla(
      RegExp(
          r'\byesterday i (go|eat|see|buy|have|do|make|take|come|get|write|speak|drink|run|sleep|feel|think)\b',
          caseSensitive: false),
      (m) => 'yesterday I ${_pasado[m[1]!.toLowerCase()]}',
      'Con "yesterday" usa el verbo en pasado: went, ate, saw, bought...'),
  _Regla(
      RegExp(
          r'\blast (week|month|year|night|weekend) i (go|eat|see|buy|have|do|make|take|come|get|write|speak|drink|run|sleep|feel|think)\b',
          caseSensitive: false),
      (m) => 'last ${m[1]} I ${_pasado[m[2]!.toLowerCase()]}',
      'Con expresiones como "last week" o "last year" usa el verbo en pasado simple.'),

  // Artículos a / an
  _Regla(RegExp(r'\ba (apple|orange|elephant|umbrella|egg|idea|hour|interesting|old)\b', caseSensitive: false),
      (m) => 'an ${m[1]}',
      'Antes de sonido vocal se usa "an" en lugar de "a".'),
  _Regla(RegExp(r'\ban (car|dog|cat|house|book|person|friend|family|good|big)\b', caseSensitive: false),
      (m) => 'a ${m[1]}',
      'Antes de sonido consonante se usa "a" en lugar de "an".'),

  // Preposiciones y errores típicos de hispanohablantes
  _Regla(RegExp(r'\bi have (\d+) years\b', caseSensitive: false), (m) => 'I am ${m[1]} years old',
      'En inglés la edad se expresa con el verbo "to be": por ejemplo, "I am 20 years old".'),
  _Regla(RegExp(r'\bdepend of\b', caseSensitive: false), (_) => 'depend on',
      'El verbo "depend" lleva la preposición "on" (depend on), no "of".'),
  _Regla(RegExp(r'\bmarried with\b', caseSensitive: false), (_) => 'married to',
      'En inglés se dice "married to" (casado con), no "married with".'),
  _Regla(RegExp(r'\blisten music\b', caseSensitive: false), (_) => 'listen to music',
      'El verbo "listen" lleva "to" antes del objeto: "listen to music".'),
];

const _temas = {
  NivelCefr.a1: [
    'What is your name?',
    'Where do you live?',
    'What do you eat for breakfast?',
    'Do you have a pet?'
  ],
  NivelCefr.a2: [
    'What did you do last weekend?',
    'What is your favorite food?',
    'Where would you like to travel?',
    'Who is your best friend?'
  ],
  NivelCefr.b1: [
    'What are your plans for next year?',
    'Tell me about a book you enjoyed.',
    'What would you change about your city?',
    'Why are you learning English?'
  ],
  NivelCefr.b2: [
    'What is a skill you want to master and why?',
    'How has technology changed the way we study?'
  ],
  NivelCefr.c1: [
    'How do you think education will look in 20 years?',
    'What makes a good argument persuasive?'
  ],
};

class TutorSimulado implements TutorIA {
  int _turno = 0;

  List<Correccion> _detectar(String texto) {
    final out = <Correccion>[];
    final limpio = texto.trim();
    if (limpio.isEmpty) return out;

    // 1. Revisar reglas gramaticales
    for (final r in _reglas) {
      final m = r.patron.firstMatch(limpio);
      if (m != null && out.length < Reglas.maxCorreccionesPorTurno) {
        out.add(Correccion(m[0]!, r.reemplazo(m), r.explicacion));
      }
    }

    // 2. Revisar ortografía y contracciones comunes palabra por palabra
    final palabras = RegExp(r"\b[a-zA-Z']+\b").allMatches(limpio);
    for (final p in palabras) {
      if (out.length >= Reglas.maxCorreccionesPorTurno) break;
      final original = p[0]!;
      final minuscula = original.toLowerCase();
      if (_ortografiaComun.containsKey(minuscula)) {
        final sugerencia = _ortografiaComun[minuscula]!;
        if (original != sugerencia) {
          out.add(Correccion(
            original,
            sugerencia,
            'Revisa la ortografía o contracción: se escribe "$sugerencia".',
          ));
        }
      }
    }

    // 3. "i" suelta en minúscula
    final sola = RegExp(r'(^|\s)i(\s|$|[.,!?])').firstMatch(limpio);
    if (sola != null && out.length < Reglas.maxCorreccionesPorTurno) {
      out.add(const Correccion(
          'i', 'I', 'En inglés, el pronombre "I" (yo) siempre se escribe con mayúscula.'));
    }

    // 4. Mayúscula inicial en la oración
    if (out.length < Reglas.maxCorreccionesPorTurno &&
        RegExp(r'^[a-z]').hasMatch(limpio)) {
      final primera = limpio[0];
      out.add(Correccion(
        primera,
        primera.toUpperCase(),
        'Toda oración en inglés debe comenzar con letra mayúscula.',
      ));
    }

    // 5. Puntuación final (punto, signo de interrogación o exclamación)
    if (out.length < Reglas.maxCorreccionesPorTurno &&
        !RegExp(r'[.!?]$').hasMatch(limpio)) {
      final ultimaPalabra = limpio.split(RegExp(r'\s+')).last;
      out.add(Correccion(
        ultimaPalabra,
        '$ultimaPalabra.',
        'Falta el signo de puntuación al final de la oración (por ejemplo, un punto ".").',
      ));
    }

    return out.take(Reglas.maxCorreccionesPorTurno).toList();
  }

  @override
  Future<RespuestaTutor> conversar(
      {required NivelCefr nivel, required List<Mensaje> historial}) async {
    final ultimo = historial
        .lastWhere((m) => m.delEstudiante, orElse: () => const Mensaje(true, ''))
        .texto;
    final correcciones = _detectar(ultimo);
    final temas = _temas[nivel]!;
    final pregunta = temas[_turno % temas.length];
    final animo = ['Nice!', 'Great!', 'Good job!', 'I see.'][_turno % 4];
    _turno++;
    return RespuestaTutor('$animo Thanks for sharing.',
        correcciones: correcciones, siguientePregunta: pregunta);
  }

  @override
  Future<RespuestaTutor> corregir(
      {required NivelCefr nivel, required String texto}) async {
    final correcciones = _detectar(texto);
    var corregido = texto.trim();
    for (final c in correcciones) {
      corregido = corregido.replaceFirst(c.original, c.corregido);
    }
    return RespuestaTutor(
      correcciones.isEmpty
          ? 'Well done! I found no mistakes.'
          : 'Good effort! Check these corrections.',
      correcciones: correcciones,
      textoCorregido: corregido,
      siguientePregunta: 'Write 3 sentences about your best day.',
    );
  }
}