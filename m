From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Thu, 6 Mar 2008 01:11:16 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803060105250.15786@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site>
 <7vir00lski.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803052327570.15786@racer.site> <7v1w6olr84.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 01:12:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX3iJ-0007ob-0f
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 01:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYCFALS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 19:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYCFALR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 19:11:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:39457 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750808AbYCFALR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 19:11:17 -0500
Received: (qmail invoked by alias); 06 Mar 2008 00:11:15 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp041) with SMTP; 06 Mar 2008 01:11:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188di8vHn08xggqA98GM3jBeXVzqL/yWOSv5RtSk0
	dFmv63JmetU1RI
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1w6olr84.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76297>

Hi,

On Wed, 5 Mar 2008, Junio C Hamano wrote:

> Recently, I ended up wasting two nights because I was not careful enough 
> earlier, when I was short of time and apparent backlog was beginning to 
> get larger and larger.
> 
> I queued some patches from the backlog to 'next' saying "ah, they look 
> good enough, people will notice breakages anyway," but the breakage was 
> not caught until 'master' got broken.
> 
> Not good.  And the list is not to blame.

Ah, but I think that you are too harsh onto yourself.  Recently, there was 
a surge of patches, mainly because 1.5.4 was held of -- but for a good 
reason: 1.5.4 was not ready before the point in time where you decided to 
release it.

If at all, the list is to blame, for just sending patches, but not 
reviewing them.

Now, personally I know that I am not half as good a reviewer as you are, 
since you catch way more bugs than me, just by looking at the patch.

But still, "many eyes make bugs shallow" is a principle to be heeded 
_everywhere_.

So I'd say: if you think that you are short of time, and patches have not 
been reviewed properly, do not assume it _your sole_ responsibility to 
review the patches.  Make it known that other people have to step in (even 
if it is a mediocre reviewer like me).  Do not overload yourself.

So my comment about the "blame" was really tongue-in-cheek.  Please do not 
take it for anything but a joke.

And when I say that I think you are a kick-ass maintainer, I _mean_ it.

'nuff said,
Dscho
