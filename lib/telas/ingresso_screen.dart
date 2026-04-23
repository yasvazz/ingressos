import 'package:flutter/material.dart';

// ENUM - Tipo de ingresso
enum TipoIngresso { arquibancada, cadeira, camarote }

class IngressoScreen extends StatefulWidget {
  const IngressoScreen({super.key});

  @override
  State<IngressoScreen> createState() => _IngressoScreenState();
}

class _IngressoScreenState extends State<IngressoScreen> {
  // --- VARIÁVEIS DE ESTADO ---
  String jogoSelecionado = 'Palmeiras vs Corinthians';
  TipoIngresso tipoSelecionado = TipoIngresso.arquibancada;

  final List<String> jogos = [
    'Palmeiras vs Corinthians',
    'São Paulo vs Santos',
    'Flamengo vs Fluminense',
  ];

  final TextEditingController _nomeController = TextEditingController();

  bool estacionamento = false;
  bool lancheIncluso = false;
  bool camisaDoTime = false;
  bool acessoAoLounge = false;
  bool torceParaCasa = true;
  int quantidade = 1;
  bool mostrarResumo = false;

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  double calcularTotal() {
    double total = 0;

    switch (tipoSelecionado) {
      case TipoIngresso.arquibancada:
        total += 50;
        break;
      case TipoIngresso.cadeira:
        total += 90;
        break;
      case TipoIngresso.camarote:
        total += 160;
        break;
    }

    if (estacionamento) total += 50;
    if (lancheIncluso) total += 20;
    if (acessoAoLounge) total += 90;

    return total * quantidade;
  }

  Widget _telaFormulario() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DROPDOWN - Jogo
          const Text('Jogo'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: jogoSelecionado,
            isExpanded: true,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
            items: jogos.map((jogo) {
              return DropdownMenuItem(value: jogo, child: Text(jogo));
            }).toList(),
            onChanged: (valor) {
              setState(() => jogoSelecionado = valor!);
            },
          ),

          const SizedBox(height: 16),

          // TEXTFIELD - Nome do torcedor
          TextField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome do torcedor',
              border: UnderlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          // RADIOBUTTON - Tipo de ingresso
          const Text('Tipo de ingresso'),
          RadioListTile<TipoIngresso>(
            value: TipoIngresso.arquibancada,
            groupValue: tipoSelecionado,
            title: const Text('Arquibancada'),
            onChanged: (v) => setState(() => tipoSelecionado = v!),
          ),
          RadioListTile<TipoIngresso>(
            value: TipoIngresso.cadeira,
            groupValue: tipoSelecionado,
            title: const Text('Cadeira'),
            onChanged: (v) => setState(() => tipoSelecionado = v!),
          ),
          RadioListTile<TipoIngresso>(
            value: TipoIngresso.camarote,
            groupValue: tipoSelecionado,
            title: const Text('Camarote'),
            onChanged: (v) => setState(() => tipoSelecionado = v!),
          ),

          const SizedBox(height: 8),
          const Text('Serviços adicionais'),

          CheckboxListTile(
            title: const Text('Estacionamento'),
            value: estacionamento,
            onChanged: (v) => setState(() => estacionamento = v!),
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          CheckboxListTile(
            title: const Text('Lanche incluso'),
            value: lancheIncluso,
            onChanged: (v) => setState(() => lancheIncluso = v!),
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          CheckboxListTile(
            title: const Text('Camisa do time'),
            value: camisaDoTime,
            onChanged: (v) => setState(() => camisaDoTime = v!),
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          CheckboxListTile(
            title: const Text('Acesso ao lounge'),
            value: acessoAoLounge,
            onChanged: (v) => setState(() => acessoAoLounge = v!),
            controlAffinity: ListTileControlAffinity.trailing,
          ),

          SwitchListTile(
            title: const Text('Torcer para o time da casa'),
            value: torceParaCasa,
            onChanged: (v) => setState(() => torceParaCasa = v),
          ),

          const SizedBox(height: 8),
          Text('Quantidade: $quantidade'),
          Slider(
            value: quantidade.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            label: '$quantidade',
            onChanged: (v) => setState(() => quantidade = v.toInt()),
          ),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => setState(() => mostrarResumo = true),
              child: const Text('Comprar ingressos'),
            ),
          ),
        ],
      ),
    );
  }

 Widget _telaResumo() {
  final torcida = torceParaCasa ? 'Casa' : 'Visitante';
  final tipoNome = tipoSelecionado.name[0].toUpperCase() + 
                   tipoSelecionado.name.substring(1);
  
  List<String> servicosSelecionados = [];
  if (estacionamento) servicosSelecionados.add('Estacionamento');
  if (lancheIncluso) servicosSelecionados.add('Lanche');
  if (camisaDoTime) servicosSelecionados.add('Camisa do time');
  if (acessoAoLounge) servicosSelecionados.add('Acesso ao lounge');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Resumo da compra',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

        const SizedBox(height: 16),

        // IMAGENS DOS TIMES
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/png-palmeiras.png', width: 80),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('VS', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Image.asset('assets/images/corinthians.png', width: 80),
          ],
        ),

        const SizedBox(height: 16),

        Text('Nome: ${_nomeController.text}'),
        Text('Jogo: $jogoSelecionado'),
        Text('Ingresso: $tipoNome'),
        Text('Quantidade: $quantidade'),
        Text('Torcida: $torcida'),
        Text('Serviços: ${servicosSelecionados.isEmpty ? 'Nenhum' : servicosSelecionados.join(', ')}'),

        const SizedBox(height: 16),
        Text('Total: R\$ ${calcularTotal().toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => setState(() => mostrarResumo = false),
            child: const Text('Voltar'),
          ),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.sports_soccer),
        title: const Text('Ingressos para o Jogo'),
      ),
      body: mostrarResumo ? _telaResumo() : _telaFormulario(),
    );
  }
}