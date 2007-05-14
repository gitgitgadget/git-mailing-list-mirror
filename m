From: Michael Niedermayer <michaelni@gmx.at>
Subject: Re: suggestions for gitweb
Date: Mon, 14 May 2007 04:00:02 +0200
Message-ID: <20070514020001.GX14859@MichaelsNB>
References: <20070512205529.GS14859@MichaelsNB> <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net> <20070513000151.GT14859@MichaelsNB> <20070514010831.GH4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9z6ln3N8ZGVHaUXG"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon May 14 04:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnPv9-0003V4-Jl
	for gcvg-git@gmane.org; Mon, 14 May 2007 04:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352AbXENCEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 22:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756019AbXENCEJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 22:04:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:58316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754352AbXENCEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 22:04:08 -0400
Received: (qmail invoked by alias); 14 May 2007 02:04:05 -0000
Received: from chello080109116125.4.15.vie.surfer.at (EHLO localhost) [80.109.116.125]
  by mail.gmx.net (mp009) with SMTP; 14 May 2007 04:04:05 +0200
X-Authenticated: #3831892
X-Provags-ID: V01U2FsdGVkX18j8zRGONwjC2wYhoIPXMj0HrtzCTAJTRq9m2hB7X
	ws1Kvhj6o5ViVi
Content-Disposition: inline
In-Reply-To: <20070514010831.GH4489@pasky.or.cz>
User-Agent: Mutt/1.5.10i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47216>


--9z6ln3N8ZGVHaUXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 14, 2007 at 03:08:31AM +0200, Petr Baudis wrote:
>   Hi,
>=20
> On Sun, May 13, 2007 at 02:01:52AM CEST, Michael Niedermayer wrote:
> > On Sat, May 12, 2007 at 03:39:25PM -0700, Junio C Hamano wrote:
> > > Michael Niedermayer <michaelni@gmx.at> writes:
> > >=20
> > > > * gitweb uses many terms which are new to a non git user, and while
> > > >   devlopers who work on ffmpeg will very likely very quickly have
> > > >   figured out the meaning of all of them. i think simple users who =
just
> > > >   want to browse the ffmpeg code will have their problems, so i bel=
ive=20
> > > >   a small help text linked to from all pages which contains a short
> > > >   definition of all the git(web) specific terms would be very helpf=
ull
> > > >   something like
> > > >     blob        - file      at a specific revission/date
> > > >     tree        - directory at a specific revission/date
> > > >     (short) log - project wide commit log
> > > >     history     - short log equivalent for a file or directory
> > >=20
> > > Coming fron non-CVS camp, I think changing this to non-git terms
> > > is very harmful than educating users who are migrating from
> > > other systems.
> >=20
> > you must missunderstand me :(
> > i want to educate them, but i cannot as iam not speaking about ffmpeg
> > developers/contributors but rather random people who are curious and=20
> > want to take a look at the ffmpeg source
> >=20
> > for them a simple help link similar to "ViewVC Help" which viewvc has
> > on the bottom right of its pages would be great IMHO
> > also the text above is a pure random suggestion by a svn user and was
> > not intended to redefine any git terms
>=20
>   I seriously doubt the usefulness of this. Meaning of all the links exce=
pt
> maybe blob seems immediately obvious for me, even if I try to imagine
> that I know nothing about Git; maybe I'm wrong here, I might try to do
> an experiment. :-)
>=20
>   But, even if that's the case, when a new user meets gitweb and looks
> at the 'history' link, what do you think she will do? Start hunting the
> page for some link to a glossary? I yet have to see a user like that :-)
> - I will bet that she just clicks at the link and figures out what it is
> about based on what happenned.

i agree with you that she will click on 'history' and figure out what it is
but if she wants to see the contents of one of the files then i think
she will be confused and not know where to click, and a 'help' link which
would lead to a page which explains what 'blob' is at the top of the page
would solve that with less frustration than random clicking around
(renaming blob to file_content would work too but i guess i would be
 lynched for mere suggesting ...)

this of course is not really a problem for ffmpeg, we could easily change
"our" gitweb to contain a help link

[...]
--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

The misfortune of the wise is better than the prosperity of the fool.
-- Epicurus

--9z6ln3N8ZGVHaUXG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGR8KhYR7HhwQLD6sRAjmMAJ4iXk6mRbwQZhX2jC0gpMV3zEBhkwCdFdxG
jvAH7j4GXnwU9d8Cvtuheh0=
=RNp5
-----END PGP SIGNATURE-----

--9z6ln3N8ZGVHaUXG--
