From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Questions on gitosis
Date: Mon, 20 Sep 2010 23:07:25 +0000
Message-ID: <robbat2-20100920T230503-994460874Z@orbis-terrarum.net>
References: <26E9B811E137AB4B95200FD4C950886BA3AC1997@orsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
To: "Olsen, Alan R" <alan.r.olsen@intel.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 01:14:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxpZ1-0008Qf-WA
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 01:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910Ab0ITXOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 19:14:10 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:48574 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753940Ab0ITXOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 19:14:09 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2010 19:14:09 EDT
Received: (qmail 24573 invoked from network); 20 Sep 2010 23:07:27 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Mon, 20 Sep 2010 23:07:27 +0000
Received: (qmail 29975 invoked by uid 10000); 20 Sep 2010 23:07:25 -0000
Content-Disposition: inline
In-Reply-To: <26E9B811E137AB4B95200FD4C950886BA3AC1997@orsmsx507.amr.corp.intel.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156678>


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2010 at 03:15:02PM -0700,  Olsen, Alan R wrote:
> Is gitosis currently maintained? Who do I contact?
The original author hasn't touched anything since this time last year.
We do have a fork of it at Gentoo:
http://git.overlays.gentoo.org/gitweb/?p=3Dproj/gitosis-gentoo.git

However we are looking at migrating the Gentoo Gitosis instances to
Gitolite in the near future.

> I have a list of bugs in the current version that I would like to see
> fixed. I can post them here if needed. (It will at least get them
> picked up by the usual search engines.)
At the very least, I'd love to see them and perhaps apply them in
Gentoo.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkyX6S0ACgkQPpIsIjIzwixSHQCfcCu+Xhxpa4yDdzENlju8Xduk
vQYAoNmDkPAnI7mY/e2qHE82c0EJWZbs
=fx6G
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
