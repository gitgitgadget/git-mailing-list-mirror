From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Thu, 29 May 2008 17:12:08 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291708500.13507@racer.site.net>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 29 18:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1klV-00030j-ON
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 18:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbYE2QNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 12:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbYE2QNS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 12:13:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:51276 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752647AbYE2QNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 12:13:17 -0400
Received: (qmail invoked by alias); 29 May 2008 16:13:16 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp033) with SMTP; 29 May 2008 18:13:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19amFBaqxlabHUZ2FvoimsJR5iuWxkh1E7l7hkeXu
	MZl3jv9K4uQzqx
X-X-Sender: gene099@racer.site.net
In-Reply-To: <200805291737.53291.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83214>

Hi,

On Thu, 29 May 2008, Thomas Rast wrote:

> You wrote:

Who "You"?  You did not say a name.

> > Adds a new option 'e' to the 'add -p' command loop that lets you 
> > discard or keep one hunk line at a time.  This is useful if there are 
> > no unchanged lines in the middle of the hunk, so 's' will not work, 
> > but you would still like to split it.
> 
> Any news on this?  I would greatly appreciate criticism if something is 
> wrong or inadequate :-)

Oh, probably was you, yourself.  Hrm.  Could have said that.

The splitting (even without common lines at the borders) is something I 
needed myself, but the concept got rebuked in

http://thread.gmane.org/gmane.comp.version-control.git/67854/focus=68108

(See the whole thread for more information)

Ciao,
Dscho
