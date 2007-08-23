From: martin f krafft <madduck@madduck.net>
Subject: Re: confused about preserved permissions
Date: Thu, 23 Aug 2007 08:00:52 +0200
Message-ID: <20070823060052.GA25153@piper.oerlikon.madduck.net>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr> <7v8x83i5ma.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Cc: Junio C Hamano <gitster@pobox.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 08:01:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO5kk-00083O-QY
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 08:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbXHWGBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 02:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbXHWGBG
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 02:01:06 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:54995 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbXHWGBE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 02:01:04 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id DB036895F6E;
	Thu, 23 Aug 2007 08:01:02 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26310-10; Thu, 23 Aug 2007 08:01:02 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 459BC895F61;
	Thu, 23 Aug 2007 08:00:54 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 8C0D09F16A;
	Thu, 23 Aug 2007 08:00:53 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 0AFF543F4; Thu, 23 Aug 2007 08:00:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8x83i5ma.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56457>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2007.08.23.0009 +0200]:
> We deliberately chose not to use that space, and this default is
> very unlikely to change.

The downsides included change in SHA hash on mode change, as far as
I can remember. Anything else?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"wickedness is a myth
 invented by good people
 to account for the curious attraction of others."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzSKUIgvIgzMMSnURAgnSAKChqFVKVKNx++Q3SfLsyaRYNyZgSgCbBT/J
no+erDRU7r5KKxBWXnYr834=
=UHZA
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
