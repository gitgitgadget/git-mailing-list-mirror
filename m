From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] GIT: Support [address] in URLs
Date: Wed, 21 Dec 2005 16:08:11 -0800 (PST)
Message-ID: <20051221.160811.129593851.davem@davemloft.net>
References: <20051222.080828.28117009.yoshfuji@linux-ipv6.org>
	<20051221.152648.122640664.davem@davemloft.net>
	<20051222.085917.60400643.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org, matti.aarnio@zmailer.org
X-From: git-owner@vger.kernel.org Thu Dec 22 01:08:31 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpE0Q-0005Nc-At
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 01:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVLVAIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 19:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVLVAIK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 19:08:10 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5584
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965015AbVLVAIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 19:08:09 -0500
Received: from localhost.localdomain
	([127.0.0.1] helo=localhost ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1EpE0B-0006Oh-Mz; Wed, 21 Dec 2005 16:08:11 -0800
To: yoshfuji@linux-ipv6.org
In-Reply-To: <20051222.085917.60400643.yoshfuji@linux-ipv6.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13923>

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date: Thu, 22 Dec 2005 08:59:17 +0900 (JST)

> Can I help you somehow?
> E.g. if you give me an account on vger, I happily try to find the way to
> setup bayesian filter(s) on them.

You are expert with Zmailer+Majordomo? :-)

Sure, it is no problem to setup Bayesian filter with sendmail, qmail,
Exim et al. with standard mailing list software.  But doing it with
the Zmailer and Majordomo setup we have is non-trivial.

Matti, non-ascii filtering really becomes big enough pain enough to
fix.  I can do the leg work if you can provide some pointers and
what you know so far.

Thanks.
