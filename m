From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: [PATCH] Documentation: fix git-config.xml generation
Date: Wed, 23 May 2007 23:10:02 -0500
Message-ID: <1179979802.3682.12.camel@lt21223.campus.dmacc.edu>
References: <3f80363f0705231516x7c6fa2daua33a708deaa7a10c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E3sXF5yBV8A9ro7B15wd"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 06:09:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr4dQ-0007u3-NP
	for gcvg-git@gmane.org; Thu, 24 May 2007 06:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761641AbXEXEJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 00:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761560AbXEXEJE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 00:09:04 -0400
Received: from homer.isunet.net ([63.175.164.9]:39884 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761348AbXEXEJB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 00:09:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id DFA1A3881A0
	for <git@vger.kernel.org>; Wed, 23 May 2007 22:16:03 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 15009-03 for <git@vger.kernel.org>; Wed, 23 May 2007 22:16:03 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 08F14388198
	for <git@vger.kernel.org>; Wed, 23 May 2007 22:16:03 -0500 (CDT)
Received: from [172.16.0.186]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1Hr4dQ-0005Nv-6f
	for git@vger.kernel.org; Wed, 23 May 2007 23:09:08 -0500
In-Reply-To: <3f80363f0705231516x7c6fa2daua33a708deaa7a10c@mail.gmail.com>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48216>


--=-E3sXF5yBV8A9ro7B15wd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-23 at 18:16 -0400, James Bowes wrote:
>
> With asciidoc 8.1.0 and xmlto 0.0.18, git-config.xml failed to
> validate. This patch just makes the asciidoc formatting for
> branch.autosetupmerge the same as the other config options.

I can confirm that this patch fixes the validation errors...

Jeff


--=-E3sXF5yBV8A9ro7B15wd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGVRAWrtk7xyyIQRERAhTeAJ9xL8yMqtGw320PcZntq1W2i2z/FwCdEET3
kEXcCkxduD/5XUnGsyluskY=
=42Vy
-----END PGP SIGNATURE-----

--=-E3sXF5yBV8A9ro7B15wd--
