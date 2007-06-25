From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 25 Jun 2007 10:47:00 -0500
Message-ID: <1182786420.3821.28.camel@lt21223.campus.dmacc.edu>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	 <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	 <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	 <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	 <7virac547s.fsf@assigned-by-dhcp.cox.net>
	 <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	 <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
	 <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
	 <7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
	 <7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fp8J+v9XMJxSQbc6H5Qp"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 17:47:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2qmW-0003rd-IW
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 17:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbXFYPrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 11:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbXFYPrI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 11:47:08 -0400
Received: from homer.isunet.net ([63.175.164.9]:49473 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbXFYPrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 11:47:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id BA9A43880BD
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 09:56:15 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 13330-08 for <git@vger.kernel.org>; Mon, 25 Jun 2007 09:56:14 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 71A5C38806C
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 09:56:14 -0500 (CDT)
Received: from [161.210.6.122]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1I2qmR-0000dY-7Y
	for git@vger.kernel.org; Mon, 25 Jun 2007 10:47:07 -0500
In-Reply-To: <7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50902>


--=-fp8J+v9XMJxSQbc6H5Qp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-06-25 at 02:43 -0700, Junio C Hamano wrote:
>
> * jo/init (Thu Jun 7 07:50:30 2007 -0500) 2 commits
>  - Quiet the output from git-init when cloning, if requested.
>  - Add an option to quiet git-init.
>=20
> I am not very much interested in this but I do not have any
> strong or otherwise feeling against it either.

It seems to me that this series is more about "DWIM" than anything.  A
na=C3=AFve user would expect "git clone -q" to silcence _all_ non-error
output. The output "Initialized empty Git repository in .git/" that you
get from "git init" isn't an error...

Jeff

--=-fp8J+v9XMJxSQbc6H5Qp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGf+Nvrtk7xyyIQRERAl+FAJ45wKSskAgwwjeum8fdnqCys7WRIQCfazKq
FUxLBeGOHLBpQSmhE87ik9w=
=sz0v
-----END PGP SIGNATURE-----

--=-fp8J+v9XMJxSQbc6H5Qp--
