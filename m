From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH 2/2] Add Swedish translation.
Date: Wed, 15 Sep 2010 17:31:43 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>
References: <20100912202111.B11522FC00@perkele>
 <A612847CFE53224C91B23E3A5B48BAC749BF60444B@xmail3.se.axis.com>
 <alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Swedish <tp-sv@listor.tp-sv.se>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Sep 15 17:31:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovtxh-0004QN-TK
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 17:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab0IOPbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 11:31:47 -0400
Received: from anubis.se.axis.com ([195.60.68.12]:55495 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab0IOPbr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 11:31:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id C16BF19D90;
	Wed, 15 Sep 2010 17:31:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QWtZr42gsUrt; Wed, 15 Sep 2010 17:31:45 +0200 (CEST)
Received: from miranda.se.axis.com (miranda.se.axis.com [10.0.2.171])
	by anubis.se.axis.com (Postfix) with ESMTPS id 2D2DC19D1B;
	Wed, 15 Sep 2010 17:31:45 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o8FFViaf007034;
	Wed, 15 Sep 2010 17:31:44 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Wed, 15 Sep 2010 17:31:44 +0200
Thread-Topic: [PATCH 2/2] Add Swedish translation.
Thread-Index: ActUwGb4JzKnWNBpSEmy5JpwQhiULgAI7q/g
In-Reply-To: <alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156238>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Peter Krefting
> Sent: den 15 september 2010 12:25
> To: Peter Kjellerstedt
> Cc: Git; Swedish
> Subject: RE: [PATCH 2/2] Add Swedish translation.
>=20
> Peter Kjellerstedt:
>=20
> > Mainly comments on the Swedish translation below, but there are a f=
ew
> > references to the English messages as well.
>=20
> Thanks.
>=20
> Cc'ing TP-SV as I posted the translation for review there as well.

[cut]

> >> +#: builtin/commit.c:380
> >> +msgid "cannot do a partial commit during a merge."
> >> +msgstr "kan inte utf=F6ra en delvis incheckning under en sammansl=
agning."
> > "delvis" -> "partiell"
>=20
> Is that better? Sounds a bit to technical to me.

Well, "en delvis incheckning" doesn't sound like correct Swedish...

[cut]

> >> +#: builtin/commit.c:737
> >> +msgid "Error building trees"
> >> +msgstr "Fel vid byggande av tr=E4d"
> > "byggande av tr=E4d" -> "tr=E4dbygge" ?
>=20
> That sounds even weirder to me.

Hmm, you may be right. Alternatives for "byggande" is
"konstruktion" and "skapande", don't know if either of those
make it sound better.

[cut]

> >> +#: builtin/describe.c:205
> >> +#, c-format
> >> +msgid "annotated tag %s not available"
> >> +msgstr "den dekorerade taggen %s inte tillg=E4nglig"
> > "dekorerade" -> "annoterade"
>=20
> Is that a word?

Yes. At least it is in SAOL which I think should be indicative=20
of its existence ;)

[cut]

> >> +#: builtin/fetch.c:917
> >> +msgid "Fetching a group and specifying refspecs does not make sen=
se"
> >> +msgstr "Kan inte h=E4mta fr=E5n grupp och ange referensspecifikat=
ioner"
> > "fr=E5n" -> "en" ?
>=20
> Well, I was thinking "fetch" -> "h=E4mta fr=E5n", and just dropped th=
e
> "en".

Ok.

[cut]

> >> +#: builtin/grep.c:581
> >> +#, c-format
> >> +msgid "Failed to chdir: %s"
> >> +msgstr "Kunde inte byta katalog (chdir): %s"
> > I think you can skip the " (chdir)" explanation without
> > loss of information.
>=20
> As long as the original string uses the system call reference, and no=
t
> the action, I will keep it in the translation.

Ok (guess the English message could do with an update...)

> >> +#: builtin/grep.c:703
> >> +#, c-format
> >> +msgid "unable to grep from object of type %s"
> >> +msgstr "Kunde inte \"grep\" fr=E5n objekt av typen %s"
> > "\"grep\"" -> "greppa" ?
>=20
> That's a word that means something else... I don't really have any go=
od
> idea on how to translate "grep" when used as a verb...

Yeah, I know... I've no better suggestion I'm afraid.

[cut]

> >> +#: builtin/log.c:825
> >> +#, c-format
> >> +msgid "insane in-reply-to: %s"
> >> +msgstr "tokigt in-reply-to: %s"
> > "tokigt" -> "tokig"
>=20
> My sense of language says that it should be "neutrum", so "tokigt".

