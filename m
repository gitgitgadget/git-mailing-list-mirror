From: =?UTF-8?B?5a6L5Yas55Sf?= <dongsheng.song@gmail.com>
Subject: cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 fail
Date: Wed, 24 Aug 2005 16:01:17 +0800
Message-ID: <430C294D.1060606@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig51DB35B15125C0174DE98BB4"
X-From: git-owner@vger.kernel.org Wed Aug 24 10:03:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7qDL-0007Wa-4i
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 10:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVHXIBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 04:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVHXIBe
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 04:01:34 -0400
Received: from [61.144.60.122] ([61.144.60.122]:36357 "EHLO foresee.com.cn")
	by vger.kernel.org with ESMTP id S1750759AbVHXIBd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 04:01:33 -0400
Received: from [127.0.0.1] by foresee.com.cn
	(MDaemon.PRO.v7.2.0.R)
	with ESMTP id md50000135930.msg
	for <git@vger.kernel.org>; Wed, 24 Aug 2005 16:01:25 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: zh-cn,zh
To: git@vger.kernel.org
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=2103D24D
X-Authenticated-Sender: songdongsheng@foresee.com.cn
X-Spam-Processed: foresee.com.cn, Wed, 24 Aug 2005 16:01:25 +0800
	(not processed: message from trusted or authenticated source)
X-Return-Path: dongsheng.song@gmail.com
X-MDaemon-Deliver-To: git@vger.kernel.org
X-MDAV-Processed: foresee.com.cn, Wed, 24 Aug 2005 16:01:26 +0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7706>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51DB35B15125C0174DE98BB4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Because the rsync access method is DEPRECATED and will be REMOVED in the
future, I try the http pull method:

ab:/tmp$ cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
defaulting to local storage area
15:57:06
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master
[41/41] -> "refs/heads/.origin-pulling" [1]
Getting pack list
Getting index for pack e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135
Getting index for pack c60dc6f7486e34043bd6861d6b2c0d21756dde76
Getting index for pack 011d837bd60b7e2544fa0f095ae4ca0d61c3c1ea
error: Couldn't get 0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf: not
separate or in any pack
error: Tried
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/05/72e3da3ff5c3744b2f606ecf296d5f89a4bbdf
Cannot obtain needed object 0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-clone: pull failed
ab:/tmp$



--------------enig51DB35B15125C0174DE98BB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iD8DBQFDDClSCj9hEiED0k0RAug+AKCtNXg2pXk8Xt7TUIG98r9CE2frtwCdE08L
wh9duyvmT4/VVJdprKf9+og=
=feoq
-----END PGP SIGNATURE-----

--------------enig51DB35B15125C0174DE98BB4--
