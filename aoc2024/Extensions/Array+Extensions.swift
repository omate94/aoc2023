extension Array where Element: Collection, Element.Index == Int {
    func getColumn(column : Element.Index) -> [ Element.Iterator.Element ] {
        return self.map { $0[column] }
    }
    
    func getDiagonals(for element: (row: Int, col: Int)) -> ([Any], [Any]) {
        let rowCount = self.count
        guard rowCount > 0 else { return ([], []) }
        let colCount = self[0].count
        guard element.row >= 0, element.row < rowCount, element.col >= 0, element.col < colCount else { return ([], []) }
        
        var mainDiagonal: [Any] = []
        var antiDiagonal: [Any] = []
        
        var i = element.row
        var j = element.col
        while i >= 0, j >= 0 {
            mainDiagonal.append(self[i][j])
            i -= 1
            j -= 1
        }
        i = element.row + 1
        j = element.col + 1
        while i < rowCount, j < colCount {
            mainDiagonal.append(self[i][j])
            i += 1
            j += 1
        }
        
        i = element.row
        j = element.col
        while i >= 0, j < colCount {
            antiDiagonal.insert(self[i][j], at: 0)
            i -= 1
            j += 1
        }
        i = element.row + 1
        j = element.col - 1
        while i < rowCount, j >= 0 {
            antiDiagonal.append(self[i][j])
            i += 1
            j -= 1
        }
        
        return (mainDiagonal, antiDiagonal)
    }
}
