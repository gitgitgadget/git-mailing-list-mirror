From: martin f krafft <madduck@madduck.net>
Subject: Re: metastore
Date: Tue, 2 Oct 2007 21:23:33 +0100
Message-ID: <20071002202333.GB16010@lapse.madduck.net>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net> <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net> <20071002195816.GA6759@hardeman.nu> <85lkalz3iv.fsf@lola.goethe.zz> <Pine.LNX.4.64.0710021314370.24697@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
To: david@lang.hm, David Kastrup <dak@gnu.org>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <J
X-From: git-owner@vger.kernel.org Tue Oct 02 22:25:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcoJ9-00078v-SF
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbXJBUZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 16:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbXJBUZW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:25:22 -0400
Received: from clegg.madduck.net ([82.197.162.59]:47925 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbXJBUZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 16:25:20 -0400
Received: from lapse.madduck.net (213-202-173-105.bas504.dsl.esat.net [213.202.173.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 92EBDBA383;
	Tue,  2 Oct 2007 22:24:50 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id A6CC13FDED; Tue,  2 Oct 2007 21:23:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710021314370.24697@asgard.lang.hm>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59727>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach david@lang.hm <david@lang.hm> [2007.10.02.2118 +0100]:
> the problem with this is dealing with the attributes outside of git=20
> (especially when the filesystem can't store the attributes nativly,=20
> specificly including things like owners when not running as root)

In which case you should not be able to manipulate them (as you
could not test the result) and any commits could not affect them,
meaning they'd just stay unchanged.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
the unix philosophy basically involves
giving you enough rope to hang yourself.
and then some more, just to be sure.
=20
spamtraps: madduck.bogus@madduck.net

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHAqjFIgvIgzMMSnURAtvAAKCxPIUVOaCmtF997TkoW/03zAtuFACfTlkr
l3DTqVsTDOaeo618A0SnAJ8=
=AqOt
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
