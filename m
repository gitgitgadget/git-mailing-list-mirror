From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Perforce support.
Date: Sun, 15 Jul 2007 19:51:52 +0200
Message-ID: <20070715175152.GA18293@efreet.light.src>
References: <69b0c0350707121134t61905e87xaa2fc78c30891bb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Cc: git@vger.kernel.org
To: Govind Salinas <govindsalinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 19:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA8GH-0007Ea-3Q
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 19:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbXGORv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 13:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760552AbXGORv6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 13:51:58 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:44839 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbXGORv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 13:51:57 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 25F4957368;
	Sun, 15 Jul 2007 19:51:56 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id kcqrvs9BrvO4; Sun, 15 Jul 2007 19:51:54 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 87D45572E3;
	Sun, 15 Jul 2007 19:51:54 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IA8G8-0006Kn-Tc; Sun, 15 Jul 2007 19:51:52 +0200
Content-Disposition: inline
In-Reply-To: <69b0c0350707121134t61905e87xaa2fc78c30891bb0@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52573>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2007 at 11:34:56 -0700, Govind Salinas wrote:
> I have been playing around with git for a month or so and have started
> writing, what I hope will be, a nice GUI over git that works well on
> Windows (Cygwin) and offers some feeling of familiarity to our
> Perforce users.  That however is only half the problem.

There are already several guis for git. None of them covers complete git
functionality, but if you can start adding functionality to one of them
instead of starting from scratch, it would give you a good head start. At
least the git-gui (in Tcl/Tk, part of git distribution) and qgit4
(git://repo.or.cz/qgit4.git, discuss changes on the git mailing list -- se
also http://digilander.libero.it/mcostalba/, but that only discusses the
previous Qt3-based branch) work on Windows.

> We need to be able to go back and forth to our main Perforce depot,
> and while I understand that git-svn support is very good, I have only
> seen limited support of Perforce.  I was wondering if anyone has been
> using git with p4 and how well did it work.  We have very complex and
> somewhat large "clients" that do a lot of mapping of directories
> (which strikes me as particularly insane) and I was wondering if any
> of the tools support that.
>
> If anyone has any suggestions/guidance on how to do this I would apprecia=
te=20
> it.

Search the list. The archive at http://marc.info/?l=3Dgit provides quite
sensible search support. There were some interesting discussions about
perforce in last few months.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGml64Rel1vVwhjGURAgrXAJ90s0vOYv9DJ4YeOY+HjBzl9iu9kgCdH8tg
Qlcl0+6PtaWyrad9PDwQKZg=
=IXva
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
