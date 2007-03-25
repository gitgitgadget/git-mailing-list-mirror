From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: .gitlink for Summer of Code
Date: Sun, 25 Mar 2007 16:46:01 -0400
Message-ID: <20070325204601.GC12376@spearce.org>
References: <1174825838.12540.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:46:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZbO-0000d6-VZ
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbXCYUqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbXCYUqH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:46:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60068 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbXCYUqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:46:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVZb8-0000e5-JA; Sun, 25 Mar 2007 16:45:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8CFE920FBAE; Sun, 25 Mar 2007 16:46:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1174825838.12540.5.camel@localhost>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43071>

Eric Lesh <eclesh@ucla.edu> wrote:
> I would like to tackle .gitlink for Summer of Code.  The deadline is
> about a day away, but this is a chance to make sure you still think
> .gitlink is a good idea, and to see if there are any big problems with
> the idea in general (before a more detailed proposal is actually submitted).
...
> Is this something that you would like to see?  Any other comments?

Aside from the other fork of this thread discussing the ``Lazy
Clone'' idea, I don't really have any other comments.

I don't setup the same thing as Junio, but I have the same problem.
My day job setup has at least 5 copies of the same repository.
I'd like an easy way to have them share the same odb, refs,
and config.

If you choose to submit an application please see our template
(http://git.or.cz/gitwiki/SoC2007Template) and try to talk a bit
about your background too.

-- 
Shawn.
