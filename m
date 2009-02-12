From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] git-rebase.txt: Mention that --whitespace cannot be used with interactive rebase.
Date: Thu, 12 Feb 2009 08:44:52 -0600
Message-ID: <200902120844.59224.bss@iguanasuicide.net>
References: <20090212102119.1de19087@crow> <alpine.DEB.1.00.0902121156550.10279@pacific.mpi-cbg.de> <20090212113252.26b9788f@crow>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3215900.n6VfOtU7MT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 15:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXcpk-0008Rw-Hy
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 15:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbZBLOpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 09:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757396AbZBLOpE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 09:45:04 -0500
Received: from eastrmmtao101.cox.net ([68.230.240.7]:52145 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757141AbZBLOpC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 09:45:02 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090212144502.IOZY15713.eastrmmtao101.cox.net@eastrmimpo03.cox.net>;
          Thu, 12 Feb 2009 09:45:02 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id F2l01b0022i4SyG022l0WQ; Thu, 12 Feb 2009 09:45:00 -0500
X-Authority-Analysis: v=1.0 c=1 a=-TwC5px8Zo0A:10 a=m1gWPYpK1nIA:10
 a=2C6YHBdLAAAA:8 a=Fq1VQ0LPAAAA:8 a=7g5QXpzBYLF7PSbbg38A:9
 a=YO_WDl3aKdjYhNXtU4oA:7 a=rco__N2CvQNnVa5rmqu4YRHurM0A:4 a=_RhRFcbxBZMA:10
 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10 a=BI8X1VcwyvTJE5ySkoUA:9
 a=Zux6kYVWHSG7datTyHxVMvezMOIA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LXcoF-0000u5-Fd; Thu, 12 Feb 2009 08:44:59 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090212113252.26b9788f@crow>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109620>

--nextPart3215900.n6VfOtU7MT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 12 February 2009 05:32:52 Mark wrote:
> On Thu, 12 Feb 2009 11:58:25 +0100 (CET)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Would be nice to have important information like that (I mean that it is
> > already handled, not that I was stupid enough to write the patch) in the
> > commit message, don't you agree?
>
> Actually, no.
>
> I am very glad that the git guardians are diligent and careful because
> it gives me confidence that my favourite software is going to work
> reliably and efficiently, etc.
>
> However, if that diligence and attention to detail, etc. extends to the
> point where a humble git user (not a developer) cannot submit a patch that
> he thinks will, in some small way, improve the software, without being
> quizzed, grilled or, in extreme cases, mocked or abused (it happens)
> because the patch is not 100% perfect in every way, then, I am happy to
> let the development process continue without my feeble contributions.

Junio does final fix-up on a lot of patches, but it's better if he doesn't=
=20
have to spend much time doing that and can spend more time merging and writ=
ing=20
patches.

High-quality commits are what makes git high-quality software.  You seem to=
=20
want the later, but don't want to provide the former.  You might not have t=
o. =20
Someone may pick up you patch and apply the fixes you won't spend time on. =
=20
However, if no one does, blame yourself.  You know enough about the process=
 to=20
submit the patch once.  You should know enough to submit the patch as many=
=20
times as needed to get an Ack.

> So, I left something out of the commit message, did I? Oh my gawd, I
> better top myself!

Dscho wasn't saying that.  However, if you left something out of the commit=
=20
message (and you seem to admit you did), you should add it and resubmit.

> Johannes, you're the worst of the pedants. Ease up man, you'll bust a
> blood vessel!

After I read this list for about a month, I has convinced that Dscho's main=
=20
purpose in life was to prevent patches from being accepted.  After reading =
the=20
list for 3 months, I recognized that Dscho's performing an important servic=
e=20
for the list that definitely drives up the quality of the code seen in git.=
 =20
Unfortunately, doing that job makes people grumpy, so occasionally you may =
see=20
Dscho come off as brusque.

At http://www.kroah.com/log/linux/ols_2006_keynote.html, Greg Kroah-Hartman=
=20
wrote about reviewing patches for the Linux kernel:

"The Linux kernel mailing list also has another kind of perceived problem.=
=20
Lots of people can find the reaction of developers on this list as very=20
"harsh" at times. They post their code, and get back scathing reviews of=20
everything they did wrong. Usually the reviewers only criticize the code=20
itself, but for most people, this can be a very hard thing to be on the=20
receiving end of. They just put out what they felt was a perfect thing, onl=
y=20
to see it cut into a zillion tiny pieces.

"The big problem of this, is we really only have a very small group of peop=
le=20
reviewing code in the kernel community. Reviewing code is a hard, unrewardi=
ng,=20
tough thing to do. It really makes you grumpy and rude in a very short peri=
od=20
of time. I tried it out for a whole week, and at the end of it, I was writi=
ng=20
emails like this one:

'Wow, for such a small file, every single function was incorrect.  And you=
=20
abused sysfs in a new and interesting way that I didn't think was even=20
possible.  I think this is two new records you have set here,=20
congratulations.'

"Other people who review code, aren't even as nice as I was here."

In short, reviewing is hard and thankless and we are lucky we have Dscho (a=
nd=20
others) to do it for us.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart3215900.n6VfOtU7MT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmUNeUACgkQ55pqL7G1QFl9XgCcCEFkAyNrtpsTGfV8zsH5rwTt
w6YAn1mDkuQGYHl9weKmpqWB8E8XcrNd
=PTzw
-----END PGP SIGNATURE-----

--nextPart3215900.n6VfOtU7MT--
