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

    def calcScore(self, lastCalled):
        def sumUnmarked():
            sum = 0
            for i in range(0, len(self.layout)):
                for j in range(len(self.layout[i])):
                    if not self.layout[i][j] in self.called:
                        sum += int(self.layout[i][j])
            return sum
        return sumUnmarked() * int(lastCalled)

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
print(draws)

for draw in draws:
    for board in boards:
        board.called.append(draw)
        if board.hasWon():
            print("Total is: " + str(board.calcScore(draw)))
            exit(0)
