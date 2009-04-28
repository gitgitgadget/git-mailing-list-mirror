From: martin f krafft <madduck@madduck.net>
Subject: Re: (topgit question) deleting a dependency
Date: Tue, 28 Apr 2009 11:41:38 +0200
Message-ID: <20090428094138.GB9415@piper.oerlikon.madduck.net>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
To: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 11:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyjpW-0007uN-Ck
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 11:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424AbZD1Jlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 05:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756252AbZD1Jlx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 05:41:53 -0400
Received: from clegg.madduck.net ([193.242.105.96]:54029 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559AbZD1Jlw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 05:41:52 -0400
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "piper.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id D64441D409B;
	Tue, 28 Apr 2009 11:41:38 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 3DFE7C156F; Tue, 28 Apr 2009 11:41:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.29-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9297/Mon Apr 27 22:30:26 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117760>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sitaram Chamarty <sitaramc@gmail.com> [2009.04.28.1049 +0200]:
> [Apologies if this is not the right place to ask; please let
> me know if so...]

It is...

> I know "tg depend" only has the "add" subcommand right now,
> but is there a manual way of getting the effect of a
> hypothetical "tg depend remove"?

No, not yet, see http://bugs.debian.org/505303 for further
discussion on the issue.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"perfection is achieved, not when there is nothing more to add, but
 when there is nothing left to take away."
                                         -- antoine de saint-exup=E9ry
=20
spamtraps: madduck.bogus@madduck.net

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn2z1EACgkQIgvIgzMMSnXlMwCeIAk6ksPYX4hdhE+xjhmal/FY
4goAn3uquSUg8r9I3CelK0Yc/8SDH6d0
=5zwC
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
