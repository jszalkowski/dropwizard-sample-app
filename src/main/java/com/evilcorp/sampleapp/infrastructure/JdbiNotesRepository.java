package com.evilcorp.sampleapp.infrastructure;

import com.evilcorp.sampleapp.models.Note;
import com.evilcorp.sampleapp.models.NotesRepository;
import org.skife.jdbi.v2.DBI;
import org.skife.jdbi.v2.StatementContext;
import org.skife.jdbi.v2.sqlobject.Bind;
import org.skife.jdbi.v2.sqlobject.SqlQuery;
import org.skife.jdbi.v2.sqlobject.SqlUpdate;
import org.skife.jdbi.v2.sqlobject.customizers.RegisterMapper;
import org.skife.jdbi.v2.tweak.ResultSetMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class JdbiNotesRepository implements NotesRepository {

    private final NoteDAO notes;

    public JdbiNotesRepository(DBI jdbi) {
        notes = jdbi.onDemand(NoteDAO.class);
    }

    public Note findBy(Integer id) {
        return notes.findById(id);
    }

    public List<Note> findAll() {
        return notes.findAll();
    }

    public Note create(String message) {
        Note note = Note.builder().withMessage(message).build();

        synchronized (notes) {
            notes.create(note.getMessage());
            note.setId(notes.lastId());
        }

        return note;
    }

    @RegisterMapper(NoteMapper.class)
    private interface NoteDAO {
        @SqlUpdate("INSERT INTO notes(message) VALUES(:message)")
        void create(@Bind("message") String message);

        @SqlQuery("SELECT id, message FROM notes WHERE id = :id")
        Note findById(@Bind("id") int id);

        @SqlQuery("SELECT id, message FROM notes ORDER BY id DESC")
        List<Note> findAll();

        @SqlQuery("SELECT MAX(id) FROM notes")
        Integer lastId();
    }

    public static class NoteMapper implements ResultSetMapper<Note> {
        public Note map(int i, ResultSet rs, StatementContext statementContext) throws SQLException {
            return Note.builder()
                    .withId(rs.getInt("id"))
                    .withMessage(rs.getString("message"))
                    .build();
        }
    }
}
