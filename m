From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Make "git gc" pack all refs by default
Date: Thu, 24 May 2007 20:28:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705242027430.4648@racer.site>
References: <alpine.LFD.0.98.0705241132400.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 24 21:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIzO-0003TF-VR
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbXEXT2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 15:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbXEXT2o
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:28:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:42993 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751096AbXEXT2o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:28:44 -0400
Received: (qmail invoked by alias); 24 May 2007 19:28:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 24 May 2007 21:28:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190hi1R0Z10du+sfVNbG2lmJ2qQLwqt5AV7cOgdpj
	0vg1+Igs291yWl
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0705241132400.26602@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48297>

Hi,

On Thu, 24 May 2007, Linus Torvalds wrote:

> I've taught myself to use "git gc" instead of doing the repack explicitly, 
> but it doesn't actually do what I think it should do.
> 
> We've had packed refs for a long time now, and I think it just makes sense 
> to pack normal branches too.

FWIW I already suggested that: 
http://article.gmane.org/gmane.comp.version-control.git/28533

Since there seemed not much interest in that, I let it slip.

Ciao,
Dscho
