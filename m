From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] git-blame: Use the same tests for git-blame as for git-annotate
Date: Sun, 05 Mar 2006 18:32:47 -0500
Message-ID: <440B751F.5000801@michonline.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7D380550841A8204EA204B6C"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 00:33:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG2ik-0001Ds-9T
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 00:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbWCEXc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 18:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEXc6
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 18:32:58 -0500
Received: from mail.autoweb.net ([198.172.237.26]:60839 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1752082AbWCEXc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 18:32:58 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FG2ie-0001qH-1r; Sun, 05 Mar 2006 18:32:57 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG2iZ-00044y-1h; Sun, 05 Mar 2006 18:32:51 -0500
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG2iY-00038Q-P6; Sun, 05 Mar 2006 18:32:50 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060305111334.GB23448@c165.ib.student.liu.se>
X-Enigmail-Version: 0.93.0.0
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17251>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D380550841A8204EA204B6C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Along these lines, if anyone can pin down the complicated cases that
annotate and blame get differently, adding them as a test would be
*exceedingly* appreciated, even if it makes annotate (or blame) fail for
a bit, it gives us something to work against.

I've been trying to find some time this weekend to dig into why annotate
gets things wrong, but I've been distracted, unfortunately.


-- 

Ryan Anderson
  sometimes Pug Majere


--------------enig7D380550841A8204EA204B6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEC3UifhVDhkBuUKURAilgAKDf7JzVLPc2sqDJT/1YyHlykLCJ/gCguwY1
mflK5KQ7n5rxTBTEAbKw52U=
=iu01
-----END PGP SIGNATURE-----

--------------enig7D380550841A8204EA204B6C--
