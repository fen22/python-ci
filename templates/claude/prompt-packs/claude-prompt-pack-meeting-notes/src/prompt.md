# Prompt Templates — Meeting Notes Summarizer

## Template A: Notas brutas

```
Please summarize the following meeting notes:

<meeting_notes>
{{MEETING_NOTES}}
</meeting_notes>

Extract all action items, decisions, and open questions.
```

## Template B: Transcripción de audio

```
The following is an auto-generated transcript from a meeting recording. There may be transcription errors.

<transcript>
{{TRANSCRIPT}}
</transcript>

Please clean up the transcript artifacts and produce a structured meeting summary.
```

## Template C: Formato específico de empresa

```
Summarize the following meeting notes for a {{TEAM_NAME}} team meeting at ClickIT.

<meeting_notes>
{{MEETING_NOTES}}
</meeting_notes>

Format action items using our Jira ticket format: [PROJ-XXX] Action description @owner due:YYYY-MM-DD
```

## Variables

| Variable | Description |
|---|---|
| `{{MEETING_NOTES}}` | Raw notes, transcript, or bullet points from the meeting |
| `{{TRANSCRIPT}}` | Auto-generated audio transcript |
| `{{TEAM_NAME}}` | Team name (Engineering, Product, etc.) |
