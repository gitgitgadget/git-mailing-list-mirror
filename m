From: martin f krafft <madduck@madduck.net>
Subject: Re: (topgit question) deleting a dependency
Date: Tue, 28 Apr 2009 17:07:53 +0200
Message-ID: <20090428150753.GB30582@piper.oerlikon.madduck.net>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net> <20090428094138.GB9415@piper.oerlikon.madduck.net> <slrngve3mf.f45.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
To: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:09:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyovX-0000Um-Ih
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761897AbZD1PII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761854AbZD1PIG
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:08:06 -0400
Received: from clegg.madduck.net ([193.242.105.96]:58522 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760971AbZD1PIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 11:08:05 -0400
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "piper.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id BF5F11D409B;
	Tue, 28 Apr 2009 17:07:53 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 408B5C154B; Tue, 28 Apr 2009 17:07:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <slrngve3mf.f45.sitaramc@sitaramc.homelinux.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.29-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9298/Tue Apr 28 13:47:45 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117779>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sitaram Chamarty <sitaramc@gmail.com> [2009.04.28.1612 +0200]:
> When one branch is deemed to be cooked, a "tg export" takes
> that code to master, and I intend to delete t/all and create
> it afresh with the rest of the dependencies (the old set
> minus the one that finished cooking).

Are any of the t/* branches ever used by anyone else but you? Are
they published?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"the search for the perfect martini is a fraud. the perfect martini
 is a belt of gin from the bottle; anything else is the decadent
 trappings of civilization."
                                                            -- t. k.
=20
spamtraps: madduck.bogus@madduck.net

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn3G8gACgkQIgvIgzMMSnXWxQCgwV75KOMgR7qY1elStZjgI/u4
KXAAoNwZQDd9qj8SuuwpFs52zmKN4P1D
=QWTm
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
