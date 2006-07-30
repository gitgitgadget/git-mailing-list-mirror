From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Sun, 30 Jul 2006 10:55:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607301047150.9789@iabervon.org>
References: <20060728063620.GD30783@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 16:54:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Cg0-0000kJ-3O
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 16:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWG3Oxx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 10:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWG3Oxx
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 10:53:53 -0400
Received: from iabervon.org ([66.92.72.58]:64518 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750917AbWG3Oxw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 10:53:52 -0400
Received: (qmail 8738 invoked by uid 1000); 30 Jul 2006 10:55:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jul 2006 10:55:03 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060728063620.GD30783@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24458>

On Fri, 28 Jul 2006, Shawn Pearce wrote:

> I would appreciate any and all input, feedback, etc. that anyone
> might have on this library or plugin.  Patches are of course
> certainly welcome.  :-)

I'm going to try to do a Servlet (+ my stuff) implementation of essentiall 
gitweb, with the idea that it could integrate with project management 
software (i.e., link completed tasks to the commit which completed them, 
regressions to the commit that broke things, fixes to the commit that 
fixed them, etc, with the UI for choosing values letting you browse the 
actual content and validating that the hash you give exists).

I don't think I need anything you don't already have, but I'll write 
documentation as I figure out what's going on, if you want that.

	-Daniel
*This .sig left intentionally blank*
