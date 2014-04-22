From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 22:25:19 +0000
Message-ID: <20140422222519.GC144079@vauxhall.crustytoothpaste.net>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
 <475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
 <20140422185829.GB15516@google.com>
 <xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
 <20140422210002.GC15516@google.com>
 <xmqqy4yx2gz9.fsf@gitster.dls.corp.google.com>
 <20140422221148.GD15516@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:25:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcj87-0002HE-Pm
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbaDVWZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:25:26 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47254 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752435AbaDVWZY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 18:25:24 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:39ef:2a55:6e19:355e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DBDD428087;
	Tue, 22 Apr 2014 22:25:23 +0000 (UTC)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140422221148.GD15516@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-rc7-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246797>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2014 at 03:11:48PM -0700, Jonathan Nieder wrote:
> Another possibility would be to require Perl 5.8.9 or newer.  It was
> released in 2008.

RHEL 5 and CentOS 5 are still shipping with 5.8.8.  They are still
security-supported until 2017, and believe it or not people still
develop on them.  I am personally fine with this change, though.

What we could do instead is simply require a newer version of
Getopt::Long, which would let people continue using their ancient OSes
and install a newer version from CPAN if necessary.  It's also the
proper way to specify the dependency.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTVuxPAAoJEL9TXYEfUvaL6AwP/3dw4CoqEUPvNRyBXseykTsG
Bo1NWxDan/DAUl4yMXD1Sr5V7Kylgt6yMXIFuOhTZY8vhLYMwkqegDgdjwY9QFAH
r9TYRZBygkJqVd/ff/lL3OqmmJwpEXYZUhcEAymGpUt2Yr2rbBQK0d32Q1IHOfxS
734qKZxEMyEn5uUSxdA6ZHzfWKmU8+GlaX+S8hEZDoDjPRsf8TQU4ncwT+VS4qKf
bP0/alRjlwFT2vAVL0IMUhJqvrbu9l4/xaOH/mcYjJqozbEAW8k3GGUSY0GoRv3d
H+koHkqKxvIjfasDUMj/2D5Ji/K3JdpaQeuTebGj2bKmF4zaRI2HYKB1R6bcARhh
/sVcPr/HjCVq/dakVj72dMogDklG1S9lsf9UBztiPWi2E1vfWa2XSlRknrppxVmq
sDwMNJZzzTf8ERKds7mCPMvHvNx9uEOVZb2LYoj/E4VAF2BGQBFd4NFeeE3ZNLya
n7nHzQ4u840IPYS0hna78O75sgTIYXPU+RziqPHNWJeVKg5eL1hMUnCMnDoaeGhL
EuxxM84Yt7UoOFuTSZjrYfEjoJogOtXYZzAiTLu0WQtu9z2tUYa/9yrR6Lbxn2JD
JOVY5MmnnLvFsUPfOpEHfz5id3IG9fp96LpboqTqYjZKfzkelXIMBg+Q1206CW82
hSGoM8WWy6mUXxpO6nYn
=0tNB
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
