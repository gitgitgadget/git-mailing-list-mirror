From: Ryan Anderson <ryan@michonline.com>
Subject: Re: GIT 0.99.9
Date: Sun, 30 Oct 2005 17:31:33 -0500
Message-ID: <436549C5.3000204@michonline.com>
References: <20051030203808.A535B353E3E@atlas.denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig789F00AABFF33C35916B3744"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 23:33:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWLiG-0003K0-9S
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 23:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVJ3Wbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 17:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJ3Wbh
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 17:31:37 -0500
Received: from mail.autoweb.net ([198.172.237.26]:65514 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932367AbVJ3Wbh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2005 17:31:37 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EWLiA-0000rl-OQ; Sun, 30 Oct 2005 17:31:34 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EWLiA-0003qF-00; Sun, 30 Oct 2005 17:31:34 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EWLiA-0007ov-34; Sun, 30 Oct 2005 17:31:34 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051030203808.A535B353E3E@atlas.denx.de>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10837>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig789F00AABFF33C35916B3744
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Wolfgang Denk wrote:
> As a workaround I can simply unset CDPATH, and the build works  fine.
> A more robust build script woul make sure that CDPATH is not set.

Try setting CDPATH, but not exporting it in your shell startup
configuration.


--------------enig789F00AABFF33C35916B3744
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDZUnFfhVDhkBuUKURAgKYAJ9DSUCXGFumvklGuV2BxKYyzRpt3ACeJgJP
/AxMxIVnyoUpJI7UrH7r0Ak=
=SQmI
-----END PGP SIGNATURE-----

--------------enig789F00AABFF33C35916B3744--
