class Board:
    def __init__(self, layout, called, name):
        self.layout = layout
        self.called = called
        self.name = name

    def hasWon(self):
        for i in range(0, len(self.layout)):
            if self.checkAcross(i):
                print("Won Across")
                return True
            elif self.checkDown(i):
                print("Won Down")
                return True
            elif self.checkDiagonals():
                print("Won Diag")
                return True
        return False
    
    def checkAcross(self, i):
        for j in range(0, len(self.layout[i])):
            if not self.layout[i][j] in self.called:
                return False
        return True

    def checkDown(self, i):
        for j in range(0, len(self.layout[0])):
            if not self.layout[j][i] in self.called:
                return False
        return True
    
    def checkDiagonals(self):
        def checkLeft():
            for i in range(0, len(self.layout)):
                if not self.layout[i][i] in self.called:
                    return False
            return True
        def checkRight():
            x = 0
            for i in range(len(self.layout) -1, -1, -1):
                if not self.layout[i][x] in self.called:
                    return False
                x+=1
            return True
        return checkLeft() or checkRight()

def makeBoards():
    with open("./python/files/board.txt") as f:
        calls = [] #Todo: Clean this up
        boards = []
        curBoard = []
        name = 0
        for (i, line) in enumerate(f.readlines()):
            if i == 0:
                calls = line.split(',')
            elif line == '\n' and i == 1:
                continue
            elif line == '\n' and i != 1:
                boards.append(Board(curBoard, [], name))
                curBoard = []
                name +=1
            else:
                line = line.replace('\n', '')
                line = ' '.join(line.split())
                curBoard.append(line.split(' '))
        boards.append(Board(curBoard, [], name))
        return (calls, boards)

[draws, boards] = makeBoards()
for draw in draws:
    for board in boards:
        board.called.append(draw)
        if board.hasWon():
            print("Board " + str(board.name) + " has Won after " + draw)
            exit(0)
