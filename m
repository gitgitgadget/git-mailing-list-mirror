From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 07:03:20 -0700
Message-ID: <20090406T140124Z@curie.orbis-terrarum.net>
References: <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm> <20090405225954.GA18730@vidovic> <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm> <alpine.LFD.2.00.0904052326090.6741@xanadu.home> <vpq3acm6n7p.fsf@bauges.imag.fr> <alpine.LFD.2.00.0904060912530.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SgT04PEqo/+yUDw3"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:08:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqpRa-0002XD-O8
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbZDFOD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbZDFOD2
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:03:28 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:59340 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755059AbZDFOD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 10:03:27 -0400
Received: (qmail 11364 invoked from network); 6 Apr 2009 14:03:24 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Mon, 06 Apr 2009 14:03:24 +0000
Received: (qmail 6257 invoked by uid 10000); 6 Apr 2009 07:03:20 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904060912530.6741@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115833>


--SgT04PEqo/+yUDw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I haven't read all this morning submissions to the thread yet, but I
wanted to make two posts before I leave on a trip (in ~20 minutes), and
I'll be back late on Thursday.

On Mon, Apr 06, 2009 at 09:29:04AM -0400, Nicolas Pitre wrote:
> > To me, this is a non-issue (if the content of these objects are
> > secret, then why are they here at all on a public server?), but I
> > think there were discussions here about it (can't find the right
> > keywords to dig the archives though), and other people may think
> > differently.
> Guess who was involved in that discussion...
> I may allow you to pull certain branches directly from my own PC through=
=20
> the git native protocol.  That doesn't mean you have direct access to=20
> the whole of any of the packs I have on my disk.
If the native rsync protocol is allowed to the repo, then that argument
is moot.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--SgT04PEqo/+yUDw3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknaC6gACgkQPpIsIjIzwixcCwCg8+EYv3iqXrulL8tgWtixaRS0
0hUAnRvqjo8/7vaJ2hn7MCGcpRgoA1AQ
=sVGX
-----END PGP SIGNATURE-----

--SgT04PEqo/+yUDw3--
