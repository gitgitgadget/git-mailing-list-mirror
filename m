From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Wed, 22 May 2013 17:16:54 +0200
Message-ID: <CAN0XMOK4oniunZz5KpC1x=JrY4yH4HnecxMSCyPF+kEyYRRjTw@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
	<CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com>
	<7402110.vsgz8zEiin@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Wed May 22 17:17:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfAml-00045H-Lw
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 17:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab3EVPQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 May 2013 11:16:57 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:63900 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab3EVPQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 May 2013 11:16:56 -0400
Received: by mail-we0-f169.google.com with SMTP id q55so1367484wes.14
        for <git@vger.kernel.org>; Wed, 22 May 2013 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YWOAlbPoxgcvIL7jQUWNg9iGk62AYCoBjUc+UegUL+0=;
        b=MvbSziu0lVRubc61BGM0TZQgE8Qz6Ii/C6nPDC+Iv3fZa31i1M9A3GNoIuwO81JLe7
         0abMG57GZQwybxou3O75Xg2UpMBevPI8N3XrzYzvK9vfM8V07lXzAzuJ+PRxyKm90uNu
         d6Et2pNfKHGIn1wIaHFyM+oLyv35og3uIDBybfwfA7h5+SqSZ+VRR+kHV5sy2q6xwajF
         6M/VyEW0Za9tzFaDN5qAVLJQZvFjlFH17ueqcUHgIRrNF8+pGNXar1UXl3FLQdgK3a+q
         S0Vz8hzuPsOJm8cccbeee4ZdSbgU9qV1uvpZQhu5ISVIm+4Zg7guDid/4z+suZkNmkh7
         WXOw==
X-Received: by 10.180.86.38 with SMTP id m6mr34504906wiz.25.1369235814454;
 Wed, 22 May 2013 08:16:54 -0700 (PDT)
Received: by 10.194.71.44 with HTTP; Wed, 22 May 2013 08:16:54 -0700 (PDT)
In-Reply-To: <7402110.vsgz8zEiin@cs-pc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225167>

2013/5/20 Christian Stimming <stimming@tuhh.de>:
> Thanks for the update. I would like to add some comments on this G+E =
glossary
> and I hope you are interested in reading those, even though it is kno=
wn that I
> prefer a "pure Ger" translation. However, as I wrote in my other mess=
age I
> agree that for the command line tool the criteria for choosing the tr=
anslation
> approach are different from those for a GUI tool. So I can very well =
envision
> a good G+E translation for git core and subsequently all related book=
s.
>

Thanks for your comments.

> Am Sonntag, 19. Mai 2013, 18:53:18 schrieb Ralf Thielow:
>> Basic repository objects:
>>
>>     blob           =3D Blob
>>     tree           =3D Baum, Baum-Objekt (bevorzugt), "Tree"-Objekt
>>     submodule      =3D Submodul
>>     pack(noun)     =3D Pack-Datei
>>     pack(verb)     =3D packen (ggf. Pack-Datei erstellen)
>>     ancestor       =3D Vorfahre, Vorg=C3=A4nger, Vorg=C3=A4nger-Comm=
it (bevorzugt)
>
> Yes. Does the "Pack-Datei" appear anywhere in the book? I wouldn't un=
derstand
> the term, but then again, this is probably because I don't understand=
 the
> semantic of this thingy as a repository object regardless of the lang=
uage...
>

The book has this word in it's index ("9.4 Pack-Dateien")
http://git-scm.com/book/de
so we're fine here.

While at there, I just read "Die Refspec" in the index. The current glo=
ssary
doesn't contain "refspec" and we translate is as "Referenzspezifikation=
".
So if we want to match the book, we should add "refspec =3D Refspec" to
the glossary.

>> Content in a repository:
>>
>>     file(s)        =3D Datei(en)
>>     tracked file   =3D beobachtete Datei
>>     track file     =3D beobachte Datei
>>     untracked file =3D unbeobachtete Datei
>>     directory      =3D Verzeichnis
>
> Yes.
>
>> Repositories / tracking concepts:
>>
>>     clone (verb)           =3D klonen
>>     clone (noun)           =3D der Klon
>>     repository             =3D Repository
>>     bare repository        =3D Bare Repository
>
> Yes. After some evaluation of the git-gui translation I think using
> "Repository" there as well is probably the better choice.
>
>>     working directory      =3D Arbeitsverzeichnis
>>     working tree           =3D -||-
>>
>>     remote branch          =3D Remote-Branch
>>     remote-tracking branch =3D Remote-Tracking-Branch
>>     upstream branch        =3D Upstream-Branch
>
> Yes. What's the main reason for using "Branch" in the German text? Co=
nsistency
> with the commands, or assumed familiarity of the term within the targ=
et
> audience? "Zweig" is available.
>

