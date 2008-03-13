From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [Q] Encrypted GIT?
Date: Thu, 13 Mar 2008 13:16:44 +0100
Message-ID: <20080313121644.GD2414@genesis.frugalware.org>
References: <c6c947f60803130148w7981a3f0r718c0801343c7b78@mail.gmail.com> <20080313114738.GC2414@genesis.frugalware.org> <alpine.LSU.1.00.0803131254580.1656@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="twKjCw1/F6C/WBH6"
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 13:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZmNC-0003rZ-AY
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 13:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbYCMMQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYCMMQr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 08:16:47 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50015 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbYCMMQq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 08:16:46 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 60B8E1B258A;
	Thu, 13 Mar 2008 13:16:45 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8596444697;
	Thu, 13 Mar 2008 13:13:56 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F2AC2119053C; Thu, 13 Mar 2008 13:16:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803131254580.1656@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77067>


--twKjCw1/F6C/WBH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2008 at 12:55:11PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> The latter can be remedied (somewhat) by encrypting each object=20
> individually.  In that case, .gitattributes can help (you should be able=
=20
> to find a mail to that extent, which I sent no more than 2 weeks ago). =
=20
> However, you must make sure that the encryption is repeatable, i.e. two=
=20
> different encryption runs _must_ result in _identical_ output.

afaik, this is not the case for gpg.

--twKjCw1/F6C/WBH6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH2Rsse81tAgORUJYRAhMsAKCeQfshwdJWrudtUPJ4GZYjlViqcwCgnfHG
/m4QnbcG2405QAKu8T8xkZw=
=CXUQ
-----END PGP SIGNATURE-----

--twKjCw1/F6C/WBH6--
