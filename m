From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [Q] do we have your name correctly?
Date: Wed, 13 May 2015 22:53:37 +0000
Message-ID: <20150513225337.GD425227@vauxhall.crustytoothpaste.net>
References: <xmqqa8x89k0x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 00:53:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsfX9-00029Z-TD
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 00:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965520AbbEMWxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 18:53:43 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38331 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934657AbbEMWxm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2015 18:53:42 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:307e:6849:ffff:3e6f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AED972808F;
	Wed, 13 May 2015 22:53:40 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
Content-Disposition: inline
In-Reply-To: <xmqqa8x89k0x.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269014>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 03:42:38PM -0700, Junio C Hamano wrote:
> Before cdb6b5ac (.mailmap: Combine more (name, email) to individual
> persons, 2013-08-12), we used to have this entry in .mailmap:
>=20
>     Brian M. Carlson <sandals <at> crustytoothpaste.ath.cx>
>=20
> but then it was replaced with two entries with that commit to
>=20
>     brian m. carlson <sandals <at> crustytoothpaste.ath.cx> \
>     	Brian M. Carlson <sandals <at> crustytoothpaste.ath.cx>
>     brian m. carlson <sandals <at> crustytoothpaste.ath.cx> \
>         <sandals@crustytoothpaste.net>
>=20
> (they are two lines; backslashes are just for this e-mail).
>=20
> Because the RHS is searched in the committer and author fields and
> replaced to the LHS when .mailmap is used, this forces your name
> to lowercase, which is against the normal convention on this list.
>=20
> I *think* the motivation behind the original .mailmap entry before
> that commit was to upcase the name so it does not stand out oddly
> among other peoples' names, and I am suspecting that cdb6b5ac did
> it in an opposite way by mistake.

I write my name in lower case (and have for some years), and I strongly
prefer it that way.  I'm not completely clear on the format of .mailmap
files, but the way it should appear is "brian m. carlson
<sandals@crustytoothpaste.net>".  From what I can tell, it looks like
it's correct already.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVU9XwAAoJEL9TXYEfUvaLxvMP/2GA+aWaX6ULfvNrrVH+c2+4
DSCcvt+vxU3MM0fTXpB0i060Kwz27Bg1w2bWAdbb/m5LISYn9bKAer8++/mDkyrM
tPF0S+cU5haORl1TJYh35+2/GgX/c4moMlpTP2Pey3sBgGFf74iSFGRFKykwKI48
6BRBkzingtoJ9fHGxF6rB/fHKHl9jPWpwfOGUUpIDum0ZfJAo2xCNWyLb4duZ9qM
E5Aq9T1lB0Gz6KBi0xkFj9WvEv34OljV+JF3tago/o84wur8GkuuffsB66w6MGSl
btUWH54WP/UgnKuXHEp+ph6zCAaDcOjb/pWLFLO3Asg+OJbw/FVCJ2k7yoULRcuI
S0htunIRQs9JZEvcW4QOU7A3uAFu7oCdNoGc73rszbSiVIGEw176fIZ3x2ng9eQi
VeOwKayljDGFarR+xNDGg9TLP5LzJ3Ta8lwFMgDLLihvpgkEdfFUiwLupSLFrE4d
qO6fOUJKVo2aG858BfICgDstc7xLkYw4heFfX+nH1edBpWl7oOWGS/EWscgTzH5h
VkDNsCGYsp5/+YvbRNA6JRCTLb8q1pjaxcIWvQzwG5KE+1Z2CM2ONLd+25xVXJR+
PeTS2kkgVjHAtyeJ5D9hK5y6h5HMldtn4xnMd33EHS4RjsyVb3bxKrt/ERtzfMHJ
W83tPX/bHQzapWlzojKb
=8H33
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
