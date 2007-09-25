From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move convert-objects to contrib.
Date: Tue, 25 Sep 2007 15:06:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251506220.28395@racer.site>
References: <1190690061-6720-1-git-send-email-kraai@ftbfs.org>
 <Pine.LNX.4.64.0709251100560.28395@racer.site> <20070925140425.GA6061@ftbfs.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:08:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaB5E-0004KH-6c
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbXIYOHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbXIYOHm
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:07:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:40392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752209AbXIYOHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 10:07:41 -0400
Received: (qmail invoked by alias); 25 Sep 2007 14:07:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 25 Sep 2007 16:07:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/l0Ixt+yTllGgybJ84ySUNvo3eEOYmZKw1SqVt/F
	+3Sa3lx15d3Sgu
X-X-Sender: gene099@racer.site
In-Reply-To: <20070925140425.GA6061@ftbfs.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59125>

Hi,

On Tue, 25 Sep 2007, Matt Kraai wrote:

> On Tue, Sep 25, 2007 at 11:01:58AM +0100, Johannes Schindelin wrote:
> > the commit message looks a little bit empty to me.  I'd at least 
> > mention why convert-objects was needed, why it is no longer needed, 
> > and that Linus, the original author, is okay with it.
> > 
> > And you might want to use the "-M" flag to format-patch next time 
> > (detect renames).
> 
> OK, thanks.  I've resubmitted the patch, (hopefully) taking both 
> suggestions into account.

Yep, thanks, a pleasure to the eye.

Ciao,
Dscho
