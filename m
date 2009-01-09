From: Tim Shepard <shep@alum.mit.edu>
Subject: Re: 1.5.6.5 fails to clone git.kernel.org/[...]/rostedt/linux-2.6-rt
Date: Fri, 09 Jan 2009 16:08:03 -0500
Message-ID: <E1LLOaJ-0004ce-00@alva.home>
References: <7vpriw26uo.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 22:10:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLOcF-0006dF-OX
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 22:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZAIVIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 16:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZAIVIi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 16:08:38 -0500
Received: from dsl092-066-146.bos1.dsl.speakeasy.net ([66.92.66.146]:41768
	"EHLO alva.home" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754133AbZAIVIh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 16:08:37 -0500
Received: from shep (helo=alva.home)
	by alva.home with local-esmtp (Exim 3.36 #1 (Debian))
	id 1LLOaJ-0004ce-00; Fri, 09 Jan 2009 16:08:03 -0500
In-reply-to: Your message of Fri, 09 Jan 2009 00:58:55 -0800.
             <7vpriw26uo.fsf@gitster.siamese.dyndns.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105040>



Junio,

Thank you for your good explanation.

Also thanks to Miklos Vajna who also replied to suggest using git:// transport.


(Over 3 years ago I used git glone to get a copy of torvalds/linux-2.6.git
 using rsync transport and I copied the recipe I used then.  It has been
 working for "git pull" updates, and for one from-scratch re-clone
 I did sometime last year. I had no reason to suspect it was broken.)

This morning I re-started the clone using git:// transport and it worked OK.


			-Tim Shepard
			 shep@alum.mit.edu
