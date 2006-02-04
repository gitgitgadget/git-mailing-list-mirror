From: Keith Packard <keithp@keithp.com>
Subject: Re: 2 questions/nits about commit and config
Date: Sat, 04 Feb 2006 15:00:54 -0800
Message-ID: <1139094055.4200.6.camel@evo.keithp.com>
References: <20060204212337.GA8612@blinkenlights.visv.net>
	 <7voe1mvkls.fsf@assigned-by-dhcp.cox.net>
	 <7vhd7evk38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pFPaoBMdRcPkEHPW6Ly6"
Cc: keithp@keithp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 00:01:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5WP0-00041p-2a
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 00:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWBDXBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 18:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWBDXBG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 18:01:06 -0500
Received: from home.keithp.com ([63.227.221.253]:42506 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S964849AbWBDXBF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 18:01:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 4769413001F;
	Sat,  4 Feb 2006 15:01:03 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 03739-05; Sat, 4 Feb 2006 15:01:03 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id E78E813001E; Sat,  4 Feb 2006 15:01:02 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id DBC3314001;
	Sat,  4 Feb 2006 15:01:02 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F5WOq-0001HQ-GN; Sat, 04 Feb 2006 15:01:00 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd7evk38.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15608>


--=-pFPaoBMdRcPkEHPW6Ly6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-02-04 at 14:24 -0800, Junio C Hamano wrote:

> Before people start complaining about it, I take this part
> back.  "git commit -a" inside a subdirectory "foo" is not much
> different from "git commit foo/a foo/b foo/c" from the toplevel
> directory=20

making '-a' equivalent to '.' then? Seems like '.' is a whole lot more
understandable than '-a', but maybe that's just my na=C3=AFvit=C3=A9 showin=
g
again. I expected the '-a' flag to commit the whole tree from wherever
you were inside it...
 =20
--=20
keith.packard@intel.com

--=-pFPaoBMdRcPkEHPW6Ly6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD5TImQp8BWwlsTdMRAhCQAKCitmEvfc4vSu/IuPmrVRkrgTsThQCgnqvL
jUfcYsk9mgwms/vnCa94YBw=
=u+2t
-----END PGP SIGNATURE-----

--=-pFPaoBMdRcPkEHPW6Ly6--
