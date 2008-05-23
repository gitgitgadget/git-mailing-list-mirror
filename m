From: Dennis Schridde <devurandom@gmx.net>
Subject: Multiple user questions
Date: Fri, 23 May 2008 13:27:37 +0200
Message-ID: <200805231327.41216.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12119147.FcjzyET54P";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 13:28:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzVRs-00034F-He
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 13:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbYEWL1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 07:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbYEWL1p
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 07:27:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:35429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753752AbYEWL1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 07:27:44 -0400
Received: (qmail invoked by alias); 23 May 2008 11:27:43 -0000
Received: from hnvr-4dbb8534.pool.einsundeins.de (EHLO ernie.local) [77.187.133.52]
  by mail.gmx.net (mp050) with SMTP; 23 May 2008 13:27:43 +0200
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX1+Xm6FnGv+XczyQhIYoXnvLdt7q0A68qg77IkPAcT
	/zmNXYUMnx7pxH
User-Agent: KMail/1.9.9
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82695>

--nextPart12119147.FcjzyET54P
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello!

I have some questions regarding the usage of Git, I did not find answered i=
n=20
manpages or on IRC:

1) Can I somehow make send-email just send one email with multiple patches=
=20
attached?
2) Can I make format-patch include the full commit message, date, author,=20
stats in the patches? (To mimic what git-show would show me.)
Will this be sent via send-email, too?
3) Can I make format-patch --attach / --inline additionaly include this in =
the=20
attachements as well?
4) Can I make format-patch output one deletion and one insertion for a=20
complete rewrite of a function, instead of multiple deletes/inserts?
5) If rebase -i does not keep at least one valid line, it will "do nothing"=
=20
(instead of deleting all revisions). Is that intended? Why?

Thanks for your answers,
Dennis

--nextPart12119147.FcjzyET54P
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkg2qi0ACgkQjqfyF1DtJW6FsACcDlG1CVl19mDQNZpKKc0yt3sD
MF0AoJi7B+O54SZFdvzwXB2FYP/Rj0aj
=AnHK
-----END PGP SIGNATURE-----

--nextPart12119147.FcjzyET54P--
