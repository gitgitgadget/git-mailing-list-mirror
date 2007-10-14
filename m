From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 18:50:36 +0200
Message-ID: <20071014165036.GJ1198@artemis.corp>
References: <20071014143628.GA22568@atjola.homenet> <47122D02.9060204@op5.se> <85hcktn3s0.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="cN519qCC4CN1mUcX";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Andreas Ericsson <ae@op5.se>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:51:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6fy-000557-OV
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508AbXJNQui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 12:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756340AbXJNQui
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:50:38 -0400
Received: from pan.madism.org ([88.191.52.104]:48465 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756046AbXJNQui (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 12:50:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E09D824EDF;
	Sun, 14 Oct 2007 18:50:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7F95B3A2393; Sun, 14 Oct 2007 18:50:36 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>, Andreas Ericsson <ae@op5.se>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <85hcktn3s0.fsf@lola.goethe.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60868>


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2007 at 02:56:31PM +0000, David Kastrup wrote:
> Andreas Ericsson <ae@op5.se> writes:
>=20
> > Bj=C3=B6rn Steinbrink wrote:
> >>
> >> I tried all git releases from 1.5.3 to 1.5.3.4 as well as the current
> >> master and all of them crashed. A small shell script to reproduce the
> >> problem is attached.
> >>
> >
> > Manual bisect? Ugh. This *is* the century of the competent developer
> > tools, you know... ;-)
>=20
> It's not a "bisect" when it crashes in all versions.

  What What, git cannot bisect future versions ??? *g* what a
disappointment.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEkjcvGr7W6HudhwRAlvUAJ0a1f4aOq2X+WVCWpQ/8/nse+qXZQCffyaT
meBCBX3ZxaqIJe1iphFA9Mk=
=wrer
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--
