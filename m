From: Jeff King <peff@peff.net>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 02:25:07 -0500
Message-ID: <20061223072507.GA8974@segfault.peff.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <20061223062801.GA5415@segfault.peff.net> <7vy7ozt7c9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:25:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Fv-000137-3F
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbWLWHZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbWLWHZK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:25:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4644 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752628AbWLWHZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:25:09 -0500
Received: (qmail 9014 invoked by uid 1000); 23 Dec 2006 02:25:07 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7ozt7c9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35279>

On Fri, Dec 22, 2006 at 11:11:18PM -0800, Junio C Hamano wrote:

> Not at all.  I pull from gitk repository and I do not have
> tracking branch, but I still have a remote defined for it.

Do you also define branch.*.merge to use with this? Is there a reason
you don't want a tracking branch?

-Peff
