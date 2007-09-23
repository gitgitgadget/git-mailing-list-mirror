From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 12:45:25 +0200
Message-ID: <20070923104525.GC7118@artemis.corp>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com> <46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com> <46F55E03.2040404@krose.org> <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com> <20070923020951.GF24423@planck.djpig.de> <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz> <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="TiqCXmo5T1hvSQQg";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: David Kastrup <dak@gnu.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Alex Unleashed <alex@flawedcode.org>,
	Kyle Rose <krose@krose.org>, Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 12:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZOy0-0004TV-60
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 12:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbXIWKpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 06:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbXIWKp3
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 06:45:29 -0400
Received: from pan.madism.org ([88.191.52.104]:52034 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152AbXIWKp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 06:45:28 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9442E19770;
	Sun, 23 Sep 2007 12:45:26 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A0E5114804C; Sun, 23 Sep 2007 12:45:25 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Marco Costalba <mcostalba@gmail.com>, David Kastrup <dak@gnu.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Alex Unleashed <alex@flawedcode.org>, Kyle Rose <krose@krose.org>,
	Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58962>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2007 at 09:29:45AM +0000, Marco Costalba wrote:
> On 9/23/07, David Kastrup <dak@gnu.org> wrote:
> > David Brown <git@davidb.org> writes:
> >
> > > On Sun, Sep 23, 2007 at 04:09:51AM +0200, Frank Lichtenheld wrote:
> > >>On Sun, Sep 23, 2007 at 12:50:00AM +0200, Alex Unleashed wrote:
> > >>> I'd say being forced to be explicit is a good thing here, so that t=
he
> > >>> programmer at least has some sort of good understanding of what is
> > >>> going on, and chances are that if he doesn't really know, things ju=
st
> > >>> won't work out (quite unlike a lot of other languages where this
> > >>> programmer might actually end up with something half-assed that
> > >>> "mostly" works).
> > >>> For some reason it seems to me a lot harder to find bad programmers
> > >>> surviving using C than a lot of the other languages.
> > >>
>=20
> Well, according to your reasoning assembly should be the gotha of
> elite programmers, only very disciplined and meticulous programmers
> survive, much more then in C.

  This non argument was raised before in the recent thread we just had.
Could we at least wait say, a month, before spawning the same trolls
again and again ?

> > C++ is good for creating black boxes.
>=20
> Object oriented languages creates black boxes: that's the reason why
> object oriented exsists and also the reason why Linus hates it ;-)

  This is just nonsense. This has been proved, though I can't find the
paper about this anymore, than modules (or packages whichever name you
give them) plus abstract types are as good as OO languages at creating
black boxes. I mean it has been proved that it gives the exact same
amount of expressiveness. So please stop with this myth. And don't speak
for people, I would be very surprised that Linus would dislike "black
boxes". Abstractions are good, when used wisely, and I would be much
surprised to see Linus pretend otherwise.

  The real problem with big applications, is not that they are written
with C, C++, D, APL or Perl, but that they are big. Most of the time,
big means that many people are not able to grok the big picture, and you
end up with 102 implementations of base64, 10 string libraries, 4
general purpose buffers, and at least half of the common lisp
features[0]. And for the record git is _not_ big. It's around 100k
slocs, which rougly the size of postfix or mutt.

  I for one do believe that bad programmers will write bad code
whichever language they use, and that what is wrong is to end with code
bases in one monolithic thing like in [1]. OO design patterns and other
craps of the like helps you generate insane amount of codelines, and
hide all the simplicity under huge loads of proxies and interfaces. In
C, when your API suck, you usually need to refactor it under the
pressure of the huge amount of code you have to repeat each time you use
the API. in an OO language, you add a new class for that purpose. In C++
it's even worse, you just hide it in a copy constructor, or an operator
so that when you write:

  Foo a =3D b;

  Instead of a simple memcpy, you end up with an horrible pile of crap
to be started and run behind your back. C++ is very good at hiding bad
code. At least in C, when someone writes bad code, it's obvious to any
reader. C has many many quirks, I don't discuss that, but OO programming
solves none of them, and the problems OO addresses are not the one that
may interfere in the git development. I mean, the two really interesting
things in OO (that haven't a tremendous cost in return) are member
overloading and inheritance. I see very few places where git would
benefit from that, and believe me, I looked at git's code with
refactoring in mind and only that.

  Can we go back to git now ?



  [0] http://en.wikipedia.org/wiki/Greenspun's_Tenth_Rule

  [1] http://www.ohloh.net/projects/29/analyses/latest

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG9kPFvGr7W6HudhwRAlQ2AJ9ucpSvMa4WD1NTgGFP2lzQS5de8QCfUyTf
AwLVCwtbVxHs21hJpM/4vZc=
=t8KK
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
