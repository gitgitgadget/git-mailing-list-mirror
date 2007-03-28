From: Jeff King <peff@peff.net>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 22:52:00 -0400
Message-ID: <20070328025200.GA13563@coredump.intra.peff.net>
References: <17929.37382.984339.742025@lisa.zopyra.com> <20070327233552.GA7186@coredump.intra.peff.net> <Pine.LNX.4.64.0703271759510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 04:52:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWOGu-0001zU-P0
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 04:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbXC1CwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 22:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbXC1CwH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 22:52:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1384 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbXC1CwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 22:52:06 -0400
Received: (qmail 10680 invoked from network); 28 Mar 2007 02:52:33 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 02:52:33 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 22:52:00 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703271759510.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43344>

On Tue, Mar 27, 2007 at 06:06:11PM -0700, Linus Torvalds wrote:

> The merge-base is the right thing to do for *merging*, but if you keep 
> merging into the branch you are developing on (to keep up-to-date), the 
> above "what is on the branch but not in the origin" is definitely the 
> right thing to do.

Of course you're right, I must have had afternoon brain impairment when
I wrote that other message.

-Peff
