### Encrypted files

Certain extensions have data exports which contain user activity data and/or
credentials.

Any files ending with `.age` are encrypted using age as follows,

```sh
cat secret | age --encrypt --identity key.txt > secret.age
age --encrypt --identity key.txt secret.zip > secret.zip.age

# decrypt
age --decrypt --identity key.txt --output secret secret.age
```

[Link to key.txt](https://www.youtube.com/watch?v=xvFZjo5PgG0)
