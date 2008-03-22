From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] rebase with preserve merges should not show merged
	commits
Date: Sat, 22 Mar 2008 10:43:31 +0100
Message-ID: <20080322094331.GB30074@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803220231020.4124@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 10:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd0Km-000105-DF
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 10:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbYCVJr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 05:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbYCVJrW
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 05:47:22 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1230 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbYCVJrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 05:47:21 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id DD518488033; Sat, 22 Mar 2008 10:47:19 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd0G1-0002CB-QZ; Sat, 22 Mar 2008 10:43:21 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd0GB-0007pm-Qu; Sat, 22 Mar 2008 10:43:31 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803220231020.4124@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77795>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo,

Johannes Schindelin schrieb am Sat 22. Mar, 02:33 (+0100):
> On Sat, 22 Mar 2008, J=C3=B6rg Sommer wrote:
>=20
> > The current version of git-rebase--interactive shows the user the=20
> > commits coming from a merge.
> >=20
> > M---A---B
> >  \       \
> >   o---o---+---o branch
> >=20
> > Rebasing branch on M with preserve merges gives the commits A and B. Bu=
t=20
> > if you mark them for editing or remove them the rebase fails. You must=
=20
> > keep them as they are. It's useless to bother the user with these=20
> > commits and might lead to mistakes.
>=20
> I don't understand.  Rebasing with "rebase --onto <something else> M"=20
> _should_ show A and B.

But IMO not =E2=80=9Crebase --onto <something else> --preserve-merges -i M=
=E2=80=9D.

Sch=C3=B6ne Gr=C3=BC=C3=9Fe, J=C3=B6rg.
--=20
Geld allein macht nicht gl=C3=BCcklich, aber es ist besser in einem Taxi zu
weinen, als in der Stra=C3=9Fenbahn.
	       	   	       			(Marcel Reich=E2=80=90Ranicki)

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH5NTDwe0mZwH1VIARApoGAJ4zMDGFf6zAA7HOvRm1XeaoCPgt9wCaA/GY
jDW7ldWdbhPRpP/eFWb4QRM=
=0UTh
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