I think it's at the same level as "Commit" and a well known SCM-term. U=
sers
(even beginners) who know "Commit" and "Tag" do also know "Branch". And
I think it sounds better in combination with "Remote-", "Remote-Trackin=
g-" and
"Upstream-" which are english words.

>>     remote repository      =3D Remote-Repository
>>     remote(noun)           =3D -||-
>>     remote(adj)            =3D extern, entfernt liegend
>>
>> Authorship:
>>
>>     author    =3D Autor
>>     committer =3D Commit-Ersteller
>>     tagger    =3D Tag-Ersteller
>
> Yes.
>
>> Commits, tags and other references:
>>
>>     HEAD           =3D HEAD
>> Konzept aus der Git-Welt, daher nicht zu =C3=BCbersetzen.
>>     detached HEAD  =3D losgel=C3=B6ster HEAD
>>
>>     commit(noun)      =3D Commit
>>     commit(verb)      =3D committen
>>     commit the result =3D das Ergebnis committen
>>     parent commit     =3D Eltern-Commit
>>     child commit      =3D Kind-Commit
>>     commit message    =3D Commit-Beschreibung
>
> Yes, for the G+E approach.
>
>>     stash(noun)       =3D der Stash
>>     stash(verb)       =3D "stashen", "stash" benutzen (bevorzugt)
>>     unstash(verb)     =3D "unstashen", "zur=C3=BCckladen", "aus 'sta=
sh'
>> zur=C3=BCckladen" (bevorzugt)
>
> Using "Stash" in G+E is quite ugly, but the noun is probably unavoida=
ble
> because the feature is pretty much unique to git. I'd suggest to use =
only the
> noun and use the verbs as "stash benutzen" and "aus stash zur=C3=BCck=
laden" as
> proposed.
>

Yes.

>>     reference      =3D Referenz
>>     revision       =3D Commit
>>     branch         =3D Branch
>>     tag(noun)      =3D Tag
>>     tag(verb)      =3D taggen, Tag erstellen
>>     annotated tag  =3D annotierter Tag
>>     tag message    =3D Tag-Beschreibung
>
> I've commented on "Branch" above. As for "Tag": Yes, the term is fami=
liar
> among the target audience. However, do you really want this noun whic=
h is the
> same word as "Tag wie in Datum"? Some more disambiguation between the=
 tag and
> the date would be helpful, wouldn't it?
> The derived forms are fine, and also here I'd suggest to use only the=
 G+E noun
> but construct the verbs with other German words: "Tag erstellen".
>
>>     stage/index (noun) =3D Staging-Area, Index
>>     stage/index (verb) =3D (f=C3=BCr einen | zum) Commit vormerken
>> (bevorzugt), zur Staging Area hinzuf=C3=BCgen, dem Index hinzuf=C3=BC=
gen
>>     unstage (verb)     =3D aus Staging Area entfernen, aus Index ent=
fernen
>
> I'd strongly suggest not to use "Index". I've never understood why th=
is term
> showed up in the English wording to begin with. It took me years unti=
l I got
> the point that from the user's point of view, this thingy has nothing=
 to do
> with a book's index or a database's index, which is where I go to loo=
k up more
> information about a keyword. It is a big improvement to use "staging =
area" on
> the English side. If it has to be an English word due to consistency =
with the
> commands, I'd suggest "Staging-Area" or "Staging-Bereich". For the ve=
rb I'd
> agree to keep only the noun in English but construct the verb with Ge=
rman
> verbs, like already proposed here.
>

Yes.

>> Moving data around:
>>
>>     fetch =3D anfordern
>>     pull  =3D zusammenf=C3=BChren
>>     push  =3D versenden
>>
>>     fast-forward     =3D vorspulen
>>     non-fast-forward =3D nicht vorspulen
>
> IMHO yes, and the German terms make me even understand what is going =
on. (On
> the English side it took me ages to memorize the difference between f=
etch and
> pull, as the words don't offer any difference in meaning. But that's =
a
> different story.) However, you probably get a hard time here when exp=
laining
> how to keep consistency with the command names: It isn't clear for th=
e user
> why "fetch" should be the command name related to "anfordern" but "pu=
ll" is
> not. This unfortunately probably means you have to introduce the word=
s "pull"
> and "fetch" somewhere in the German text.
>

