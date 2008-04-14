From: David Miller <davem@davemloft.net>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 03:41:16 -0700 (PDT)
Message-ID: <20080414.034116.24468363.davem@davemloft.net>
References: <20080414010412.c42dc560.akpm@linux-foundation.org>
	<20080414.013058.149905948.davem@davemloft.net>
	<20080414031530.2507660d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: viro@ZenIV.linux.org.uk, w@1wt.eu, david@lang.hm,
	sclark46@earthlink.net, johnpol@2ka.mipt.ru, rjw@sisk.pl,
	tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: akpm@linux-foundation.org
X-From: git-owner@vger.kernel.org Mon Apr 14 12:42:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlM8R-0004wq-JF
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 12:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbYDNKlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 06:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbYDNKlR
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 06:41:17 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53885
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755051AbYDNKlP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 06:41:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 75FBAC8CA9E;
	Mon, 14 Apr 2008 03:41:16 -0700 (PDT)
In-Reply-To: <20080414031530.2507660d.akpm@linux-foundation.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79496>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 14 Apr 2008 03:15:30 -0700

> You carefully deleted my text so that you could misquote it, thereby
> flagrantly misrepresenting everything I said.

Not the intention, but anyways:

> Here it is again:
> 
> : The steps to be taken are:
> : 
> : a) agree that we have a problem
> : 
> : b) agree that we need to address it
> : 
> : c) identify the day-to-day work practices which will help address it (as
> :    you have done)
> : 
> : d) identify the process changes which will force us to adopt those practices
> : 
> : e) implement those process changes.
> 
> Forcing a discipline upon oneself is totally different from having it
> forced upon you by someone else.
> 
> Each step will need general agreement and buyin, otherwise none of it will
> (or should) work.

The "force" is to "us" which is a group.

And I imagine that newcomers will be expected to adopt these
"practices".  So in effect, they will be "forced" into the process
changes as well.

I'm getting more and more sensitive to issues on this level over time,
because I realize that the fundamental issue in all human group issues
is getting people to "want" to do things.  And "force", in any form,
tends to be incompatible with "want".  And in particular, people will
often even shun things they "want" when it is "forced" to them.
