char *mystrcat(char *s, const char *t)
{
    char *r = s;

    while (*s) {
        ++s;
    }

    while ((*s++ = *t++))
        ;

    return r;
}
