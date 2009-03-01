From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2 RFC] fetch-pack: log(n)-transmission find_common()
Date: Sun, 1 Mar 2009 22:37:38 +0100
Message-ID: <200903012237.40891.trast@student.ethz.ch>
References: <1235942640-2370-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7928266.7lp0qcMcPj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:48:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtVz-0002bw-3s
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbZCAViG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 16:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754993AbZCAViE
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:38:04 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:10796 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777AbZCAViD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:38:03 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 22:38:00 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 22:38:00 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-3.2-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <1235942640-2370-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 01 Mar 2009 21:38:00.0316 (UTC) FILETIME=[FE4FA3C0:01C99AB5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111879>

--nextPart7928266.7lp0qcMcPj
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I wrote:
> Subject: [PATCH 2/2 RFC] fetch-pack: log(n)-transmission find_common()

Sorry for the out-of-thread reply.  This is almost exactly the same
patch as

  http://article.gmane.org/gmane.comp.version-control.git/102485

I forget to send along 1/2.  I'll tack it on 2/2 shortly, but that one
really is unchanged from the above thread IIRC.

But it also turns out, as you can see, that git-send-email happily
ignores --in-reply-to if threading is disabled. :-(

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart7928266.7lp0qcMcPj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmrACQACgkQqUud07tmzP2sFACeMtiFT1iOjDob4wIDxlPs6PZi
tUQAnjX8E5hBfHwhhSSOwQX+fR6hRwJG
=x5VR
-----END PGP SIGNATURE-----

--nextPart7928266.7lp0qcMcPj--
