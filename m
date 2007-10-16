From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 10:26:07 -0500
Message-ID: <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	 <471476B7.5050105@users.sourceforge.net>
	 <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	 <47148F72.1090602@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qn72x4N9ar17GNNWIzKk"
Cc: Lars Hjemli <lh@elementstorage.no>,
	Michael Witten <mfwitten@mit.edu>, git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhohZ-0000Jy-Dg
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359AbXJPPvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 11:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933274AbXJPPvO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:51:14 -0400
Received: from homer.isunet.net ([63.175.164.9]:39873 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932600AbXJPPvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 11:51:14 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2007 11:51:13 EDT
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id DFE2A388157;
	Tue, 16 Oct 2007 09:36:33 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 01859-05; Tue, 16 Oct 2007 09:36:31 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id E0D8838802A;
	Tue, 16 Oct 2007 09:36:30 -0500 (CDT)
Received: from [172.16.2.6]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1IhoJ7-0002Dq-5E; Tue, 16 Oct 2007 10:26:09 -0500
In-Reply-To: <47148F72.1090602@users.sourceforge.net>
X-Mailer: Evolution 2.10.3 (2.10.3-4.fc7) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61199>


--=-qn72x4N9ar17GNNWIzKk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-16 at 12:16 +0200, Adam Piatyszek wrote:
>=20
> And if one change the tab size, it will result in a messy alignment in
> line 5.

Which is why one should never should change the tab size from anything
but 8.

> I guess there is no ideal solution for this in Emacs.

Instead of using "(setq indent-tabs-mode t)" use "(setq indent-tabs-mode
nil)".  This will force emacs to always use spaces to indent.

Jeff


--=-qn72x4N9ar17GNNWIzKk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHFNgLrtk7xyyIQRERApk5AJ4jpBpeZpU02VbwF5gLQvFhaTaVnQCfa7Q8
/andQdEZa9c/d0BmhdLMu/g=
=oxlD
-----END PGP SIGNATURE-----

--=-qn72x4N9ar17GNNWIzKk--
