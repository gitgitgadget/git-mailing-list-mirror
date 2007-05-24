From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: [PATCH] Documentation: fix git-config.xml generation
Date: Wed, 23 May 2007 23:43:32 -0500
Message-ID: <1179981812.3682.16.camel@lt21223.campus.dmacc.edu>
References: <3f80363f0705231516x7c6fa2daua33a708deaa7a10c@mail.gmail.com>
	 <1179979802.3682.12.camel@lt21223.campus.dmacc.edu>
	 <7vhcq2zw7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EDtaiUGNjz58ceBfPKkj"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 06:42:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr5A0-00045E-Mz
	for gcvg-git@gmane.org; Thu, 24 May 2007 06:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759862AbXEXEm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 00:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759918AbXEXEm3
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 00:42:29 -0400
Received: from homer.isunet.net ([63.175.164.9]:42527 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759862AbXEXEm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 00:42:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id 367AA3881D8
	for <git@vger.kernel.org>; Wed, 23 May 2007 22:49:31 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 18213-02 for <git@vger.kernel.org>; Wed, 23 May 2007 22:49:30 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 3539C3881D3
	for <git@vger.kernel.org>; Wed, 23 May 2007 22:49:30 -0500 (CDT)
Received: from [172.16.0.186]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1Hr59n-0005Tw-DP
	for git@vger.kernel.org; Wed, 23 May 2007 23:42:35 -0500
In-Reply-To: <7vhcq2zw7y.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48218>


--=-EDtaiUGNjz58ceBfPKkj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-23 at 21:22 -0700, Junio C Hamano wrote:
> "Jeffrey C. Ollie" <jeff@ocjtech.us> writes:
>=20
> > On Wed, 2007-05-23 at 18:16 -0400, James Bowes wrote:
> >>
> >> With asciidoc 8.1.0 and xmlto 0.0.18, git-config.xml failed to
> >> validate. This patch just makes the asciidoc formatting for
> >> branch.autosetupmerge the same as the other config options.
> >
> > I can confirm that this patch fixes the validation errors...
>=20
> Yup, already pushed out about 7 hours ago.

I do not see it in any of the public git repos.  Is there some
synchronization interval I need to wait for?

Jeff


--=-EDtaiUGNjz58ceBfPKkj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGVRfvrtk7xyyIQRERAsKkAJ98k4Sw8msNgHQD6fBU8B7yPHw/PQCeKcdd
Thp7dnszLuyTHQEI6vtnP6k=
=D+la
-----END PGP SIGNATURE-----

--=-EDtaiUGNjz58ceBfPKkj--
