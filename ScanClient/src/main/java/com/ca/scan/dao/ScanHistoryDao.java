package com.ca.scan.dao;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteStatement;
import de.greenrobot.dao.AbstractDao;
import de.greenrobot.dao.Property;
import de.greenrobot.dao.internal.DaoConfig;

// THIS CODE IS GENERATED BY greenDAO, DO NOT EDIT.
/** 
 * DAO for table SCAN_HISTORY.
*/
public class ScanHistoryDao extends AbstractDao<ScanHistory, Long> {

    public static final String TABLENAME = "SCAN_HISTORY";

    /**
     * Properties of entity ScanHistory.<br/>
     * Can be used for QueryBuilder and for referencing column names.
    */
    public static class Properties {
        public final static Property Id = new Property(0, Long.class, "id", true, "_id");
        public final static Property Name = new Property(1, String.class, "name", false, "NAME");
        public final static Property Department = new Property(2, String.class, "department", false, "DEPARTMENT");
        public final static Property Employeeid = new Property(3, String.class, "employeeid", false, "EMPLOYEEID");
        public final static Property Expressno = new Property(4, String.class, "expressno", false, "EXPRESSNO");
        public final static Property Filename = new Property(5, String.class, "filename", false, "FILENAME");
        public final static Property Ifupload = new Property(6, String.class, "ifupload", false, "IFUPLOAD");
        public final static Property Desc = new Property(7, String.class, "desc", false, "DESC");
        public final static Property Date = new Property(8, java.util.Date.class, "date", false, "DATE");
    };


    public ScanHistoryDao(DaoConfig config) {
        super(config);
    }
    
    public ScanHistoryDao(DaoConfig config, DaoSession daoSession) {
        super(config, daoSession);
    }

    /** Creates the underlying database table. */
    public static void createTable(SQLiteDatabase db, boolean ifNotExists) {
        String constraint = ifNotExists? "IF NOT EXISTS ": "";
        db.execSQL("CREATE TABLE " + constraint + "'SCAN_HISTORY' (" + //
                "'_id' INTEGER PRIMARY KEY ," + // 0: id
                "'NAME' TEXT NOT NULL ," + // 1: name
                "'DEPARTMENT' TEXT NOT NULL ," + // 2: department
                "'EMPLOYEEID' TEXT," + // 3: employeeid
                "'EXPRESSNO' TEXT NOT NULL ," + // 4: expressno
                "'FILENAME' TEXT," + // 5: filename
                "'IFUPLOAD' TEXT," + // 6: ifupload
                "'DESC' TEXT," + // 7: desc
                "'DATE' INTEGER);"); // 8: date
    }

    /** Drops the underlying database table. */
    public static void dropTable(SQLiteDatabase db, boolean ifExists) {
        String sql = "DROP TABLE " + (ifExists ? "IF EXISTS " : "") + "'SCAN_HISTORY'";
        db.execSQL(sql);
    }

    /** @inheritdoc */
    @Override
    protected void bindValues(SQLiteStatement stmt, ScanHistory entity) {
        stmt.clearBindings();
 
        Long id = entity.getId();
        if (id != null) {
            stmt.bindLong(1, id);
        }
        stmt.bindString(2, entity.getName());
        stmt.bindString(3, entity.getDepartment());
 
        String employeeid = entity.getEmployeeid();
        if (employeeid != null) {
            stmt.bindString(4, employeeid);
        }
        stmt.bindString(5, entity.getExpressno());
 
        String filename = entity.getFilename();
        if (filename != null) {
            stmt.bindString(6, filename);
        }
 
        String ifupload = entity.getIfupload();
        if (ifupload != null) {
            stmt.bindString(7, ifupload);
        }
 
        String desc = entity.getDesc();
        if (desc != null) {
            stmt.bindString(8, desc);
        }
 
        java.util.Date date = entity.getDate();
        if (date != null) {
            stmt.bindLong(9, date.getTime());
        }
    }

    /** @inheritdoc */
    @Override
    public Long readKey(Cursor cursor, int offset) {
        return cursor.isNull(offset + 0) ? null : cursor.getLong(offset + 0);
    }    

    /** @inheritdoc */
    @Override
    public ScanHistory readEntity(Cursor cursor, int offset) {
        ScanHistory entity = new ScanHistory( //
            cursor.isNull(offset + 0) ? null : cursor.getLong(offset + 0), // id
            cursor.getString(offset + 1), // name
            cursor.getString(offset + 2), // department
            cursor.isNull(offset + 3) ? null : cursor.getString(offset + 3), // employeeid
            cursor.getString(offset + 4), // expressno
            cursor.isNull(offset + 5) ? null : cursor.getString(offset + 5), // filename
            cursor.isNull(offset + 6) ? null : cursor.getString(offset + 6), // ifupload
            cursor.isNull(offset + 7) ? null : cursor.getString(offset + 7), // desc
            cursor.isNull(offset + 8) ? null : new java.util.Date(cursor.getLong(offset + 8)) // date
        );
        return entity;
    }
     
    /** @inheritdoc */
    @Override
    public void readEntity(Cursor cursor, ScanHistory entity, int offset) {
        entity.setId(cursor.isNull(offset + 0) ? null : cursor.getLong(offset + 0));
        entity.setName(cursor.getString(offset + 1));
        entity.setDepartment(cursor.getString(offset + 2));
        entity.setEmployeeid(cursor.isNull(offset + 3) ? null : cursor.getString(offset + 3));
        entity.setExpressno(cursor.getString(offset + 4));
        entity.setFilename(cursor.isNull(offset + 5) ? null : cursor.getString(offset + 5));
        entity.setIfupload(cursor.isNull(offset + 6) ? null : cursor.getString(offset + 6));
        entity.setDesc(cursor.isNull(offset + 7) ? null : cursor.getString(offset + 7));
        entity.setDate(cursor.isNull(offset + 8) ? null : new java.util.Date(cursor.getLong(offset + 8)));
     }
    
    /** @inheritdoc */
    @Override
    protected Long updateKeyAfterInsert(ScanHistory entity, long rowId) {
        entity.setId(rowId);
        return rowId;
    }
    
    /** @inheritdoc */
    @Override
    public Long getKey(ScanHistory entity) {
        if(entity != null) {
            return entity.getId();
        } else {
            return null;
        }
    }

    /** @inheritdoc */
    @Override    
    protected boolean isEntityUpdateable() {
        return true;
    }
    
}