Unfortunately, I don't know a place where we could introduce
something. After looking
through git's de.po, I didn't found a message where "pull" is
translated. But I've
found
msgid "Pull is not possible ...
msgstr "\"pull\" ist nicht m=C3=B6glich
:)
But, for example, "fetch" is used in help messages for options, e.g.
msgid "fetch from all remotes"
msgstr "fordert von allen externen Projektarchiven an"
(same for push). In other messages, the translation is in the same mess=
age
as the command itself. I think it's OK when we just use "fetch" and "pu=
sh"
when the command is meant (as it's done for "pull", e.g. in error messa=
ges),
and the translation when the messages tell what the command is doing (e=
=2Eg. help
messages). So it would depends on the message whether we translate the =
word
or not. This would apply to other terms that are commands, too, like
"clean" or "revert".

>> Commands:
>>
>>     log                =3D Log
>>     interactive commit =3D interaktiver Commit
>>     cherry-pick        =3D "cherry-pick" benutzen
>>     rebase(verb)       =3D "rebase" benutzen
>>     rebase(noun)       =3D "rebase"
>>     archive            =3D archivieren
>>     revert             =3D zur=C3=BCcknehmen
>>     clean(verb)        =3D s=C3=A4ubern/aufr=C3=A4umen
>>     clean(noun)        =3D S=C3=A4uberung
>>     merge              =3D zusammenf=C3=BChren
>
> Yes. (I'd hope to see some German word for "cherry-pick" and "rebase"
> ("pfl=C3=BCcken" and "neu aufbauen"), but then again, in G+E you prob=
ably keep that
> words.)
>
>>     bundle(noun)       =3D Paket
>>     bundle(verb)       =3D Paket erstellen
>>     unbundle(verb)     =3D Paket entpacken
>>
>>     bisect             =3D bin=C3=A4re Suche
>>     bisecting          =3D bei einer bin=C3=A4ren Suche sein, bin=C3=
=A4re Suche
>> durchf=C3=BChren
>
> Yes
>
>> Diff/patch related:
>>
>>     diff               =3D Differenz
>>     delta              =3D Differenz (or Delta)
>>     patch              =3D Patch
>>     apply              =3D anwenden
>>     diffstat           =3D (leave it as it is)
>>     hunk               =3D Bereich
>
> IMHO "Kontext" is better if you use a German word. Technically the co=
ntext is
> something else, but in a German text IMHO it fits nicer when explaini=
ng to the
> user where he/she can select the n-th hunk.
>

Not sure if German users would know what "hunk" means, in case we
leave it untranslated. And I'm not sure if I would understand "Kontext"=
=2E
I tend to leave it untranslated.

>>     whitespace         =3D Whitespace
>
> Yes. Indeed I haven't heard a good German word that transports the sa=
me
> meaning.
>
>
>> Still being worked out:
>>
>>     prune              =3D veraltete(n) Branch(es) entfernen
>
> Yes, and it makes me even understand what the command is about to do.
>
>>     checkout(verb)     =3D auschecken
>>
>>     git add      =3D hinzuf=C3=BCgen
>>
>>     merge conflict =3D Merge-Konflikt
>>     3-way merge    =3D 3-Wege-Merge
>
> If merge was "zusammenf=C3=BChren" above, it should be "Zusammenf=C3=BC=
hrungs-Konflikt"
> here, and "3-Wege-Zusammenf=C3=BChrung".
>

Yes.

>>     paths          =3D Pfade
>>
>>     symbolic link =3D symbolische Verkn=C3=BCfung
>>     path =3D Pfad
>>     link =3D Verkn=C3=BCpfung
>>
>>     reflog =3D Referenzprotokoll
>>     partial commit (verb) =3D teilweise committen, partiell committe=
n
>
> Teilweise committen. (No partial derivatives here...)
>

Yes.

>>     partial commit (noun) =3D Teil-Commit
>>
>>     reset =3D neu setzen (maybe "umsetzen"?)
>>
>>     register   =3D in die Konfiguration eintragen
>>     unregister =3D aus der Konfiguration austragen
>
> Best Regards,
>
> Christian
