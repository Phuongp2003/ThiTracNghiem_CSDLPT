package ptithcm.DAO;

public interface Action<T> {
    String getType();

    T getOldData();

    void setOldData(T oldData);

    T getData();

    void setType(String type);

    void setData(T data);

    Action<T> getRevertAction();

    Boolean execute();

    String toString();
}
