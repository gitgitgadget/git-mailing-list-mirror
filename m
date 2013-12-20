From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: gitk: file viewer call even for an binary document ?
Date: Fri, 20 Dec 2013 20:24:01 +0100
Message-ID: <52B49951.6030900@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 20 20:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu5gA-0003xR-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 20:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab3LTTYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Dec 2013 14:24:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:60206 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab3LTTYE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 14:24:04 -0500
Received: from [192.168.178.21] ([78.54.170.3]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MGRhs-1VguOo1xgW-00DCM6 for <git@vger.kernel.org>;
 Fri, 20 Dec 2013 20:24:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Muza4Spqat0tMVug0kUeTWAf0tTrOCbTlAr+hkFpyqeHfdfF2r+
 k1YhSn0TzkbbVsP/vJ6yTZ5F2Z5pz3xceLpInlIeEoVA2nvOTBiZTsruBeVEpcQYRQ5Fg41
 d6ausaXS1CLpmUzv4v9pB+MfvHzYadERqxLjosTaRF2ZEVkUFparNJaXMVSSLF8jxpxITsD
 ZTt2xfjVJwV7JQFyh+wmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239579>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

dev-vcs/git-1.8.3.2-r1 at a stable 32 bit Gentoo Linux:

If I right click onto a file in the right pane and choose "Blame parent=
 commit" then even for a binary file (open doc sheet) the file viewer i=
s started - works as designed or a  bug ?


- --=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print:1A37 6F99 4A9D 026F 13E2 4DCF C4EA CDDE 0076 E94E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlK0mVEACgkQxOrN3gB26U60KQD+M4z5rnOiU7uE8524vHP/hyjz
S586+WIdGFiCz0k0CZIA/jM+bsWaNuyAZk/9vSbflFIv3doiuC/OKnz1MlB1QQp5
=3Dg1Fd
-----END PGP SIGNATURE-----
