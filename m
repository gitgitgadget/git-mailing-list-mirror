From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 11:01:30 +0100
Message-ID: <200902191101.35310.trast@student.ethz.ch>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3925172.pvFXW2iVGQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:03:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5kR-0006kB-By
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbZBSKBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbZBSKBr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:01:47 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:33423 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbZBSKBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:01:47 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 11:01:45 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 11:01:45 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
X-OriginalArrivalTime: 19 Feb 2009 10:01:45.0245 (UTC) FILETIME=[124C2CD0:01C99279]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110658>

--nextPart3925172.pvFXW2iVGQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

John Tapsell wrote:
>   I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
> doesn't matter if you go back 'too far' I just always use HEAD~10 even
> if it's just for the last or so commit.

It makes a *huge* difference if any of those last N commits is a merge.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3925172.pvFXW2iVGQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmdLf8ACgkQqUud07tmzP2m8QCggnNaRE1j/+eRPzjIYHZHaw8f
KAEAn0cFP0qwBoRLg3wV87j0EtpsFLE5
=vUzm
-----END PGP SIGNATURE-----

--nextPart3925172.pvFXW2iVGQ--
