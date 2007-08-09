From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: Fix for work trees
Date: Thu, 9 Aug 2007 09:45:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708090943340.21857@racer.site>
References: <1186633570700-git-send-email-bdowning@lavos.net>
 <7v1wedz2er.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Downing <bdowning@lavos.net>, git@vger.kernel.org,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 10:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ3eU-0001hi-Sq
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 10:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765006AbXHIIpw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 04:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764889AbXHIIpw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 04:45:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:59722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764833AbXHIIpv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 04:45:51 -0400
Received: (qmail invoked by alias); 09 Aug 2007 08:45:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 09 Aug 2007 10:45:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EhuBJS0ZEfqI0tOsChlzdnfsjxxToKz9ZAT8qr4
	v9I7zyVumqLBpB
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wedz2er.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55428>

Hi,

On Wed, 8 Aug 2007, Junio C Hamano wrote:

> This new world order is probably an improvement, and if the rules were 
> like this from the beginning, it would have been much nicer.  However, 
> this _is_ a change of semantics in the middle of the road, and probably 
> we will see many fallouts like this.  Unfortunate...  I am torn between 
> a cleaner semantics and the short-term pain...

With your warning at the beginning of the ReleaseNotes, I think it would 
be the same amount of pain if we did it later.  It just would be...  
later.

Ciao,
Dscho
