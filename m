From: martin f krafft <madduck@madduck.net>
Subject: Re: git-remote: Use of uninitialized value in string ne, line 248
Date: Wed, 24 Oct 2007 22:27:24 +0200
Message-ID: <20071024202724.GA2292@piper.oerlikon.madduck.net>
References: <20071024110807.GA12501@piper.oerlikon.madduck.net> <7vwstc68bk.fsf@gitster.siamese.dyndns.org> <20071024193954.GA5280@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
To: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 22:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkmpY-0003S8-EY
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 22:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbXJXU1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbXJXU1m
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 16:27:42 -0400
Received: from clegg.madduck.net ([82.197.162.59]:38228 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbXJXU1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 16:27:41 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 8D9B8A808F;
	Wed, 24 Oct 2007 22:28:20 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 3A57D9F13B;
	Wed, 24 Oct 2007 22:27:25 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 09AB14408; Wed, 24 Oct 2007 22:27:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071024193954.GA5280@steel.home>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4591/Wed Oct 24 21:47:49 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62234>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Alex Riesen <raa.lkml@gmail.com> [2007.10.24.2139 +0200]:
> just you never call yor branches "0".

Wow, Perl is weird. :)

perl -e 'print "The earth is a disk!\n" if ( "earth" =3D=3D "flat" );'

Is there a way to make it explicit that you're checking for a value
being defined, where a "false" value would count as true, just as
long as there is a value?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
micro$oft dns service terminates abnormally
when it receives a response
to a dns query that was never made.
fix information: run your dns service on a different platform.
                                                            -- bugtraq
=20
spamtraps: madduck.bogus@madduck.net

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHH6qsIgvIgzMMSnURAj2MAKDLmChZvk7tlBSPbp1SKf9Mb0J8MgCghpvv
2OvTprBCzOoil/YPztiMr5U=
=sEMF
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
