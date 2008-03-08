From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Sat, 8 Mar 2008 18:27:55 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081826080.19665@iabervon.org>
References: <200803061735.47674.david-b@pacbell.net> <200803081448.47000.david-b@pacbell.net> <alpine.LNX.1.00.0803081750580.19665@iabervon.org> <200803081525.08181.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:28:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8T1-0006lk-0l
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbYCHX16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbYCHX16
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:27:58 -0500
Received: from iabervon.org ([66.92.72.58]:56858 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095AbYCHX15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:27:57 -0500
Received: (qmail 19926 invoked by uid 1000); 8 Mar 2008 23:27:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:27:55 -0000
In-Reply-To: <200803081525.08181.david-b@pacbell.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76622>

On Sat, 8 Mar 2008, David Brownell wrote:

> On Saturday 08 March 2008, Daniel Barkalow wrote:
> > I think that there's a dependance on how your current state and  
> > the new state happen to line up.
> 
> The workspace in the tarball I can send you doesn't have any issues
> with reproducibility ... now.  

Let me see if I can write up a patch that you should be able to test 
without moving the big file around. I may run out of time for tonight, 
though.

	-Daniel
*This .sig left intentionally blank*
