From: =?UTF-8?B?5a6L5Yas55Sf?= <dongsheng.song@gmail.com>
Subject: Re: cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 fail
Date: Wed, 24 Aug 2005 18:03:34 +0800
Message-ID: <430C45F6.6040809@gmail.com>
References: <430C294D.1060606@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6E8A18373329B91F5C4AC10C"
X-From: git-owner@vger.kernel.org Wed Aug 24 12:05:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7s7M-0004m5-W3
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 12:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVHXKDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 06:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVHXKDq
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 06:03:46 -0400
Received: from [61.144.60.122] ([61.144.60.122]:61704 "EHLO foresee.com.cn")
	by vger.kernel.org with ESMTP id S1750848AbVHXKDp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 06:03:45 -0400
Received: from [127.0.0.1] by foresee.com.cn
	(MDaemon.PRO.v7.2.0.R)
	with ESMTP id md50000136034.msg
	for <git@vger.kernel.org>; Wed, 24 Aug 2005 18:03:36 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: zh-cn,zh
To: git@vger.kernel.org
In-Reply-To: <430C294D.1060606@gmail.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=2103D24D
X-Authenticated-Sender: songdongsheng@foresee.com.cn
X-Spam-Processed: foresee.com.cn, Wed, 24 Aug 2005 18:03:36 +0800
	(not processed: message from trusted or authenticated source)
X-Return-Path: dongsheng.song@gmail.com
X-MDaemon-Deliver-To: git@vger.kernel.org
X-MDAV-Processed: foresee.com.cn, Wed, 24 Aug 2005 18:03:38 +0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7707>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E8A18373329B91F5C4AC10C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

But cg-clone git.git sucess:

cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/
defaulting to local storage area
17:39:36
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/refs/heads/master
[41/41] -> "refs/heads/.origin-pulling" [1]
progress: 3 objects, 5345 bytes
Getting pack list
Getting index for pack 3c5133604508466855453f3e609428f4bbba9131
Getting pack 3c5133604508466855453f3e609428f4bbba9131
which contains 6ff87c4664981e4397625791c8ea3bbb5f2279a3
progress: 1810 objects, 4197537 bytes
17:57:40
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/refs/tags/v0.99
[41/41] -> "refs/tags/v0.99" [1]
17:57:41
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/refs/tags/v0.99.1
[41/41] -> "refs/tags/v0.99.1" [1]
17:57:41
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/refs/tags/v0.99.2
[41/41] -> "refs/tags/v0.99.2" [1]
17:57:41
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/refs/tags/v0.99.3
[41/41] -> "refs/tags/v0.99.3" [1]
17:57:43
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/refs/tags/v0.99.4
[41/41] -> "refs/tags/v0.99.4" [1]

FINISHED --17:57:43--
Downloaded: 5,854 bytes in 10 files
Missing object of tag v0.99.1... retrieved
Missing object of tag v0.99.2... retrieved
Missing object of tag v0.99.3... retrieved
Missing object of tag v0.99.4... retrieved
New branch: 2a29da7c6d6103c4719c71f6cce88e853260912c
Cloned to git/ (origin
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
available as branch "origin")

May be linux-2.6.git something wrong?

>Because the rsync access method is DEPRECATED and will be REMOVED in the
>future, I try the http pull method:
>
>ab:/tmp$ cg-clone
>http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>defaulting to local storage area
>15:57:06
>URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master
>[41/41] -> "refs/heads/.origin-pulling" [1]
>Getting pack list
>Getting index for pack e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135
>Getting index for pack c60dc6f7486e34043bd6861d6b2c0d21756dde76
>Getting index for pack 011d837bd60b7e2544fa0f095ae4ca0d61c3c1ea
>error: Couldn't get 0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf: not
>separate or in any pack
>error: Tried
>http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/05/72e3da3ff5c3744b2f606ecf296d5f89a4bbdf
>Cannot obtain needed object 0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf
>while processing commit 0000000000000000000000000000000000000000.
>cg-pull: objects pull failed
>cg-clone: pull failed
>ab:/tmp$
>
>
>  
>


--------------enig6E8A18373329B91F5C4AC10C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iD8DBQFDDEX2Cj9hEiED0k0RAt+qAKC1/xXUGQjz5ucs6U+YybhE4kAaYgCdHm2L
Cd5UxgoHaksB4LSvYnLTuZ8=
=m7sz
-----END PGP SIGNATURE-----

--------------enig6E8A18373329B91F5C4AC10C--
