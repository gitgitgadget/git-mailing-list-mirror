X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sebastian Harl <sh@tokkee.org>
Subject: t9100-git-svn-basic.sh fails
Date: Wed, 13 Dec 2006 00:23:21 +0100
Message-ID: <20061212232321.GL2476@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kkRamCq5m5VQq0L6"
NNTP-Posting-Date: Tue, 12 Dec 2006 23:46:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 18:46:22 EST
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34169>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuHKM-0007Yx-Jb for gcvg-git@gmane.org; Wed, 13 Dec
 2006 00:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932515AbWLLXqX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 18:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWLLXqX
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 18:46:23 -0500
Received: from mail.tokkee.org ([212.114.247.92]:39626 "EHLO
 albany.tokkee.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S932515AbWLLXqX (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 18:46:23 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000) id 46003364001;
 Wed, 13 Dec 2006 00:23:21 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--kkRamCq5m5VQq0L6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When compiling git 1.4.4.2 on my Debian Sarge box t9100-git-svn-basic.sh fa=
ils
with the following output:

  * FAIL 6: detect node change from directory to file #1
         git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybra=
nch2

I'm using subversion 1.3.2.

Versions up to 1.4.3.2 built fine.

Any clues what this might be caused by?

Thanks in advance.

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl
GnuPG-ID: 0x8501C7FC
http://tokkee.org/


--kkRamCq5m5VQq0L6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFfznpEFEKc4UBx/wRApGoAKCPbqlVxmrYFH0d2oevJablJSEGbACfSC6Z
26Flfja+TuvdMm76hFKUjR0=
=EZj3
-----END PGP SIGNATURE-----

