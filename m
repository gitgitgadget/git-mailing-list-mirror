From: martin f krafft <madduck@madduck.net>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Tue, 2 Oct 2007 20:53:01 +0100
Message-ID: <20071002195301.GB14171@lapse.madduck.net>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net> <20070919191607.GE13683@hardeman.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Cc: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 21:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcnpS-0003Bj-TJ
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbXJBTyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbXJBTyn
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:54:43 -0400
Received: from clegg.madduck.net ([82.197.162.59]:51866 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbXJBTym (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:54:42 -0400
Received: from lapse.madduck.net (213-202-173-105.bas504.dsl.esat.net [213.202.173.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id C5325BA383;
	Tue,  2 Oct 2007 21:54:19 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 324383FDED; Tue,  2 Oct 2007 20:53:00 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20070919191607.GE13683@hardeman.nu>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4456/Tue Oct  2 17:11:59 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59718>


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach David H=E4rdeman <david@hardeman.nu> [2007.09.19.2016 +0100]:
> But I agree, if any changes were made to git, I'd advocate adding
> arbitrary attributes to files (much like xattrs) in name=3Dvalue
> pairs, then any extended metadata could be stored in those
> attributes and external scripts/tools could use them in some way
> that makes sense...and also make sure to only update them when it
> makes sense.

So where would those metdata be stored in your opinion?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
seen on an advertising for an elaborate swiss men's watch:
  "almost as complicated as a woman. except it's on time"
=20
spamtraps: madduck.bogus@madduck.net

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHAqGdIgvIgzMMSnURAnJ5AKC+r4VTfiuWrnGdfpP68JJehmyArwCbBGRt
xlkFmzWmdXNM4ncT7gZT71s=
=XLLm
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
