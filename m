From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Oct 2008, #04; Sat, 18)
Date: Sun, 19 Oct 2008 17:18:33 +0200
Message-ID: <200810191718.38614.trast@student.ethz.ch>
References: <7viqrpabep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart47108537.zHZU4ZNm5s";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 23:15:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kra4p-0007r3-Vd
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 17:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbYJSPSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbYJSPSg
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 11:18:36 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:37371 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbYJSPSg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 11:18:36 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Oct 2008 17:18:34 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Oct 2008 17:18:33 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7viqrpabep.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Oct 2008 15:18:33.0804 (UTC) FILETIME=[F378D8C0:01C931FD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98603>

--nextPart47108537.zHZU4ZNm5s
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> * tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
>  + Documentation: Refer to git-rebase(1) to warn against rewriting
>  + Documentation: new upstream rebase recovery section in git-rebase
>=20
> Expecting an update.

Note that the branch name is somewhat misleading; my fault for causing
confusion by grouping these two together with the gitworkflows.txt
RFCs.  The two topics are independent.

And needless to say, I also managed to confuse myself.  The above two
are already the final version.  As far as I can tell, you've also made
two small corrections of your own; much appreciated.

I'll send an updated version of the gitworkflows.txt draft shortly,
which is what I meant in my last mail.

=2D Thomas

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart47108537.zHZU4ZNm5s
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkj7T84ACgkQqUud07tmzP0f5wCgnRceb5T0X0RzIZGJCr6EsQ/T
vNsAnivg+9pn63bcU15JqcztKKcbfWgM
=UgRS
-----END PGP SIGNATURE-----

--nextPart47108537.zHZU4ZNm5s--
