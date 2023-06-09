Attribute VB_Name = "Module1"
Sub StockInfo()
 For Each ws In Worksheets
    
        Dim WorksheetName As String
        Dim i As Long
        Dim j As Long
        Dim TickCount As Long
        Dim LastRowA As Long
        Dim LastRowI As Long
        Dim PerChange As Double
        Dim GreatIncr As Double
        Dim GreatDecr As Double
        Dim GreatVol As Double


        'Get Worksheet Name
        WorksheetName = ws.Name

        'Add new column values
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Yearly Change"
        ws.Cells(1, 11).Value = "Percent Change"
        ws.Cells(1, 12).Value = "Total Stock Volume"
        ws.Cells(1, 16).Value = "Ticker"
        ws.Cells(1, 17).Value = "Value"
        ws.Cells(2, 15).Value = "Greatest % Increase"
        ws.Cells(3, 15).Value = "Greatest % Decrease"
        ws.Cells(4, 15).Value = "Greatest Total Volume"
        
        'Ticker counter
        TickCount = 2
        
        'Set start row to 2
        j = 2
        
        'Find the last populated cell
        LastRowA = ws.Cells(Rows.Count, 1).End(xlUp).Row
       
        
            'Create loop
            For i = 2 To LastRowA
            
                'Was ticker name changed?
                If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                
                'Put ticker in column I (#9)
                ws.Cells(TickCount, 9).Value = ws.Cells(i, 1).Value
                
                'Calculate and put Yearly Change in cell J10
                ws.Cells(TickCount, 10).Value = ws.Cells(i, 6).Value - ws.Cells(j, 3).Value
                
                    'Conditional formating1
                    If ws.Cells(TickCount, 10).Value < 0 Then
                
                    'Cell background color to red
                    ws.Cells(TickCount, 10).Interior.Color = vbRed
                
                    Else
                
                    'Cell background color to green
                    ws.Cells(TickCount, 10).Interior.Color = vbGreen
                
                    End If
                    
                    'Calculate and put percent change in cell K11
                    If ws.Cells(j, 3).Value <> 0 Then
                    PerChange = ((ws.Cells(i, 6).Value - ws.Cells(j, 3).Value) / ws.Cells(j, 3).Value)
                    
                    'Percent formating1
                    ws.Cells(TickCount, 11).Value = Format(PerChange, "Percent")
                    
                    Else
                    
                    ws.Cells(TickCount, 11).Value = Format(0, "Percent")
                    
                    End If
                    
                'Calculate and put total volume in cell L12
                ws.Cells(TickCount, 12).Value = WorksheetFunction.Sum(Range(ws.Cells(j, 7), ws.Cells(i, 7)))
                
                'Increase TickCount value by 1
                TickCount = TickCount + 1
                
                'Put new start row of the ticker block
                j = i + 1
                
                End If
            
Next i
            
        'Find last populated cell in column I
        LastRowI = ws.Cells(Rows.Count, 9).End(xlUp).Row
        
        
        'Summary table
        GreatVol = ws.Cells(2, 12).Value
        GreatIncr = ws.Cells(2, 11).Value
        GreatDecr = ws.Cells(2, 11).Value
        
            'Loop for summary table
            For i = 2 To LastRowI
            
                'check if next value is larger--if yes take over a new value and populate ws.Cells
                If ws.Cells(i, 12).Value > GreatVol Then
                GreatVol = ws.Cells(i, 12).Value
                ws.Cells(4, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatVol = GreatVol
                
                End If
                
                'checking if next value is larger--if yes take over a new value and populate ws.Cells
                If ws.Cells(i, 11).Value > GreatIncr Then
                GreatIncr = ws.Cells(i, 11).Value
                ws.Cells(2, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatIncr = GreatIncr
                
                End If
                
                'checking if next value is smaller--if yes take over a new value and populate ws.Cells
                If ws.Cells(i, 11).Value < GreatDecr Then
                GreatDecr = ws.Cells(i, 11).Value
                ws.Cells(3, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatDecr = GreatDecr
                
                End If
                
            'Fill in summary results in ws.Cells
            ws.Cells(2, 17).Value = Format(GreatIncr, "Percent")
            ws.Cells(3, 17).Value = Format(GreatDecr, "Percent")
            ws.Cells(4, 17).Value = Format(GreatVol, "Scientific")
            
            Next i
            
        'Adjust column width automatically
        Worksheets(WorksheetName).Columns("A:Z").AutoFit
            
    Next ws
End Sub
