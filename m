From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Tool/Scripts - For maintaining different branches on a repo
Date: Fri, 20 Jun 2014 22:30:47 +0000
Message-ID: <20140620223047.GB856079@vauxhall.crustytoothpaste.net>
References: <CAD6G_RRxj_tHhiGxP+ehNMBewqveUbbGuLLxgnHjUt96WkC_xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Cc: Git List <git@vger.kernel.org>
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 00:30:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy7Kk-0001qg-JE
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jun 2014 00:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966868AbaFTWaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 18:30:55 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48468 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965046AbaFTWay (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jun 2014 18:30:54 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:484c:d808:778d:663a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5A18A2808E;
	Fri, 20 Jun 2014 22:30:53 +0000 (UTC)
Mail-Followup-To: Jagan Teki <jagannadh.teki@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD6G_RRxj_tHhiGxP+ehNMBewqveUbbGuLLxgnHjUt96WkC_xg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252293>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2014 at 04:18:22PM +0530, Jagan Teki wrote:
> Hi,
>=20
> I have a single repo with different kinds of branches say 4 branches.
> Developers will send a patches wrt to specific branch.

I presume here that you're referring to emailed patches, or patches in
independent files, as opposed to just having branches with commits.

> Is there any opensource tool/script that does applying patches/maintaining
> the branches in repo w/o manual intervention?

If you want something that works with patches specifically, TopGit might
do what you want.  If what you're looking for is a tool that accepts
patches and automatically applies them, I'm not aware of one.  It
shouldn't be terribly difficult to script, though.

If you don't need to deal with patches and can instead deal with git
repositories, GitLab and Gitorious offer merge requests, which might
make life easier.  I have heard that GitLab is less painful to set up.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTpLYXAAoJEL9TXYEfUvaLDgoP/0YJdpxs7HRaWeUDOX4qbest
lxZ9XH81Pzg/eLB3p21ASpo8AutJyeDKiKnhnov+h5cETY+StzJkAiVDaWUJc1bE
XHBf3/3/jXLsj9FmI50a1t4SyQGBH3dzeXE+KcLT+vi/Rvkh1fXNiMgdAw0HaK3I
6O4kfZ0Kba1li8WyoPH5OIuv+t29iPWgAy4hp08ZRNyyv7JrIzdIn/9O7jlG+7WW
6pK/u2U9JnoeZQ85qEGNstw5TFRIo4A1kZb2G9Vb5tpKTOSRYCzJbbY3DDxB7Fq/
3s53eq7aVV1S8ezUj45+wkKzqhhYZHtt/0T6PctNkAXh1KC1i3FeOjBIlyDKL4xi
Okvl//UFeb5QPyr3jgHwDzU7TsYvJFV0vpo+ZegJQ64rCwMoHNGEPEONkidHtevi
te+9w9wf7zQc59fVyrC/EcuXH9kdzHBl7Y8BnKa2OvFQELdEb70QNGKp4dbFhbBV
68KQ1ycZ1Hg0heUykxsQ79qUaj/lTjcqKLGkMZSj4PMtxj/oIABux5+sBDY6Tws0
5LQatqR7IROs5Ne7PB30ClBXlcynitEZPCCRk+KZoUK5fYrhRNZ+h6de8fiIPzkX
bvp6nX6uZXivlE8CrBwCnm+w2+uts4CzLj+hd2w159kgzljxzHHWXQsVhR8PBvXY
KXrbqkBnx4AjjGdZkPnK
=8kQ0
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
