From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the security-testing tree with the
 tree
Date: Thu, 30 Jun 2011 15:53:54 +1000
Message-ID: <20110630155354.bdd620b5.sfr@canb.auug.org.au>
References: <20110630142910.2fea4257.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.1106301518430.13767@tundra.namei.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__30_Jun_2011_15_53_54_+1000_.BesutqQ6X+nDHuk"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@vger.kernel.org, Linus <torvalds@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>
To: James Morris <jmorris@namei.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 07:54:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcACZ-0007lo-IO
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 07:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab1F3FyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 01:54:06 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:36622 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab1F3FyE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 01:54:04 -0400
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id E7E98144B83;
	Thu, 30 Jun 2011 15:53:59 +1000 (EST)
In-Reply-To: <alpine.LRH.2.00.1106301518430.13767@tundra.namei.org>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.24.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176476>

--Signature=_Thu__30_Jun_2011_15_53_54_+1000_.BesutqQ6X+nDHuk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, 30 Jun 2011 15:22:33 +1000 (EST) James Morris <jmorris@namei.org> w=
rote:
>
> On Thu, 30 Jun 2011, Stephen Rothwell wrote:
>=20
> > I cannot merge commit bcd05ca10420 ("Merge branch 'for-security' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jj/apparmor-dev into next=
")
> > which is the child of the above two commits.
>=20
> Actually, I may have accidentally pulled upstream commits in via the=20
> above.  I'll rebase my tree to the TOMOYO merge.

It does pull in v3.0-rc5, but that is already in my tree today, so I
still don't understand why the merge I did gets so messaed up.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__30_Jun_2011_15_53_54_+1000_.BesutqQ6X+nDHuk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJODA9yAAoJEDMEi1NhKgbsdp8IAIFdTkAXEHjo9c3i3IliO2YW
/gxOik1oUqgIV0osNeMLz9Sx5bDQyoxjiKwHMpZL2kStlcbaW/vwLVQwwNadel1f
IwQM4KdZ+qm2aKQNgTA0txsLzh9AUwyIRUadhT1vXlQ5PvfsC8FEffEssbfjPYwT
IuNKwHspVf9bWsvnJiDRxMBGOuO326dkQA20MPyVi3Cnxcep2S5eyI9wVGoGjg35
qs+oP6VJNGCwxQhJJSyucMOGN71R/nOVbTVvHBG+0PdUXU4phjoo0V7wDXWeZgya
s2fRfL9sQwVPo4AThw4Aje4aw7F5sCeyAsqr96ab+joh/zTQoIdvsvHccENf1fk=
=APNQ
-----END PGP SIGNATURE-----

--Signature=_Thu__30_Jun_2011_15_53_54_+1000_.BesutqQ6X+nDHuk--
