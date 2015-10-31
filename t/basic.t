use Test;
use JSON::Unmarshal;

class Dog {
    has Str $.name;
    has Str $.race;
    has Int $.age;
}

class Person {
    has Str $.name;
    has Int $.age;
    has Dog @.dogs;
    has Str %.contact;
}

my $json = q/
{
    "name" : "John Brown",
    "age"  : 17,
    "contact" : {
       "email" : "jb@example.com",
       "phone" : "12345678"
    },
    "dogs"  : [{
        "name" : "Roger",
        "race" : "corgi",
        "age"  : 4
    },
    {
        "name" : "Panda",
        "race" : "wolfish",
        "age"  : 13
    }]
}
/;

my $p = unmarshal($json, Person);

isa-ok $p, Person;
is $p.name, "John Brown";
is $p.age, 17;
is $p.contact<email>, 'jb@example.com';
is $p.contact<phone>, "12345678";
is $p.dogs.elems, 2;
is $p.dogs[0].name, 'Roger';
is $p.dogs[0].race, 'corgi';
is $p.dogs[0].age, 4;

is $p.dogs[1].name, 'Panda';
is $p.dogs[1].race, 'wolfish';
is $p.dogs[1].age, 13;

done-testing;
