From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] Pay attention to GIT_DIR when searching the git
	directory
Date: Mon, 5 May 2008 14:53:02 +0200
Message-ID: <20080505125302.GA11523@alea.gnuu.de>
References: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de> <alpine.DEB.1.00.0805051234260.30431@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Cc: git@vger.kernel.org, jjengla@sandia.gov
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 05 15:22:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt0dh-0002u3-VP
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 15:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbYEENVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 09:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbYEENVG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 09:21:06 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4766 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973AbYEENVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 09:21:05 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id D65DCEC058; Mon,  5 May 2008 15:21:03 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jt0Bj-00045Q-4e; Mon, 05 May 2008 14:53:03 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jt0Bi-00030w-OL; Mon, 05 May 2008 14:53:02 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805051234260.30431@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81278>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Johannes Schindelin schrieb am Mon 05. May, 12:36 (+0100):
> On Mon, 5 May 2008, J=C3=B6rg Sommer wrote:
>=20
> >  contrib/hooks/setgitperms.perl |    2 +-
>=20
> This tells me more...
>=20
> Please keep in mind that the commit log is meant to demonstrate the=20
> _intention_ of the patches.

The intention is that the variable GIT_DIR is respected when searching
for the git dir.

> If you do not say _what_ is affected by the change, you only confuse
> the readers.

Do you want something like =E2=80=9Cinitialization: Pay attention to GIT_DI=
R when
searching the git directory=E2=80=9D?

Is there a document with guidelines for commit messages, e.g. write the
first letter upper or lower case?

Bye, J=C3=B6rg.
--=20
Die Katze steht im Mittelpunkt unserer Arbeit.
Alles was wir tun, ist f=C3=BCr sie.

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIHwMuwe0mZwH1VIARAr6vAJ9aoxpZXXNKYvvBBoOEpH6sKyopHgCaA21B
YtakaTI9Mt72Vv+Dlol7QrY=
=VevS
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
