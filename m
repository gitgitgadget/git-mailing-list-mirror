From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH v3 2/2] git-svn.perl: keep processing all commits in parents_exclude
Date: Sat, 18 Aug 2012 16:37:26 -0700
Message-ID: <50302736.9060404@vilain.net>
References: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com> <1344705265-10939-2-git-send-email-stevenrwalter@gmail.com> <502FF250.6010402@vilain.net> <CAK8d-aKMsSQGMmLrUFDCr1VDbxGPVsPJFgR=Okd-=7BV3AjzOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, avarab@gmail.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 01:38:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2sb6-0003x0-K0
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 01:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab2HRXhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 19:37:33 -0400
Received: from uk.vilain.net ([92.48.122.123]:42253 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab2HRXhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 19:37:32 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 545978284; Sun, 19 Aug 2012 00:37:31 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.136] (c-50-136-135-232.hsd1.ca.comcast.net [50.136.135.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id 3F1F78176;
	Sun, 19 Aug 2012 00:37:28 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <CAK8d-aKMsSQGMmLrUFDCr1VDbxGPVsPJFgR=Okd-=7BV3AjzOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203705>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 08/18/2012 01:43 PM, Steven Walter wrote:
 > How about a Signed-Off-By?

Signed-Off-By: Sam Vilain <sam@vilain.net>

Sam

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBCgAGBQJQMCcnAAoJEBdtaL3wGtIoJ1UIAIJ6Xz5OEMmMk1tq546eggHg
I+sJIFjqg+mo53VqT0/bKhqg8sLx8F/Gda15nwOUMcslKJdA+sCc+QhAtgSWJ1WK
Idw59jtZHbabfopBHNgneSqVBhXSKpNw3e3EvlRVkK1wobO0+c0X6YkBG0eBCZl2
6RYXIAb6jX04k1hSrnxcPn+REkoyl31aEuFBPNz0wRWHjju+G6bPY/x7D/gO1YOc
/uRQXveQngJOLwawDR+dGS+0aWPseX/sbZqsVFo0hVQYqoHt+s4uVuriBfHSRKd+
R1eUoY0ikW4UvEwZX74Zf3SeoVLLFnkCW8B5XsGb10IojbvY3uyYevATXI79j1Y=
=Lb7H
-----END PGP SIGNATURE-----
