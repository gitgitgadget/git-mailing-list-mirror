From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Wed, 24 Jan 2007 00:27:53 +0100
Message-ID: <m34pqh2uiu.fsf@maximus.localdomain>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701210137.41219.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.63.0701210234350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17842.53449.35322.514320@lisa.zopyra.com>
	<7vr6tp5aqq.fsf@assigned-by-dhcp.cox.net>
	<87vej0gh4k.fsf@morpheus.local> <m3zm89zxs1.fsf@maximus.localdomain>
	<873b6197jf.fsf@morpheus.local> <m3irexzua9.fsf@maximus.localdomain>
	<86bqkp1xkz.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 00:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9V3W-0002rV-Lp
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 00:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965591AbXAWX15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 18:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965595AbXAWX15
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 18:27:57 -0500
Received: from khc.piap.pl ([195.187.100.11]:52961 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965591AbXAWX14 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 18:27:56 -0500
Received: by khc.piap.pl (Postfix, from userid 500)
	id A975D65652; Wed, 24 Jan 2007 00:27:53 +0100 (CET)
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86bqkp1xkz.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Tue, 23 Jan 2007 09:07:08 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37580>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> The proper solution is to *follow* the RFCs,

Do you remember RFC #s by chance? Some details maybe?

> and leave the reply-to alone
> when
> relaying.  If someone wants to reply to the list *and* the person, they can
> reply to both the "from (or reply-to)" and "to" addresses, often called a
> "wide reply".  If someone wants to reply to just the person, they use the
> "reply-to" if it's present, or the "from" if not.  This is *proper* behavior:
> it's only some broken mailing lists out there that have caused us to have to
> work around it.

The list doesn't modify the headers in question, at least as far as lkml
is concerned, so I assume you mean some other lists that are broken.

Reply-To is for the author to set, list software shouldn't change it.
While it's normal to reply to "From", "Cc" and "To" (at least here),
some people prefer to be omitted when replying to their mail. How could
they do that if not with Reply-To?

Then, if I see lkml and no author's address in Reply-To, how
could I contact him/her privately if not writing to "From" and
ignoring Reply-To?
-- 
Krzysztof Halasa
