From: Joey Hess <joey@kitenet.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 13:14:57 -0500
Message-ID: <20100120181456.GA31507@gnu.kitenet.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201049.01108.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 19:15:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXf5G-0003kc-Ry
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 19:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab0ATSPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 13:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711Ab0ATSPE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 13:15:04 -0500
Received: from wren.kitenet.net ([80.68.85.49]:54778 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab0ATSPB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 13:15:01 -0500
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 1E997118FF6
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 13:15:00 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 20593298023; Wed, 20 Jan 2010 13:14:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <201001201049.01108.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137559>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thomas Rast wrote:
> Umm.  git-log is porcelain and we're allowed to change it.  Worse,
> even the user can change it in very significant ways, just try:
>=20
>   git config format.pretty email
>   git log

Is git log --pretty=3Draw --raw really intended to be porcelain?
Above does not affect it.

> For a better alternative, I'm afraid you'll either have to look to
> git-rev-list (which also takes --pretty) or 'git cat-file --batch'.

I don't see a way to get the per-commit diff-tree info using rev-list.

--=20
see shy jo

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBS1dIHckQ2SIlEuPHAQhn5A//Rjn6cYBD95I4NlF90Ip+tEPLa3TdZCss
yw+Aqj6XUnoH+tOR21NTKaUbtBEV1WU6SJUc/AxVm4u2iV3yqweg1kNclY4p+Inf
3XbI5TMqzGsO+GLpp3cNl6nVZKFxIURfpGoWhX3TiLvtY8fs7bpBOpkL/WhsDn8Y
l7/cU6x01noUDIBYs3VQhs/okV+GXUh05mQsE61DQWxMEcUz8MknyQms2F3ecu0s
IvkhnpZO19e3IfPzQ16ziXtK03CVLlZLAe4pgM0NvS09HiZ6NyaFAWoN09tkzQNS
iWNu5DbsRsKiKuL6+RTyxJJUap43nA+833gKn4TSdYfQSyKq4rBYfctj/miXlqMn
qMesc5CLhbOHLOQryocpZfOB0orsWoxLum0lQgQSNke6NJabMOrqNrGnAK4Fs6Dv
yR+WGUvJrvyEsjNXN7Xws2rnLsGvEV10R+sM5pLR66olOYQvJ57KLWG3UeTwWVkH
azpu6BfQn9hzD4x+Hh1ij7k175TXLM2CYbXKVUtIqMhs7GBcOxFr8vfWkMRNk6V2
u3otsvr1ezrCuyAnxnrKanhnWCk2vwe7lolGTLvpwUPWLbYbK/LcS+9LeSILae6c
nsCGSjl9L67/X23RapMTDQq42fTO6bX7iNnalow1azWoNIFAQv0RZSHfqjhwpJfo
ADbw6g6djjA=
=IeH/
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
