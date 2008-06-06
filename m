From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: Multiple user questions
Date: Fri, 6 Jun 2008 22:47:39 +0200
Message-ID: <200806062247.42074.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2165705.O9t0RMJpei";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4j4K-0006Z5-Un
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 23:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758426AbYFFVAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 17:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755537AbYFFVAr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 17:00:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:51601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756786AbYFFVAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 17:00:46 -0400
Received: (qmail invoked by alias); 06 Jun 2008 21:00:44 -0000
Received: from hnvr-4dbbcf4f.pool.einsundeins.de (EHLO ernie.local) [77.187.207.79]
  by mail.gmx.net (mp009) with SMTP; 06 Jun 2008 23:00:44 +0200
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX18pVvAaizgppuY1dfnFcIpM9QIbF254gLSxleXlO+
	SoUjrSe2p1piGm
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84115>

--nextPart2165705.O9t0RMJpei
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I just ran into a lost stash again and thus would like to get an answer to=
=20
this question, which was forgotten last time:
(lost-found is really growing in a pace it will take me very long to find m=
y=20
lost stash.)

5) fsck --full --lost-found shows me a lot of "dangling commit". I would li=
ke=20
to clean them up. prune did only remove "dangling tree" and blobs.
(Reason: Last time I droped a stash accidently, I was able to find it in th=
at=20
list. I will not be able to do this again if it continues to grow at that=20
rate.)
How can I do that?
=46urther fsck --full --unreachable also shows a lot of unreachable things=
=20
(commits, trees, blobs). Can that be cleaned up as well?

Greetings,
Dennis

Again: Please CC me, as I am not subscribed.

--nextPart2165705.O9t0RMJpei
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhJom4ACgkQjqfyF1DtJW4ldwCglU10aIe3hSNmcw8VYONq5qyN
8m8AoL3/ovHyawwgX/5s5pYfTVyQUvqS
=8wZ2
-----END PGP SIGNATURE-----

--nextPart2165705.O9t0RMJpei--
