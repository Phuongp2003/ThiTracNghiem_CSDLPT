package ptithcm.bean;

import java.util.Stack;
import ptithcm.DAO.Action;

public class HistoryAction {
    private Stack<Action<?>> undoStack;
    private Stack<Action<?>> redoStack;

    public HistoryAction() {
        this.undoStack = new Stack<>();
        this.redoStack = new Stack<>();
    }

    public void addAction(Action<?> action) {
        this.undoStack.push(action.getRevertAction());
        this.redoStack.clear(); // Clear redo stack on new action
    }

    public void undo() {
        if (!this.undoStack.isEmpty()) {
            Action<?> action = this.undoStack.pop();
            action.execute();
            this.redoStack.push(action.getRevertAction());
        }
    }

    public void redo() {
        if (!this.redoStack.isEmpty()) {
            Action<?> action = this.redoStack.pop();
            action.execute();
            this.undoStack.push(action.getRevertAction());
        }
    }

    public boolean canUndo() {
        return !this.undoStack.isEmpty();
    }

    public boolean canRedo() {
        return !this.redoStack.isEmpty();
    }

    @Override
    public String toString() {
        return "HistoryAction{undoStack=" + this.undoStack + ", redoStack=" + this.redoStack + '}';
    }
}
