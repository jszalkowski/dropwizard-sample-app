package com.evilcorp.sampleapp.models;

import com.fasterxml.jackson.annotation.JsonProperty;

import static org.apache.commons.lang3.builder.EqualsBuilder.reflectionEquals;
import static org.apache.commons.lang3.builder.ToStringBuilder.reflectionToString;

public class Note {
    private Integer id;
    private String message;

    public Note() {
        // Used by Jackson
    }

    public Note(Integer id) {
        this(id, null);
    }

    public Note(Integer id, String message) {
        this.id = id;
        this.message = message;
    }

    @JsonProperty
    public Integer getId() {
        return id;
    }

    @JsonProperty
    public void setId(Integer id) {
        this.id = id;
    }

    @JsonProperty
    public String getMessage() {
        return message;
    }

    @JsonProperty
    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public boolean equals(Object obj) {
        return reflectionEquals(this, obj);
    }

    @Override
    public String toString() {
        return "Message: " + this.getMessage() + ", Id: " + this.getId();
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private final Note note;

        Builder() {
            this.note = new Note();
        }

        public Builder withId(Integer id) {
            note.setId(id);
            return this;
        }

        public Builder withMessage(String message) {
            note.setMessage(message);
            return this;
        }

        public Note build() {
            return note;
        }
    }
}
