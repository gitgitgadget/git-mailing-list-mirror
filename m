From: Jan Hudec <bulb@ucw.cz>
Subject: Re: suggestions for gitweb
Date: Tue, 15 May 2007 17:46:13 +0200
Message-ID: <20070515154613.GB3653@efreet.light.src>
References: <20070512205529.GS14859@MichaelsNB> <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net> <20070513000151.GT14859@MichaelsNB> <20070514010831.GH4489@pasky.or.cz> <20070514020001.GX14859@MichaelsNB>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Michael Niedermayer <michaelni@gmx.at>
X-From: git-owner@vger.kernel.org Tue May 15 17:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnzED-0001Fu-0J
	for gcvg-git@gmane.org; Tue, 15 May 2007 17:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbXEOPqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 11:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbXEOPqP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 11:46:15 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:57058 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755003AbXEOPqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 11:46:15 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id CD20876D63;
	Tue, 15 May 2007 17:46:13 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HnzE5-0001BZ-Et; Tue, 15 May 2007 17:46:13 +0200
Content-Disposition: inline
In-Reply-To: <20070514020001.GX14859@MichaelsNB>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47352>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 14, 2007 at 04:00:02 +0200, Michael Niedermayer wrote:
> On Mon, May 14, 2007 at 03:08:31AM +0200, Petr Baudis wrote:
> >   But, even if that's the case, when a new user meets gitweb and looks
> > at the 'history' link, what do you think she will do? Start hunting the
> > page for some link to a glossary? I yet have to see a user like that :-)
> > - I will bet that she just clicks at the link and figures out what it is
> > about based on what happenned.
>=20
> i agree with you that she will click on 'history' and figure out what it =
is
> but if she wants to see the contents of one of the files then i think

Well, before clicking it, she will move the mouse pointer over it. And eith=
er
look for tooltip -- which sadly won't come up -- or read the url -- with
sadly isn't much help.

> she will be confused and not know where to click, and a 'help' link which
> would lead to a page which explains what 'blob' is at the top of the page
> would solve that with less frustration than random clicking around

IMHO providing tooltips would probably solve it with even less frustration.
If the user comes to the page, she will probably quickly notice, that the
links have tooltips. And than going over all the links with the pointer and
reading the tooltips is a lot easier and faster than switching to a help
page. Besides people don't want to admit, even to themselves, they don't
understand something to a point they should read the docs, so they won't re=
ad
it. But anybody will read the tooltips -- they don't look like docs.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSdXFRel1vVwhjGURAnpkAKCS5zugIlBm1A8qlP8mtTGQ6avQbwCcCs3D
JwhhfABAvhTMbqKIG300skM=
=gS8p
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
