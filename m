From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 22:14:36 +0100
Message-ID: <20080319211436.GC17940@kernel.dk>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <20080318182421.GI17940@kernel.dk> <alpine.LFD.1.00.0803181130240.3020@woody.linux-foundation.org> <20080318183906.GL17940@kernel.dk> <alpine.LSU.1.00.0803192121090.3983@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5gf-0001kn-3X
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936632AbYCSVOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936627AbYCSVOm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:14:42 -0400
Received: from brick.kernel.dk ([87.55.233.238]:13922 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936626AbYCSVOl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:14:41 -0400
Received: by kernel.dk (Postfix, from userid 500)
	id 75DBE25880B; Wed, 19 Mar 2008 22:14:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803192121090.3983@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77550>

On Wed, Mar 19 2008, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 18 Mar 2008, Jens Axboe wrote:
> 
> > But you never answer the question on whether you really consider any 
> > form of autopacking or auto gc sane? Next time some other limit is added 
> > for auto gc, it'll be annoying once more.
> 
> The problem is: if people do not bother to "git gc" their repositories, 
> git operations get slow.  We just had enough of that, and decided to "git 
> gc" automatically for people who did not know about it, or were to lazy 
> and then complained about git for being slow.

Sorry I disagree, it's policy and that is usually a bad thing. In this
case it definitely is.

-- 
Jens Axboe
