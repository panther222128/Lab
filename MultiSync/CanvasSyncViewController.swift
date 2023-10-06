//
//  CanvasSyncViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/07.
//

import UIKit
import PencilKit

final class CanvasSyncViewController: UIViewController, PKCanvasViewDelegate {
    
    private let debouncer = Debouncer(timeInterval: 0.05)
    var canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    private let toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        return toolPicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvasView)
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        set(toolPicker: toolPicker)
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: UpdateEvents.drawingNotificaitonName, object: nil)
        canvasView.delegate = self
    }
    
    private func set(toolPicker: PKToolPicker) {
        canvasView.becomeFirstResponder()
        toolPicker.setVisible(true, forFirstResponder: self.canvasView)
        toolPicker.addObserver(canvasView)
    }
    
    @objc func handle(notification: Notification) {
        guard let event = notification.object as? UpdateEvents else { return }

        switch event {
        case .draw(let drawing):
            do {
                self.canvasView.drawing = try PKDrawing(data: drawing.drawing)
            } catch {
                
            }
            
        }
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        debouncer.renewInterval()
        debouncer.handler = {
            let drawing = canvasView.drawing
            DrawingModelController.shared.update(drawing: .init(drawing: drawing.dataRepresentation()))
        }
    }
}

final class DrawingModelController {
    static let shared = DrawingModelController()

    func update(drawing: Drawing) {
        let event = UpdateEvents.draw(drawing: drawing)
        event.post()
    }
}

struct Drawing {
    let drawing: Data
}

enum UpdateEvents {
    case draw(drawing: Drawing)
    
    static let drawingNotificaitonName = Notification.Name(rawValue: "Drawing")
    
    func post() {
        switch self {
        case .draw(drawing: _):
            NotificationCenter.default.post(name: UpdateEvents.drawingNotificaitonName, object: self)
            
        }
    }
}
