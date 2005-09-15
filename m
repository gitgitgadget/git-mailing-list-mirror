From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: Make test failure!?
Date: Thu, 15 Sep 2005 20:19:32 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20050915.201932.17321791.yoshfuji@linux-ipv6.org>
References: <7vu0gm7mxy.fsf@assigned-by-dhcp.cox.net>
	<20050915.174206.90748347.yoshfuji@linux-ipv6.org>
	<7vpsra3cdg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Thu Sep 15 13:20:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFrlQ-0000rI-TP
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 13:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVIOLRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 07:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVIOLRx
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 07:17:53 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:52238 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750896AbVIOLRw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 07:17:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 7C00A33CC2; Thu, 15 Sep 2005 20:19:34 +0900 (JST)
To: junkio@cox.net
In-Reply-To: <7vpsra3cdg.fsf@assigned-by-dhcp.cox.net>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8603>

In article <7vpsra3cdg.fsf@assigned-by-dhcp.cox.net> (at Thu, 15 Sep 2005 02:32:11 -0700), Junio C Hamano <junkio@cox.net> says:

> I suspect you have different GNU diff versions between these two
> machines?

Right. 2.8.1 (ok) vs 2.7 (ng).

--yoshfuji
