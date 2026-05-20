int qsort(base, nmemb, size, compar)
char *base;
unsigned nmemb;
unsigned size;
int (*compar)();
{
    unsigned i, j, k;
    char *a, *b, *pa, *pb;
    char tmp;

    if (base == 0 || nmemb < 2 || size == 0)
        return 0;

    for (i = 1; i < nmemb; ++i)
      {
        j = i;
        while (j > 0)
          {
            a = base + ((j - 1) * size);
            b = base + (j * size);
            if ((*compar)(a, b) <= 0)
                break;

            pa = a;
            pb = b;
            for (k = 0; k < size; ++k)
              {
                tmp = *pa;
                *pa++ = *pb;
                *pb++ = tmp;
              }
            --j;
          }
      }
    return 0;
}
