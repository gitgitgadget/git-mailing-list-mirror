From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH] GIT: Support [address] in URLs
Date: Thu, 22 Dec 2005 08:59:17 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20051222.085917.60400643.yoshfuji@linux-ipv6.org>
References: <7v3bkm3vw4.fsf@assigned-by-dhcp.cox.net>
	<20051222.080828.28117009.yoshfuji@linux-ipv6.org>
	<20051221.152648.122640664.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Thu Dec 22 00:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpDrC-00038y-Kw
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 00:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVLUX6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 18:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVLUX6w
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 18:58:52 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:12296 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S965005AbVLUX6v
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 18:58:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 5CE8633CC2; Thu, 22 Dec 2005 08:59:18 +0900 (JST)
To: davem@davemloft.net
In-Reply-To: <20051221.152648.122640664.davem@davemloft.net>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13922>

In article <20051221.152648.122640664.davem@davemloft.net> (at Wed, 21 Dec 2005 15:26:48 -0800 (PST)), "David S. Miller" <davem@davemloft.net> says:

> The vger.kernel.org spam filter filters out all non-ascii character
> sets.  We have to do this because Matti and myself do all of the
> filtering by hand, and we do not understand so many languages as to be
> able to make sensible filters for spam in languages such as Japanese,
> Korean, Chinese, Russian, etc. so we just filter them all.

Too bad...

Well, I know some Japanese people kill all messages with non-Japanese
(usually English) subject... It is too bad, too...


> This is a pain, but no better solutions have been suggested.  Before
> anyone responds: 1) making the lists subscriber-only is not an option
> 2) Bayesian filters are hard to integrate into our setup but we are
> exploring ways to make that a reality at some point nevertheless.

Can I help you somehow?
E.g. if you give me an account on vger, I happily try to find the way to
setup bayesian filter(s) on them.

Regards,

--yoshfuji
