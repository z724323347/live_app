import 'dart:async';
import 'dart:io';
import 'package:adhara_socket_io/adhara_socket_io.dart';

/// 彩票开奖事件
class LotteryPublishEvent {
  /// 彩种
  final String category;

  /// 期号
  final String issue;

  /// 开奖结果
  final String result;

  LotteryPublishEvent({this.category, this.issue, this.result});
}

/// 彩票中奖事件
class LotteryWinEvent {
  /// 中奖用户
  final String name;

  /// 中奖的彩种
  final String category;

  /// 中奖玩法
  final String play;

  /// 中奖金额
  final num winAmount;

  LotteryWinEvent({this.name, this.category, this.play, this.winAmount});
}

class UpdateBalanceEvent {
  // 玩家姓名
  final String name;

  /// 余额
  final String finishedAmount;
  UpdateBalanceEvent({this.finishedAmount, this.name});
}

/// 充值到账事件
class DepositEvent {
  // 充值金额
  final String amount;
  // 充值订单
  final String billno;
  // 玩家姓名
  final String name;

  DepositEvent({this.amount, this.billno, this.name});
}

class UpdateEsportEvent {
  // 竞猜项
  final List<UpdateGuess> guess;

  // 竞猜子项
  final List<UpdateGuessItem> item;

  // 比赛
  final List<UpdateGame> game;

  UpdateEsportEvent({this.guess, this.item, this.game});
}

class UpdateGame {
  // 比赛id
  final String gameId;

  // 比赛状态（0-未开始，1-进行中，2-已结束）
  final String gameStatus;

  // A队伍得分
  final String scoreA;

  // B队伍得分
  final String scoreB;

  // 是否支持滚盘（0-不支持，1-支持）
  final num haveRoll;

  UpdateGame(
      {this.gameId, this.gameStatus, this.scoreA, this.scoreB, this.haveRoll});
}

class UpdateGuess {
  // 竞猜项投注状态（0-锁盘，1-可投注）
  final int betActive;

  // 竞猜项id
  final int id;

  // 是否为滚盘竞猜项（0-不是，1-是）
  final num isRoll;

  // 竞猜项所对应的比赛id
  final num gameId;

  UpdateGuess({this.betActive, this.id, this.isRoll, this.gameId});
}

class UpdateGuessItem {
  // 竞猜子项状态（0-进行中，1-已结束）
  final String status;

  // 竞猜子项赔率
  final String odds;

  // 竞猜子项id
  final num id;

  // 竞猜子项投注状态（0-封盘，1-可投注）
  final bool oddsStatus;

  // 竞猜子项输赢状态（0-输，1-赢）
  final String win;

  // 竞猜项id
  final num guessId;

  UpdateGuessItem(
      {this.status,
      this.odds,
      this.id,
      this.oddsStatus,
      this.win,
      this.guessId});
}

/// 发红包
class SentEvent {
  /// 发红包数据
  final Map sentData;
  SentEvent({this.sentData});
}

/// 抢红包
class ReceivedEvent {
  /// 抢红包数据
  final Map receivedData;
  /// 其他抢包人
  final List<dynamic> receivers;
  ReceivedEvent({this.receivedData, this.receivers});
}

/// 获取新的站内信事件
class LetterReceiveEvent {
  /// 信件ID
  final num id;
  /// 信件标题
  final String subject;
  /// 信件内容
  final String content;
  /// 信件内容
  final String updatedAt;
  /// 信件内容
  final String sender;
  LetterReceiveEvent({this.id, this.subject, this.content, this.updatedAt, this.sender});
}

class SocketData {
  SocketIO socket;

  static SocketData _instance;

  final StreamController<LotteryPublishEvent> _onLotteryPublish =
      StreamController<LotteryPublishEvent>.broadcast();

  final StreamController<UpdateBalanceEvent> _onBalanceUpdate =
      StreamController<UpdateBalanceEvent>.broadcast();

  final StreamController<DepositEvent> _onDepositEvent =
      StreamController<DepositEvent>.broadcast();

  final StreamController<UpdateEsportEvent> _onEsportUpdate =
      StreamController<UpdateEsportEvent>.broadcast();

  final StreamController<LotteryWinEvent> _onLotteryWin =
      StreamController<LotteryWinEvent>.broadcast();

  final StreamController<SentEvent> _onSentRedPocket = StreamController<SentEvent>.broadcast();

  final StreamController<ReceivedEvent> _onReceivedRedPocket = StreamController<ReceivedEvent>.broadcast();

  final StreamController<LetterReceiveEvent> _onLetterReceive = StreamController<LetterReceiveEvent>.broadcast();

  /// 彩票开奖事件
  Stream<LotteryPublishEvent> get onLotteryPublish {
    return this._onLotteryPublish.stream;
  }

  /// 彩票中奖事件
  Stream<LotteryWinEvent> get onLotteryWin {
    return this._onLotteryWin.stream;
  }

  /// 余额变化事件
  Stream<UpdateBalanceEvent> get onBalanceUpdate {
    return this._onBalanceUpdate.stream;
  }

  /// 充值金额事件
  Stream<DepositEvent> get onDepositEvent {
    return this._onDepositEvent.stream;
  }

  /// 电竞变化事件
  Stream<UpdateEsportEvent> get onEsportUpdate {
    return this._onEsportUpdate.stream;
  }

