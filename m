X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 14:46:11 +0100
Message-ID: <20061201134610.GW18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TG7lY2/6mW/akb80"
NNTP-Posting-Date: Fri, 1 Dec 2006 13:46:44 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45703174.8000609@op5.se>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32923>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq8iV-0000nk-Aq for gcvg-git@gmane.org; Fri, 01 Dec
 2006 14:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031407AbWLANqM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 08:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031510AbWLANqM
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 08:46:12 -0500
Received: from agent.admingilde.org ([213.95.21.5]:34537 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031407AbWLANqM
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 08:46:12 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq8iR-0006D3-2c; Fri, 01 Dec 2006 14:46:11 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org


--TG7lY2/6mW/akb80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 02:43:16PM +0100, Andreas Ericsson wrote:
> So a commit in the supermodule turns into a commit in the submodule?=20

no.

> If it doesn't, why would the submodule HEAD have to change?

So how do you update your submodule?

Remember: if you git-pull in the supermodule, you want to update the
whole thing, including all submodules.

--=20
Martin Waitz

--TG7lY2/6mW/akb80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcDIij/Eaxd/oD7IRAjH3AJ479XktDFfKJM6wOcD3m4iixHaFewCfSXwM
wcfOM1qrOGW4+LasVF4/k2A=
=h6/P
-----END PGP SIGNATURE-----

