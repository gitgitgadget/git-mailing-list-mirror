From: martin f krafft <madduck@madduck.net>
Subject: Re: unmerging feature branches
Date: Wed, 31 Oct 2007 22:27:30 +0100
Message-ID: <20071031212730.GA32170@piper.oerlikon.madduck.net>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org> <20071023171611.GA18783@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org> <20071031211658.GA5430@inspiron>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InL6N-0005i5-P3
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbXJaV1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbXJaV1i
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:27:38 -0400
Received: from clegg.madduck.net ([82.197.162.59]:43065 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbXJaV1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:27:37 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 1E8A6A8449
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 22:32:46 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 4F6259F13B
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 22:27:31 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 18E084407; Wed, 31 Oct 2007 22:27:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071031211658.GA5430@inspiron>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4652/Wed Oct 31 19:27:18 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62877>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Alejandro Martinez Ruiz <alex@flawedcode.org> [2007.10.31.2216 =
+0100]:
> So how about an "undo" command or a switch for revert with a special
> meaning like "hey, this one is a nice commit, but it ain't ready yet,
> I'd like you to ignore I ever committed the thing when merging or
> rebasing again, thanks"?

Revert does exactly that, by reverting the content. That's all Git
cares about. Does

  http://lists-archives.org/git/634475-unmerging-feature-branches.html

make it clear?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"getting a scsi chain working is perfectly simple if you remember that
 there must be exactly three terminations: one on one end of the
 cable, one on the far end, and the goat, terminated over the scsi
 chain with a silver-handled knife whilst burning *black* candles."
                                                     -- anthony deboer
=20
spamtraps: madduck.bogus@madduck.net

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHKPNCIgvIgzMMSnURAna6AKDqd7sgvcxpJh5mEANLGKlHu4BpkQCbBo1f
1+z/sRQnIo2kDWIYtFYalUU=
=7DKl
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
