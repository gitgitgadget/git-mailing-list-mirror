From: Jeff King <peff@peff.net>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 20:21:26 -0400
Message-ID: <20070328002126.GA13354@coredump.intra.peff.net>
References: <17929.45908.803852.973157@lisa.zopyra.com> <Pine.LNX.4.63.0703271549210.15345@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLuu-0007yC-CH
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 02:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965396AbXC1AVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 20:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbXC1AV3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 20:21:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3490 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965396AbXC1AV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 20:21:29 -0400
Received: (qmail 7105 invoked from network); 28 Mar 2007 00:21:59 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 00:21:59 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 20:21:26 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703271549210.15345@qynat.qvtvafvgr.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43335>

On Tue, Mar 27, 2007 at 03:51:36PM -0800, David Lang wrote:

> >Hmm, perhaps I should learn to use gitk more, though I must admit
> >to being somewhat of an anti-GUI bigot (i.e., lazy).
> 
> given that we had someone post a tool to the list that creates ascii-art 
> merge diagrams, I wonder if it would scratch anyone's itch to make an ascii 
> output version of gitk?

I don't like using a GUI either, but I have to admit that the output of
gitk is so superior that it's worth it.

However, check out the curses line-drawing support that is in tig
now...it just recently has gotten good enough that I might switch to it.

-Peff
