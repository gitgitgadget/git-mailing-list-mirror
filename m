From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 11:04:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701111103140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701110949421.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsleh51zx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 11:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wnS-0006DM-L3
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 11:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbXAKKEb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 05:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXAKKEb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 05:04:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:47397 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030237AbXAKKEa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 05:04:30 -0500
Received: (qmail invoked by alias); 11 Jan 2007 10:04:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp006) with SMTP; 11 Jan 2007 11:04:29 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsleh51zx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36573>

Hi,

On Thu, 11 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > BTW I am not quite sure if you missed this patch: 
> > http://thread.gmane.org/gmane.comp.version-control.git/36212/, or if you 
> > did not like it, want enhancements, ...
> 
> It is still sitting in my in-box; I tend to agree with Shawn in
> that mixing the reflog sequence and true parenthood in the same
> traversal is kind of insane.

Okay.

> I vaguely recall you thought dropping that would make the code simpler, 
> and was kind of waiting for that to happen to review the results.

I was kind of waiting if somebody actually cares.

> Also I did not quite understand your comment about circular log
> entries.

But you did! My comment was only that I did not test if it actually works 
as expected.

Ciao,
Dscho
