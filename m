X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Merging five months of Linux kernel history
Date: Sun, 29 Oct 2006 20:32:28 +0100
Message-ID: <20061029193228.GR26271@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nc/lueCMLdgjBWoP"
NNTP-Posting-Date: Sun, 29 Oct 2006 19:32:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30444>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGOX-0000H6-Gp for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965352AbWJ2Tcb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965355AbWJ2Tca
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:32:30 -0500
Received: from lug-owl.de ([195.71.106.12]:16029 "EHLO lug-owl.de") by
 vger.kernel.org with ESMTP id S965352AbWJ2Tca (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:32:30 -0500
Received: by lug-owl.de (Postfix, from userid 1001) id EB6D7F0885; Sun, 29
 Oct 2006 20:32:28 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--nc/lueCMLdgjBWoP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Due to a move to a new flat and other reasons, I wasn't able to
do daily merges from Linus's tree into our vax-linux tree.
My time situation has improved and I want to merge all the new
and shiny stuff, but it seems a straight "git pull" isn't the
best way to do that.

What I'd actually love to do is to go through all commits since the
last merge and pull/accept/cherry-pick then one by one.  That way I'll
learn about new stuff. I'll specifically see generic changes that
imply arch-specific stuff, things I'll need to implement later on.

Is there any sane way to cluse such a large gap?  I don't mind looking
through tenthousands of commits, as long as I get a chance to spot
"important" ones.

Thanks, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:            http://www.chiark.greenend.org.uk/~sgtatham/bugs.h=
tml
the second  :

--nc/lueCMLdgjBWoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFRQHMHb1edYOZ4bsRAuluAJwPwtgcH020xjgTMmi6eLsCmxJIgwCfaTZT
O9zbczty9jq4K+JPptTdjAs=
=sf3B
-----END PGP SIGNATURE-----