  /// 发红包事件
  Stream<SentEvent> get onSentRedPocket {
    return this._onSentRedPocket.stream;
  }

  /// 抢红包事件
  Stream<ReceivedEvent> get onReceivedRedPocket {
    return this._onReceivedRedPocket.stream;
  }

  /// 信件接收事件
  Stream<LetterReceiveEvent> get onLetterReceive {
    return this._onLetterReceive.stream;
  }

  factory SocketData() => _instance ??= SocketData._();

  SocketData._();

  get isConnected => socket != null;

  Future<void> connect(String url, String siteSign, [String username]) async {
    if (socket != null) {
      return null;
    }
    Uri u = Uri.parse(url);
    String port = u.hasPort ? ':${u.port}' : '';
    socket = await SocketIOManager().createInstance(SocketOptions(
        '${u.scheme}://${u.host}${Platform.isAndroid ? "/" : "/notify"}$port',
        query: {"source": siteSign, "name": username ?? ''},
        enableLogging: false));
    socket.on("balchange", (msg) {
      var data = msg['data'];
      _onBalanceUpdate.add(new UpdateBalanceEvent(
        name: data['name'],
        finishedAmount: data['balance_finished'].toString(),
      ));
    });

    socket.on("deposit", (msg) {
      print('deposit $msg');
      var data = msg['data'];
      _onDepositEvent.add(new DepositEvent(
        name: data['name'],
        billno: data['billno'],
        amount: data['amount'],
      ));
    });

    socket.on("bet", (msg) {
      var data = msg['data'];
    });

    socket.on("esport_batch", handleEsportEvent);

    socket.on("withdrawal", (msg) {
      print('withdrawa; $msg');
      var data = msg['data'];
    });

    socket.on("lottery_draw", (msg) {
      Map data = msg['data'];

      _onLotteryPublish.add(new LotteryPublishEvent(
          category: data['category'],
          issue: data['issue'],
          result: data['result']));
    });

    socket.on("jackpot", (msg) {
      var data = msg['data'];
      _onLotteryWin.add(new LotteryWinEvent(
          category: data['category'],
          play: data['play'],
          name: data['name'],
          winAmount: data['win_amount']));
    });

    /// 发红包
    socket.on("red_envelope_sent", (msg) {
      print('red_envelope_sent $msg');
      _onSentRedPocket.add(
        SentEvent(sentData: msg['data']['red_envelope'])
      );
    });

    /// 抢红包
    socket.on("red_envelope_received", (msg) {
      print('red_envelope_received $msg');
      _onReceivedRedPocket.add(
        ReceivedEvent(
          receivedData: msg['data']['red_envelope'],
          receivers: msg['data']['receivers'],
        )
      );
    });

    /// 新站内信
    socket.on("letter", (msg) {
      Map data = msg['data'];
      _onLetterReceive.add(LetterReceiveEvent(
          id: data['id'],
          updatedAt: data['updated_at'],
          sender: data['sender'],
          subject: data['subject'],
          content: data['content']
      ));
    });

    /// 订阅频道
    socket.onConnect((_) {
      socket?.emit('subscribe', [['red_envelope']]);
      socket?.emit('subscribe', ['common']);
      socket?.emit('subscribe', ['lottery']);
    });

    socket.connect();
  }

  void handleEsportEvent(msg) {
    Map data = msg['data'];
    Map _item = data['esport_guess_item'];
    Map _game = data['esport_game'];
    Map _guess = data['esport_guess'];
    List<UpdateGame> games = [];
    List<UpdateGuessItem> guessItems = [];
    List<UpdateGuess> guesses = [];
    if (_item != null) {
      _item.forEach((k, v) {
        guessItems.add(UpdateGuessItem(
            status: v['status'],
            odds: v['odds'],
            id: v['id'],
            oddsStatus: v['odds_status'],
            win: v['win'],
            guessId: v['guess_id']));
      });
    }
    if (_guess != null) {
      _guess.forEach((k, v) {
        guesses.add(UpdateGuess(
            betActive: v['bet_active'],
            id: v['id'],
            isRoll: v['is_roll'],
            gameId: v['game_id']));
      });
    }
    if (_game != null) {
      _game.forEach((k, v) {
        games.add(UpdateGame(
            gameId: k.toString(),
            gameStatus: v['game_status'],
            scoreA: v['score_a'],
            scoreB: v['score_b'],
            haveRoll: v['have_roll']));
      });
    }
    _onEsportUpdate.add(
        new UpdateEsportEvent(game: games, item: guessItems, guess: guesses));
  }

  Future<void> disconnect() async {
    if (socket == null) {
      return null;
    }
    SocketIO _socket = socket;
    /// 退出频道
    socket?.emit('unsubscribe', [['red_envelope']]);
    socket?.emit('unsubscribe', ['common']);
    socket?.emit('unsubscribe', ['lottery']);
    print('socket disconnect');
    socket = null;
    SocketIOManager().clearInstance(_socket);
  }

  Future<void> reconnect(String url, String siteSign, [String username]) async {
    await disconnect();
    await connect(url, siteSign, username);
  }

  Future<void> dispose() {
    _instance = null;
    return disconnect();
  }
}

// game: 'game_status','score_a','score_b','roll_active','have_roll',
// guess: 'bet_active',''
