package com.ca.scan.dao;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteStatement;

import de.greenrobot.dao.AbstractDao;
import de.greenrobot.dao.Property;
import de.greenrobot.dao.internal.DaoConfig;

import com.ca.scan.dao.Profile;

// THIS CODE IS GENERATED BY greenDAO, DO NOT EDIT.
/** 
 * DAO for table PROFILE.
*/
public class ProfileDao extends AbstractDao<Profile, Long> {

    public static final String TABLENAME = "PROFILE";

    /**
     * Properties of entity Profile.<br/>
     * Can be used for QueryBuilder and for referencing column names.
    */
    public static class Properties {
        public final static Property Id = new Property(0, Long.class, "id", true, "_id");
        public final static Property Name = new Property(1, String.class, "name", false, "NAME");
        public final static Property Department = new Property(2, String.class, "department", false, "DEPARTMENT");
        public final static Property Employeeid = new Property(3, String.class, "employeeid", false, "EMPLOYEEID");
        public final static Property Date = new Property(4, java.util.Date.class, "date", false, "DATE");
    };


    public ProfileDao(DaoConfig config) {
        super(config);
    }
    
    public ProfileDao(DaoConfig config, DaoSession daoSession) {
        super(config, daoSession);
    }

    /** Creates the underlying database table. */
    public static void createTable(SQLiteDatabase db, boolean ifNotExists) {
        String constraint = ifNotExists? "IF NOT EXISTS ": "";
        db.execSQL("CREATE TABLE " + constraint + "'PROFILE' (" + //
                "'_id' INTEGER PRIMARY KEY ," + // 0: id
                "'NAME' TEXT NOT NULL ," + // 1: name
                "'DEPARTMENT' TEXT NOT NULL ," + // 2: department
                "'EMPLOYEEID' TEXT," + // 3: employeeid
                "'DATE' INTEGER);"); // 4: date
    }

    /** Drops the underlying database table. */
    public static void dropTable(SQLiteDatabase db, boolean ifExists) {
        String sql = "DROP TABLE " + (ifExists ? "IF EXISTS " : "") + "'PROFILE'";
        db.execSQL(sql);
    }

    /** @inheritdoc */
    @Override
    protected void bindValues(SQLiteStatement stmt, Profile entity) {
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
 
        java.util.Date date = entity.getDate();
        if (date != null) {
            stmt.bindLong(5, date.getTime());
        }
    }

    /** @inheritdoc */
    @Override
    public Long readKey(Cursor cursor, int offset) {
        return cursor.isNull(offset + 0) ? null : cursor.getLong(offset + 0);
    }    

    /** @inheritdoc */
    @Override
    public Profile readEntity(Cursor cursor, int offset) {
        Profile entity = new Profile( //
            cursor.isNull(offset + 0) ? null : cursor.getLong(offset + 0), // id
            cursor.getString(offset + 1), // name
            cursor.getString(offset + 2), // department
            cursor.isNull(offset + 3) ? null : cursor.getString(offset + 3), // employeeid
            cursor.isNull(offset + 4) ? null : new java.util.Date(cursor.getLong(offset + 4)) // date
        );
        return entity;
    }
     
    /** @inheritdoc */
    @Override
    public void readEntity(Cursor cursor, Profile entity, int offset) {
        entity.setId(cursor.isNull(offset + 0) ? null : cursor.getLong(offset + 0));
        entity.setName(cursor.getString(offset + 1));
        entity.setDepartment(cursor.getString(offset + 2));
        entity.setEmployeeid(cursor.isNull(offset + 3) ? null : cursor.getString(offset + 3));
        entity.setDate(cursor.isNull(offset + 4) ? null : new java.util.Date(cursor.getLong(offset + 4)));
     }
    
    /** @inheritdoc */
    @Override
    protected Long updateKeyAfterInsert(Profile entity, long rowId) {
        entity.setId(rowId);
        return rowId;
    }
    
    /** @inheritdoc */
    @Override
    public Long getKey(Profile entity) {
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
