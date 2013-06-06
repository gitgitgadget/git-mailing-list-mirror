From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 06 Jun 2013 10:54:37 -0400
Message-ID: <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe 
	<rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 17:05:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukbkq-0004WX-2J
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 17:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab3FFPFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 11:05:17 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:54620 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab3FFPFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 11:05:14 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2013 11:05:13 EDT
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 8B9A6AB49; Thu,  6 Jun 2013 10:54:37 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130606:peff@peff.net::vo4k9jF8DU3mKTs2:00000zzX
X-Hashcash: 1:20:130606:jrnieder@gmail.com::KiHRkJiLgzKM1Gao:00000000000000000000000000000000000000000004T+x
X-Hashcash: 1:20:130606:trast@inf.ethz.ch::y7M9OOnpWzI+qfv+:00000000000000000000000000000000000000000000A732
X-Hashcash: 1:20:130606:ramsay@ramsay1.demon.co.uk::oEitLVx0hK71wuVw:000000000000000000000000000000000002NKZ
X-Hashcash: 1:20:130606:rene.scharfe@lsrfire.ath.cx::I9CKVdPp3MN89Y+z:00000000000000000000000000000000001h4b
X-Hashcash: 1:20:130606:matthieu.moy@grenoble-inp.fr::fZ/6esaIwSBmW+H2:000000000000000000000000000000000E3v4
X-Hashcash: 1:20:130606:johannes.schindelin@gmx.de::McXBquNMJ8JGGwUY:000000000000000000000000000000000002r3Q
X-Hashcash: 1:20:130606:felipe.contreras@gmail.com::kbcQwMJxWOwmRDRG:000000000000000000000000000000000000krI
X-Hashcash: 1:20:130606:kusmabite@gmail.com::ZUN8CqDZEwvYwFA9:00000000000000000000000000000000000000000024lw
X-Hashcash: 1:20:130606:j6t@kdbg.org::NO8xm/LqPmBR8Yjx:00000Es7V
X-Hashcash: 1:20:130606:pclouds@gmail.com::pYC8XBiJ5REp7EoZ:000000000000000000000000000000000000000000000Eh2
X-Hashcash: 1:20:130606:git@vger.kernel.org::Q/h4HQ0GY0PM/N+q:0000000000000000000000000000000000000000009T40
X-Hashcash: 1:20:130606:mhagger@alum.mit.edu::99FlzTfAN7dT/Nz6:000000000000000000000000000000000000000005AtD
X-Hashcash: 1:20:130606:gitster@pobox.com::tbOADF+L5BQ56WBL:00000000000000000000000000000000000000000000BNkU
In-Reply-To: <7va9n52zjc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 04 Jun 2013 17:04:39 -0700")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226509>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


As one of the people who helps maintain git packages in pkgsrc, my
initial reaction is negative to adding a ruby dependency.  There are
several not-entirely-related reasons:

git is a core tool that people use on almost the smallest of boxes,
perhaps even replacing rcs for managing local config files.  On such
machines, even perl may be large, but a second scripting language seems
excessive.  On a NetBSD 6 i386 system, the size of the ruby193-base
binary package (as installed) is 25 MB (vs 15 MB for the git base
package, which lacks gitk and docs).  (Presently, the git base package
defaults to requiring python and installing the git_remote_helpers, but
I think that's a bug.)  perl is 54 MB.

I am unclear on how mature/stable ruby is.  perl has a good track record
over the last many years.  In particular, no one in pkgsrc has felt the
need to support multiple concurrent versions of perl.  But there
presently exists both 1.8 and 1.9 in pkgsrc (and there are multiple
python verions).  So given how critical git is on many systems, I'd ask
if the ruby requirement is for a stable vs old vs bleeding-edge version,
and how that is expected to function over the next 5 years.  (With perl,
the answer seems to be "any half-way modern version of 5.x is fine, from
unreasonably old to the latest release".)  By stable, I don't mean that
a particular ruby release works well.  I mean the experience of having
code that depends on ruby over many years, and whether one can just use
whatever ruby happens to be there, or whether it's effort to manage
having an acceptable version.

From=20a packaging viewpoint, dependencies are costly, because they force
build and installation of them before the package can be built.  In a
source-centric packaging environment (where it's normal to build, rather
than only having pre-built packages), the question is if the git package
needs ruby, which is a different question than whether something in git
which may be optional needs ruby.  So if ruby, or something else, is
needed for optional components, it would be really nice if the build
system were such that it was simple (via arguments to configure,
selecting subdirs, or something functionally similar) to build the main
part, and then the ruby part as a separate build.  Then, it would be
pretty easy to have git-ruby package that has the ruby parts.  But if
the ruby part isn't considered optional, that won't work.  (Note that
the usual GNU/Linux approach of split binary packages doesn't really
address this, because as I understand it you need the union of the
dependencies installed to build once, and then tar up the resulting bits
separately.  So that fixes the problem for people that install binaries,
but doesn't help building from source.)

tcl/tk is another dependency, but it seems limited to gitk.  pkgsrc has
a separate scmgit-gitk package, which is relatively easy to maintain
because it just involves selecting subdirs to build.  So that's an
example of a good way to do it, from the source-based packaging
viewpoint.

Finally, I realize that most people on this list will build git directly
From=20sources.  While that of course has to be smooth, I think great
weight should be given to how packaging systems use releases and how
that impacts packaging effort and the eventual user experience.  I would
guess that over 99% of git users are running binaries built from a
packaging system.


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iEYEARECAAYFAlGwoq0ACgkQ+vesoDJhHiW3HACgmg7DAvI/xXcc4IBSRfNWqXaX
rboAnRE59r/cmlqAeHGpqcEVe0VF06rp
=DPfd
-----END PGP SIGNATURE-----
--=-=-=--
