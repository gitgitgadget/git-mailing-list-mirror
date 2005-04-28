From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH] cg-mkpatch: Show diffstat before the patch
Date: Thu, 28 Apr 2005 09:07:02 +0900 (JST)
Organization: USAGI Project
Message-ID: <20050428.090702.23236031.yoshfuji@linux-ipv6.org>
References: <20050426225855.GA28560@diku.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:59:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwQx-0005ls-HO
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVD1AEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVD1AEg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:04:36 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:5895 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262109AbVD1AEc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 20:04:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 50CD133CC2; Thu, 28 Apr 2005 09:07:04 +0900 (JST)
To: fonseca@diku.dk
In-Reply-To: <20050426225855.GA28560@diku.dk>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In article <20050426225855.GA28560@diku.dk> (at Wed, 27 Apr 2005 00:58:55 +0200), Jonas Fonseca <fonseca@diku.dk> says:

> Show diffstat before the patch.

We do not always need to generate diffstat.
Please add -s option or something to prepend diffstat.
Thanks.

--yoshfuji
