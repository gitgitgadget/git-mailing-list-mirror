From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/11] Zsh prompt tests
Date: Wed, 11 Jun 2014 01:16:18 +0000
Message-ID: <20140611011617.GB368384@vauxhall.crustytoothpaste.net>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
 <53976563.5020905@web.de>
 <53976A7E.8010001@bbn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:16:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuX9S-0006Wg-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 03:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbaFKBQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 21:16:26 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48254 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751633AbaFKBQ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 21:16:26 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:2880:e878:bac4:85cf])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D3FB82808E;
	Wed, 11 Jun 2014 01:16:23 +0000 (UTC)
Mail-Followup-To: Richard Hansen <rhansen@bbn.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53976A7E.8010001@bbn.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251326>


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2014 at 04:28:46PM -0400, Richard Hansen wrote:
> On 2014-06-10 16:06, Torsten B=C3=B6gershausen wrote:
> > On 2014-06-04 23.01, Richard Hansen wrote:
> > []
> > I haven't digged too deep, but this is what I get on pu:
> >=20
> > ./t9904-zsh-prompt.sh=20
> > ./lib-zsh.sh:emulate:42: too many arguments
> > ./lib-zsh.sh:emulate:52: too many arguments
> > /lib-prompt-tests.sh:.:6: no such file or directory: /lib-prompt-tests.=
sh
> > ##
>=20
> Thank you for trying these patches and reporting your findings!
>=20
> >=20
> >  zsh --version
> > zsh 4.3.9 (i386-apple-darwin10.0)
>=20
> zsh 4.3.9 is over 5 years old (2008-11-03).  Is that young enough that
> we should still try to support it?

zsh 4.3.10 is the version in RHEL/CentOS 6, and people are still using
CentOS 5.  At $DAYJOB we build git on both, so it would be nice if at
least the tests didn't fail.  Skipping them on older versions (maybe
using is-at-least) would be fine by me.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTl63hAAoJEL9TXYEfUvaLYSUP/ild6IooYBkBfR+6nwt/H1CE
2VVJEwsl2sdX0V8a9E7kJofl5yAeJxL2QBc8b4QtDlOXmxODlCmEr9fDJvWuBMrC
w5i5ZvbdyfNUjG7gFx2cDtBOrofztb5Yk9NqyUTY2zG97r4Yt3HKTwzW1U6KQ8H8
uPcFoosAcsT44CLBjYtfAnUBb/jQ9zkAV+LV3djzSpn/6QJh00TZX9gSUn+/kuKY
abVcLjT8t2UXsps6Eh19OyUHDNi+iYUmOKH31m/JcAjY87KU1S/b4lxWG3lX6t6r
fpp55jlSEX6Pv1ZUTQQYtgGv1fXUe/K8STlcAuh869/cAUN+dsgsFNqls6OURu5i
z3jJRfCgHPTKFNIVMnC1EEu7+3Hf4ESJIUpZDvSLa6GuyLAIFzMEK8SjCxEEl7Ql
ZcA3NkrS/sRUvXgIddkJtWjTwI08S9AmrNlh2SFBadGM1su1+AmlWm2flcjuXi/Y
uLKrF9v2oSmC0zLbiMHC1SUCPq9vq8Qtonpv51YNmu5T+Bob/iujgdFT4jSboeVk
jA1Nr8RDnvtUoPkTN0/HnouLcau+/i+bih8QZschOYR+rHFEQ4nmZXCrLYHQkLu+
w7zztCUpocI3mdbFJpkWhtKqZLScRhIfXYZhQnc0RfVXl9rhe4A+179myvj+jzUc
qQIKSuSdbEuuKGjVPXXW
=N68+
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
