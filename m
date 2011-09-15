From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
Subject: Re: Anybody home?
Date: Thu, 15 Sep 2011 11:43:56 +0200
Message-ID: <1316079837.2019.18.camel@bee.lab.cmartin.tk>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
	 <4E71A5FF.5040807@viscovery.net>
	 <CAOZxsTqGt=gYr3t7e5Ma4z6W9wt_JxrgsNSGFGVbtk2rc3LZ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-1SV1JCPPo3Lkz+0nHKtp"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 11:44:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R48UF-0002dO-Af
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 11:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322Ab1IOJn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 05:43:59 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:44251 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab1IOJn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 05:43:58 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 66EAE460AC;
	Thu, 15 Sep 2011 11:43:39 +0200 (CEST)
In-Reply-To: <CAOZxsTqGt=gYr3t7e5Ma4z6W9wt_JxrgsNSGFGVbtk2rc3LZ9w@mail.gmail.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181452>


--=-1SV1JCPPo3Lkz+0nHKtp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-09-15 at 02:01 -0700, Joshua Stoutenburg wrote:
> > Reading your exchanges elsewhere in this thread, I think you missed tha=
t
> > you don't need a git server at all just to *use* git.
> >
> > Even when you want to exchange your commits between two or three machin=
es,
> > all you need is ssh access. There is no *git server* necessary. git is =
not
> > svn. ;-)
> >
> > I thought I'd just mention this to help you streamline your search.
> >
> > -- Hannes
> >
>=20
> I read the first four and a half chapters from the Pro Git book pdf.
> So I think I understood that much.
>=20
> But in my situation, I do need a server so that other developers can
> access anytime over the internet.

If the code shouldn't be made public, then you should take a look at
gitolite[0]. Otherwise, you can just host it on gitorious.org or
github.com

[0] https://github.com/sitaramc/gitolite

   cmn

>=20
> I should have mentioned that.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--=-1SV1JCPPo3Lkz+0nHKtp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOccjcAAoJEHKRP1jG7ZzTPLkH/1bWrwgdlzlB6hLoNbdR2Za8
LEOlKuOC0CSXHKOZMZa/nnbfes2bvPi+4bpDCVK9QJDWTZNFVevBay6Uj8t2JEer
Pf/bwVQIxfXTUWJDIHGRQffvVvxFdzNcEbBwdCFyU8CflUkoIjgKHdyrH9WjKWGF
9proqcYIOrU55KF7ool79GmKC04xvtWEe15Ct3vsaZuX8Zwj2wIiy7Ar6rbv38At
ZTrPzcTm2iUjWDiQdJF1FrKR3219bWTA4vKjcpDYAa7eQj8GZ8okKDjZEmpg5Jqu
EWhBBySoJjt9nslgMiicn2LoiL2hQTU7eQwhYlUw4rTbxRUSQjrJToq8cUAj/QE=
=DoB8
-----END PGP SIGNATURE-----

--=-1SV1JCPPo3Lkz+0nHKtp--
