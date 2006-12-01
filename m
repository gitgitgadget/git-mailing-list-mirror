X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 14:43:11 +0100
Message-ID: <20061201134311.GV18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <45701A24.5060500@b-i-t.de> <20061201121110.GP18810@admingilde.org> <45702C50.9050307@b-i-t.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="niUlcCfh/sMBwTxc"
NNTP-Posting-Date: Fri, 1 Dec 2006 13:43:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45702C50.9050307@b-i-t.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32921>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq8fb-000091-C8 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 14:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031489AbWLANnM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 08:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031498AbWLANnM
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 08:43:12 -0500
Received: from agent.admingilde.org ([213.95.21.5]:51623 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031489AbWLANnM
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 08:43:12 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq8fX-0006BH-78; Fri, 01 Dec 2006 14:43:11 +0100
To: sf <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org


--niUlcCfh/sMBwTxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 02:21:20PM +0100, sf wrote:
> I just had a short (really short) look at your work. My impression is=20
> that your repository setup is much too complicated.

Well, I'm not really satisfied with the UI part.
What exactly do you find complicated?

> As I proposed elsewhere: For submodules to work you only need to allow=20
> commits in tree objects (that is what your implementation requires as=20
> well). Everything else is in the tools. Much simpler.

I do not quite get your point.
The core of my work allows to put commits into tree objects.
Then there is some more (but not quite finished) work to make the tools
work together with submodules.  So no, not everything is there yet.

--=20
Martin Waitz

--niUlcCfh/sMBwTxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcDFvj/Eaxd/oD7IRAkAsAJ0UJe2dBsptMkSE/G7gbDf8nWe03gCeKDPI
V2QXHZmKFCHmjPNXbzx1B00=
=so2r
-----END PGP SIGNATURE-----