Well, I read it with an implicit "header" (i.e., as "insane=20
in-reply-to header: %s")...

[cut]

> >> +#: builtin/merge.c:651
> >> +#, c-format
> >> +msgid "Unknown option for merge-recursive: -X%s"
> >> +msgstr "Felaktig flagga f=F6r merge-recursive: -X%s"
> > "merge-recursive" -> "rekursiv ihopslagning" ?
>=20
> No, merge-recursive is a name of a merge strategy.

Maybe add quotes around it then do indicate that?

> >> +#: builtin/merge.c:1271
> >> +#, c-format
> >> +msgid "Using the %s to prepare resolving by hand.\n"
> >> +msgstr "Anv=E4nder %s f=F6r att f=F6rbereda l=F6sning f=F6r hand.=
\n"
> > "%s" -> "strategin %s" ?
>=20
> Yeah. The English string should probably also be fixed, though.

Agree.

> >> +#: builtin/mv.c:206
> >> +#, c-format
> >> +msgid "Renaming %s to %s\n"
> >> +msgstr "Byter namn p=E5 %s till %s\n"
> > "Byter namn p=E5" -> "D=F6per om" ?
>=20
> I've used "byta namn" in other places, so if I change here, I should
> change it globally.

Either should work I guess...

[cut]

> >> +#: builtin/push.c:77
> >> +#, c-format
> >> +msgid "The current branch %s is tracking multiple branches, refus=
ing to push."
> >> +msgstr "Den aktuella grenen %s sp=E5rar flera grenar, v=E4grar s=E4=
nda."
> > "s=E4nda" -> "trycka iv=E4g" ?
>=20
> "Trycka iv=E4g" sounds horrible, IMHO. I used "S=E4nd" in the git-gui
> translation of "Push". As long as git doesn't grow a "git send"
> command, I think that should be OK.

Ok.

> >> +#: builtin/push.c:132
> >> +#, c-format
> >> +msgid ""
> >> +"To prevent you from losing history, non-fast-forward updates wer=
e
> rejected\n"
> >> +"Merge the remote changes (e.g. 'git pull') before pushing again.
> See the\n"
> >> +"'Note about fast-forwards' section of 'git push --help' for
> details.\n"
> >> +msgstr ""
> >> +"F=F6r att f=F6rhindra att du tappar historik har icke snabbspola=
nde
> uppdateringar\n"
> >> +"avvisats. Sl=E5 ihop fj=E4rr=E4ndringarna (t.ex \"git pull\") in=
nan du
> s=E4nder igen.\n"
> >> +"Se avsnittet \"Note about fast-forward\" i \"git push --help\" f=
=F6r
> detaljer.\n"
> > "icke snabbspolande" -> "icke-snabbspolande"
>=20
> Changed.
>=20
> > "t.ex" -> "t ex"
>=20
> I think it looks clearer with the full stop.

Then it should be "t. ex." according to SAOL.

[cut]

> >> +#: builtin/reset.c:321
> >> +msgid "--mixed with paths is deprecated; use 'git reset -- <paths=
>'
> instead."
> >> +msgstr "--mixed rekommenderas inte med s=F6kv=E4gar; anv=E4nd \"g=
it reset
> -- <s=F6kv=E4gar>\"."
> > "." -> " ist=E4llet."
>=20
> I dropped it to fit an 80 character line.

Ok.

> >> +#: builtin/revert.c:270
> >> +#, c-format
> >> +msgid "Error wrapping up %s"
> >> +msgstr "Fel vid ombrytning av %s"
> >
> > I do not think this "wrapping up" refers to reformatting of the com=
mit
> > message. I think it refers to finishing writing the message (a reph=
rasing
> > of the English message is advisable). Thus the Swedish translation =
should
> > probably be:
> >
> > "Fel vid avslutandet av %s"
>=20
> Are you sure about that? I was unable to figure it out when I looked =
at
> it.

I am pretty sure. That error message is output in case a file
called "somefile.lock" cannot be closed and renamed to "somefile"=20
(see lockfile.c:commit_lock_file().)

[cut]

> >> +#: builtin/shortlog.c:161
> >> +#, c-format
> >> +msgid "Missing author: %s"
> >> +msgstr "Saknad f=F6rfattare: %s"
> > "Saknad" -> "Saknar"
>=20
> I think "missing" it is an adjective and not a verb here. The message
> is clear either way.

Ok.

[cut]

> >> +#: builtin/tag.c:196
> >> +msgid "gpg did not accept the tag data"
> >> +msgstr "gpg godtog inte taggdata"
> > "taggdata" -> "taggdatan"
>=20
> "taggdatana" in that case. "data" is always plural.

Maybe better to use "tagginformationen"?

[cut]

> >> +#: git-am.sh:120
> >> +msgid ""
> >> +"Did you hand edit your patch?\n"
> >> +"It does not apply to blobs recorded in its index."
> >> +msgstr ""
> >> +"Vill du handredigera din patch?\n"
> >> +"Den kan inte appliceras p=E5 blobbar som antecknats i dess index=
=2E"
> > "Vill du handredigera" -> "Handredigerade du"
>=20
> Fixed.
>=20
> > "antecknats" -> "finns"
>=20
> That's ambiguous. Changed second sentence to:
> "Den kan inte appliceras p=E5 de blobbar som beskrivs i dess index."

Good.

> --
> \\// Peter - http://www.softwolves.pp.se/

//Peter
