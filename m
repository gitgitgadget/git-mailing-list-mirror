From: Martin Waitz <tali@admingilde.org>
Subject: Re: Errors cloning large repo
Date: Sat, 10 Mar 2007 23:32:51 +0100
Message-ID: <20070310223251.GA20726@admingilde.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <20070310030718.GA2927@spearce.org> <Pine.LNX.4.64.0703092145550.10832@woody.linux-foundation.org> <20070310060144.GA3223@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Anton Tropashko <atropashko@yahoo.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 23:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQA7a-0006mF-6F
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 23:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbXCJWcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 17:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbXCJWcy
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 17:32:54 -0500
Received: from mail.admingilde.org ([213.95.32.147]:57918 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbXCJWcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 17:32:53 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HQA7P-0000JK-76; Sat, 10 Mar 2007 23:32:51 +0100
Content-Disposition: inline
In-Reply-To: <20070310060144.GA3223@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41886>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Mar 10, 2007 at 01:01:44AM -0500, Shawn O. Pearce wrote:
> Its very likely this did fit in just under 4 GiB of packed data,
> but as you said, without O_LARGEFILE we can't work with it.

but newer git version can cope with it:

-r--r--r-- 1 martin martin 3847536413 18. Feb 10:36 pack-ffe867679d673ea5fb=
fa598b28aca1e58528b8cd.pack

--=20
Martin Waitz

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFF8zITj/Eaxd/oD7IRAv02AJoDppZwC9Amc27BSowU6eERDUMPGwCeJcp5
TvN8TiLTh3+SdF7iM10fWts=
=V4S1
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
