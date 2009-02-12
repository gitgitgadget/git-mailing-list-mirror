From: martin f krafft <madduck@debian.org>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 09:48:11 +0100
Organization: The Debian project
Message-ID: <20090212084811.GA14261@piper.oerlikon.madduck.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
To: Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 09:49:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXXGZ-0007uw-RB
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 09:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbZBLIsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 03:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbZBLIsY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 03:48:24 -0500
Received: from clegg.madduck.net ([193.242.105.96]:54725 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbZBLIsX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 03:48:23 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id E0EB71D409B;
	Thu, 12 Feb 2009 09:48:12 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 00B7F9F13D;
	Thu, 12 Feb 2009 09:48:11 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 8DAB84454; Thu, 12 Feb 2009 09:48:11 +0100 (CET)
Mail-Followup-To: Aneesh Kumar <aneesh.kumar@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8981/Thu Feb 12 01:28:11 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109586>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Aneesh Kumar <aneesh.kumar@gmail.com> [2009.02.12.0909 +0100]:
> doing a tg update with latest git gives the below error
>=20
> [extent_validate@linux-2.6]$ tg update
> fatal: Refusing to point HEAD outside of refs/heads/
> [extent_validate@linux-2.6]$

Which version? And could you please provide (a lot) more information
about your repository or make it available?

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"to me, vi is zen. to use vi is to practice zen. every command is
 a koan. profound to the user, unintelligible to the uninitiated.
 you discover truth everytime you use it."
                                       -- reddy =E4t lion.austin.ibm.com

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmT4ksACgkQIgvIgzMMSnXQdACg7grzZUFtfGj5HhRNzcl/LNO5
2TcAoL58qUftIPASpYr3fcQLJlXwT+Op
=RxzZ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
