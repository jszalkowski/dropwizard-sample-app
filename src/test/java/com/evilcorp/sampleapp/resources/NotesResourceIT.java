package com.evilcorp.sampleapp.resources;

import com.evilcorp.sampleapp.models.Note;
import com.evilcorp.sampleapp.resources.NotesResource;
import io.dropwizard.testing.junit.ResourceTestRule;
import org.junit.ClassRule;
import org.junit.Test;

import javax.ws.rs.core.GenericType;
import java.util.List;

import static javax.ws.rs.client.Entity.text;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

public class NotesResourceIT {

    private static NotesResource resource = mock(NotesResource.class);

    @ClassRule
    public static final ResourceTestRule resources = ResourceTestRule.builder()
            .addResource(resource)
            .build();

    @Test public void
    calls_the_get_method_with_the_path_parameter_of_the_request() throws Exception {
        resources.client().target("/notes/1").request().get(Note.class);

        verify(resource).get(1);
    }

    @Test public void
    calls_the_get_method() throws Exception {
        resources.client().target("/notes/").request().get(new GenericType<List<Note>>() {});

        verify(resource).get();
    }

    @Test public void
    calls_the_post_method_with_the_body_of_the_request() throws Exception {
        resources.client().target("/notes/").request().post(text("A message"));

        verify(resource).post("A message");
    }
}
