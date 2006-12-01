X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 13:12:34 +0100
Message-ID: <20061201121234.GQ18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9pS2hy4/DrI8BQlq"
NNTP-Posting-Date: Fri, 1 Dec 2006 12:12:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45701B8D.1030508@b-i-t.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32908>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7Fu-0002nr-Pb for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030898AbWLAMMg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030903AbWLAMMg
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:12:36 -0500
Received: from agent.admingilde.org ([213.95.21.5]:53738 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1030898AbWLAMMf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:12:35 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq7Fq-0005Lq-Q2; Fri, 01 Dec 2006 13:12:34 +0100
To: sf <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org


--9pS2hy4/DrI8BQlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 01:09:49PM +0100, sf wrote:
> Martin Waitz wrote:
> ...
> >So you not only store your submodule HEAD commit in the supermodule when=
=20
> >you
> >do commit to the supermodule, it also means that your submodule HEAD
> >will be updated when you update your supermodule.
>=20
> Why the magic? The typical workflow in git is
>=20
> 1. You work on a branch, i.e. edit and commit and so on.
> 2. At some point, you decide to share the work you did on that branch=20
> (e-mail a patch, merge into another branch, push upstream or let it by=20
> pulled by upstream)

3. Other people want to use your new work.

--=20
Martin Waitz

--9pS2hy4/DrI8BQlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcBwyj/Eaxd/oD7IRApRSAJ4vGIfv4BEeSHFdhwWNs/CLWYfjAACdFTkU
wRRcYBA5eKfyLEbuqBsl10I=
=vQW2
-----END PGP SIGNATURE-----

