From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Sat, 13 Jun 2015 15:28:59 +0000
Message-ID: <20150613152859.GE29305@vauxhall.crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
 <20150610235114.GA786544@vauxhall.crustytoothpaste.net>
 <20150611000251.GB786544@vauxhall.crustytoothpaste.net>
 <xmqqpp53gkmq.fsf@gitster.dls.corp.google.com>
 <xmqq4mmef22j.fsf@gitster.dls.corp.google.com>
 <20150612203054.GA29305@vauxhall.crustytoothpaste.net>
 <xmqqvbesbmm6.fsf@gitster.dls.corp.google.com>
 <20150612222713.GD29305@vauxhall.crustytoothpaste.net>
 <557BEDA9.30809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 13 17:29:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3nMw-0003A1-14
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 17:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbbFMP3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 11:29:08 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42477 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057AbbFMP3F (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 11:29:05 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:81d4:30df:5b4f:7cad])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8E8D22808F;
	Sat, 13 Jun 2015 15:29:04 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <557BEDA9.30809@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271559>


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2015 at 10:45:29AM +0200, Michael Haggerty wrote:
> In the same email where I made those design suggestions, I also I
> pointed out a bug in the implementation of parse_oid_hex(). Maybe that
> is the reason for the test failures.

It probably is, although I either botched a conversion in the branch I'm
working on as well, or the area for that code is lacking tests, since I
don't think the tests are failing there.  In the latter case, I'll send
a testsuite patch as part of my next series.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVfEw7AAoJEL9TXYEfUvaLDqgQANAPmOA8jIJ/xEAA/NM4KycC
Knk/rgfHoePbUqAFvKpS9KNL3lpwCp41WHtqJDggsk4unCChxwrcStELtDr+Ladp
CdDA8l7i1zT6o84JmL8qkN/Y6T8V7a/KH/wQo7qZIWy657QoG9pS3M1pvXzMULNE
VNotlAQgRnmkGlMOIAGUWemgWxsjUzKJE0zCVA+/LuulapeM24JB99ZOwBcg8wyb
YZDqH5ZpG5MSDiCyG/RDynZTcW+vL6g/W5s+5HAgQDRN/y6wvDzGJ9tz3XkaAINI
ue76vMrV02bjrzpC12xUs6lfAn/ilPxuf8vb2QFeR2CmFyUIVf9//FpGhBL1QKeM
HLKt5AwnkXf1OaI7aT3gB+C7tinm88rlqnhEkt6T9WWlCO0H4cCcWGl5McvlCUSk
knfz7NpuX/A0m/EwFcjD6eYMJsVCQg9rdYli3RkkKPnRy8CvVOyRu9Ne1BCiH0Vd
yWTJUIPvO3glNlp7wdDuMbautf0UY9Zs7I4+A9yGRPhGu3iz9DpPvyXT/qVKNNuL
3nyDewyAwWXkmZYCgRUMsQEpIXpjyq9E0yGeH3pFueEY8Q+lymqLkRVuJlSYFm+4
zQinwJtsMo/xuvkRKUOxH47RDMhvdWmLodwo5FO/IEUgid9m2Dqcdf9Eiu578TFg
krU5VWxIDR3pgYWxtPc2
=FkT0
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
