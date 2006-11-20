X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 00:33:34 +0100
Message-ID: <20061120233333.GD20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061120232507.GH12285@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
NNTP-Posting-Date: Mon, 20 Nov 2006 23:33:57 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061120232507.GH12285@fieldses.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31958>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmIdy-0003HF-C5 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030510AbWKTXdk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWKTXdk
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:33:40 -0500
Received: from agent.admingilde.org ([213.95.21.5]:20184 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1030510AbWKTXdi
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:33:38 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmIds-0004Bb-6D; Tue, 21 Nov 2006 00:33:36 +0100
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Nov 20, 2006 at 06:25:07PM -0500, J. Bruce Fields wrote:
> On Mon, Nov 20, 2006 at 03:05:47PM -0800, Linus Torvalds wrote:
> > Yes. I think it would be a _fine_ idea to have a new tree-entry type th=
at=20
> > points to a sub-commit, but it really does need to be on a "tree level"=
,=20
> > not a commit level.
>=20
> Would it also be possible to allow the "Tree:" line in the commit object
> to refer to a commit, or does the root of the project need to be a
> special case?

this would then be something like the branch-archival proposal.
The user interface for such a beast would be difficult, as you have
to somehow specify if you mean the inner or outer repository.

--=20
Martin Waitz

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYjtMj/Eaxd/oD7IRAjVPAJ94WajAHsYuDhvTfR0bG9QGYG5t3ACffBQO
AhAT9yZX7blEDviOemnxK7w=
=wjIs
-----END PGP SIGNATURE-----

