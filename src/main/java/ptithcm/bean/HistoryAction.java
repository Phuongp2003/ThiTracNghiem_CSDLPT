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

    public Boolean undo() {
        Action<?> action = null;
        try {
            if (!this.undoStack.isEmpty()) {
                action = this.undoStack.pop();
                if (!action.execute()) {
                    throw new Exception("Action báo: thực thi lệnh thất bại!");
                }
                this.redoStack.push(action.getRevertAction());
            } else {
                throw new Exception("HistoryAction.java: Không thể hoàn tác!");
            }
        } catch (Exception e) {
            System.out.println(
                    "HistoryAction.java: Hoàn tác thất bại:\nAction: "
                            + (action != null ? action : "No action")
                            + "\nE: "
                            + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return true;
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
