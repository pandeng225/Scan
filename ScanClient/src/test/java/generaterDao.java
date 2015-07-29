import de.greenrobot.daogenerator.DaoGenerator;
import de.greenrobot.daogenerator.Entity;
import de.greenrobot.daogenerator.Schema;

import java.io.File;

/**
 * Created by pandeng on 2015/7/24.
 */
public class generaterDao {
    public static void main(String[] args) throws Exception {
        Schema schema = new Schema(1, "com.ca.scan.dao");
        addProfile(schema);
        addHistory(schema);
        addDescHistory(schema);
        new DaoGenerator().generateAll(schema, "D:\\WorkPlace\\Scan\\ScanClient\\src\\main\\java\\");


    }


    private static void addProfile(Schema schema) {
        Entity Profile = schema.addEntity("Profile");
        Profile.addIdProperty();
        Profile.addStringProperty("name").notNull();
        Profile.addStringProperty("department").notNull();
        Profile.addStringProperty("employeeid");
        Profile.addDateProperty("date");
    }

    private static void addHistory(Schema schema) {
        Entity History = schema.addEntity("HistoryActivity");
        History.addIdProperty();
        History.addStringProperty("name").notNull();
        History.addStringProperty("department").notNull();
        History.addStringProperty("employeeid");
        History.addStringProperty("filename");
        History.addStringProperty("desc");
        History.addDateProperty("date");
    }

    private static void addDescHistory(Schema schema) {
        Entity DescHistory = schema.addEntity("DescHistory");
        DescHistory.addIdProperty();
        DescHistory.addStringProperty("name").notNull();
        DescHistory.addStringProperty("department").notNull();
        DescHistory.addStringProperty("employeeid");
        DescHistory.addStringProperty("desc");
    }
}
