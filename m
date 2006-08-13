From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 16:11:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608131536590.9789@iabervon.org>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
 <20060813191346.GA21487@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 13 22:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCMJ7-0002UN-Tt
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 22:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWHMULe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWHMULe
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 16:11:34 -0400
Received: from iabervon.org ([66.92.72.58]:49676 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751401AbWHMULe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 16:11:34 -0400
Received: (qmail 21478 invoked by uid 1000); 13 Aug 2006 16:11:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Aug 2006 16:11:32 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20060813191346.GA21487@mars.ravnborg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25293>

On Sun, 13 Aug 2006, Sam Ravnborg wrote:

> But important note is that publishing is something I defer until some
> limited test has been done. And when I omit that I have always ended u
> pushing some crappy stuff that needs to be dealt with.

I also test before publishing. But I test before committing, too, because 
I never get anything right (or even logically complete) the first time. My 
cycle is edit/build/test, and if the test is successful, I commit and 
push. Do other people really commit after editing each time? Or are they 
testing before the commit, and doing more extensive testing after the 
commit before the push?

	-Daniel
*This .sig left intentionally blank*
