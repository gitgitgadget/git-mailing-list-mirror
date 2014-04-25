From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Apr 2014, #07; Tue, 22)
Date: Fri, 25 Apr 2014 15:07:27 +0000
Message-ID: <20140425150726.GA234593@vauxhall.crustytoothpaste.net>
References: <xmqq38h52c2d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 17:08:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdhjZ-0006vF-S8
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 17:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaDYPIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 11:08:05 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47319 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752081AbaDYPH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 11:07:59 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [198.22.24.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2E37828087;
	Fri, 25 Apr 2014 15:07:58 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq38h52c2d.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-rc7-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247043>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2014 at 04:12:42PM -0700, Junio C Hamano wrote:
> * bc/blame-crlf-test (2014-02-18) 1 commit
>  - blame: add a failing test for a CRLF issue.
>=20
>  I have a feeling that a fix for this should be fairly isolated and
>  trivial (it should be just the matter of paying attention to the
>  crlf settings when synthesizing the fake commit)---perhaps somebody
>  can squash in a fix to this?

Last time I looked at this, I couldn't come up with an obvious fix for
the problem, or I would have included one.  I'll try to have another go
at it this weekend.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTWnouAAoJEL9TXYEfUvaLCe0QAMi97Zkbj7QfTPLHaFy3gG2m
I4JXLB3NzyFB5a+0ZyYRr0WTfcEk2ifobjQLAyBtZcRdkvd00qtYSalqSw6iFrjw
ctPGj+W2FOGCs/qGEnHyDCFPBBGSr8mDfcGwhGhi/8TzKpstjNcvdBRsjBVyKLI2
df9Rq3W0HAOI9Kiwrj++xKnEvB0j9PMrxBejF5EEcAEEINVY5xUinlJFWRfUA2Sb
bLGEhGPV3N1StvvBOvKUDAWF7T0hGn/XJcBn0jaFwIcWBoxiWsGfU8ueIHPN06AG
gSsFPCcFsDaaIUESjpDQRT5CWeyFMNCDPLut7KxOp0MI0wBe5UbDK4IEWStVp0yx
3IcsH3NMwVvZv962UvraxmlWg0NwMbYQr5Y0+E/I1kbz4hDYVmU/JYQnnhDgwPpn
zfQl0Yjb2T0SSW2Ouo1/PTBeWIDGFFihAFeB1potPK8BkT1LrnvcbvpbCrWeuUeg
yhWZI5SBez2XCs8RHjMI87d4wjuf6I6ILo9fugiYPqa4lrFoRsA26JO6tnDj25ew
UTJUn5t0oRwHCYWF0RoKphOaf2ykSPgBw5FtzgT7fxqDmfkv7NGhxSRFuBZrFYSd
ksBjTTf7r2COGejAYa7tvPVx9bm4ASosT5SI8yL/GHzzc0XxMd+Fs7l7baE5JGX7
fJFQ0LHtsC25akpOSvji
=JnzM
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
