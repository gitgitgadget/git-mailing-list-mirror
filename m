From: Francis Daly <francis@daoine.org>
Subject: Re: [PATCH] Some doc typo fixes
Date: Wed, 7 Jun 2006 18:46:14 +0100
Message-ID: <20060607174614.GU29682@craic.sysops.org>
References: <20060607125644.GT29682@craic.sysops.org> <7v1wu0lxnd.fsf@assigned-by-dhcp.cox.net> <7vwtbshp3d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 19:46:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo26q-0005MG-EX
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 19:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWFGRqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 13:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWFGRqW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 13:46:22 -0400
Received: from craic.sysops.org ([217.75.2.2]:51176 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1750889AbWFGRqV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 13:46:21 -0400
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.13.1/8.12.11) with SMTP id k57HkEu0031251;
	Wed, 7 Jun 2006 18:46:14 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtbshp3d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.88/1517/Wed Jun  7 01:05:07 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.5
X-Spam-Checker-Version: SpamAssassin 3.0.5 (2005-11-28) on craic.sysops.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21445>

On Wed, Jun 07, 2006 at 10:07:02AM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > Francis Daly <francis@daoine.org> writes:

> > Thanks.  I am not a native, and this is very much appreciated.

You're welcome.

> >>  . It could be named hierarchically (i.e. separated with slash
> >> -  `/`), but each of its component cannot begin with a dot `.`;
> >> +  `/`), but each of its components cannot begin with a dot `.`;
> >
> > I am not sure; ...
> 
> Sheesh, I was reading the diff backwards.  Sorry.

No worries.  I had a head-scratching moment, and suspect that the whole
stanza could be better phrased.  If only there was someone who didn't
already know what it means, they could suggest which phrasing makes
it clear...

How about rewriting it as

It can include slash `/` for hierarchical (directory) grouping, but no
slash-separated component can begin with a dot `.`;

?

"can" instead of "could" fits the later parts, and it removes the
possessive and reverses the negative for something that (to my mind)
scans better.

Cheers,

	f
-- 
Francis Daly        francis@daoine.org
