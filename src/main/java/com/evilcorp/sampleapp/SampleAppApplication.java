package com.evilcorp.sampleapp;

import com.evilcorp.sampleapp.infrastructure.InMemoryNotesRepository;
import com.evilcorp.sampleapp.infrastructure.JdbiNotesRepository;
import com.evilcorp.sampleapp.models.NotesRepository;
import com.evilcorp.sampleapp.resources.NotesResource;
import io.dropwizard.Application;
import io.dropwizard.db.DataSourceFactory;
import io.dropwizard.jdbi.DBIFactory;
import io.dropwizard.migrations.MigrationsBundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.skife.jdbi.v2.DBI;

public class SampleAppApplication extends Application<SampleAppConfiguration> {
    public static void main(String[] args) throws Exception {
        new SampleAppApplication().run(args);
    }

    @Override
    public void run(SampleAppConfiguration configuration, Environment environment) throws Exception {
        NotesRepository repository = createNotesRepositoryFrom(configuration, environment);

        final NotesResource notes = new NotesResource(repository);

        environment.jersey().register(notes);
    }

    @Override
    public void initialize(Bootstrap<SampleAppConfiguration> bootstrap) {
        bootstrap.addBundle(new MigrationsBundle<SampleAppConfiguration>() {
            public DataSourceFactory getDataSourceFactory(SampleAppConfiguration configuration) {
                return configuration.getDataSourceFactory();
            }
        });
    }

    private NotesRepository createNotesRepositoryFrom(SampleAppConfiguration configuration, Environment environment) {
        if (configuration.getDataSourceFactory() != null) {
            final DBI jdbi = new DBIFactory().build(environment, configuration.getDataSourceFactory(), "database");
            return new JdbiNotesRepository(jdbi);
        }

        return new InMemoryNotesRepository();
    }
}
