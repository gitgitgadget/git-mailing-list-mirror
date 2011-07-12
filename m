From: Damien Wyart <damien.wyart@gmail.com>
Subject: Re: Tracking changes in git with a change number....
Date: Tue, 12 Jul 2011 07:37:35 +0200
Message-ID: <20110712053735.GA4539@brouette>
References: <C785F567A08DDE449FD4590C91E6AD13CB34BE@naeamillez01v.nadsusea.nads.navy.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Cc: git@vger.kernel.org
To: "Rice, James M CIV NSWCDD, K73" <james.rice2@navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgVmc-0004Cq-EL
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 07:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab1GLFpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 01:45:06 -0400
Received: from mailhost-t5-m3.mangoosta.org ([78.40.49.210]:10406 "EHLO
	smtp-delay2.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751974Ab1GLFpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 01:45:05 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2011 01:45:05 EDT
Received: from mallaury.nerim.net (smtp-101-monday.noc.nerim.net [62.4.17.101])
	by smtp-delay2.nerim.net (Postfix) with ESMTP id E9EC419CF3C0
	for <git@vger.kernel.org>; Tue, 12 Jul 2011 07:21:03 +0200 (CEST)
Received: from brouette (damien.wyart.pck.nerim.net [213.41.244.197])
	by mallaury.nerim.net (Postfix) with ESMTP id 2D254153411;
	Tue, 12 Jul 2011 07:37:36 +0200 (CEST)
Received: by brouette (Postfix, from userid 1000)
	id ED75D400FBC; Tue, 12 Jul 2011 07:37:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <C785F567A08DDE449FD4590C91E6AD13CB34BE@naeamillez01v.nadsusea.nads.navy.mil>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176915>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

* Rice, James M CIV NSWCDD, K73 <james.rice2@navy.mil> [2011-07-11 13:29]:
> In our organization we track changes via a Change Request (CR) number.
> We may end up with multiple commits, by one or more users under
> a single CR number. When we deliver our CM folks want to be able to
> see all the files that have changed for a particular CR number. Is
> there an elegant way to do this in git?

Hi. The Gerrit code review tool comes with such a feature, explained on
this page:
http://gerrit.googlecode.com/svn/documentation/2.2.0/user-changeid.html

Best,
--=20
Damien Wyart

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4b3Z8ACgkQIlmjAUxrhBBMQACfdSxI3Gj0o3rNiKG/snolvKqx
2poAn3bbEzWUu5kYXbzupACvMZ+afG5w
=fBtg
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
