From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: gitk layout bug
Date: Sun, 20 Jan 2008 21:30:32 +0100
Message-ID: <20080120203032.GA2891@steel.home>
References: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 21:31:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGgot-00052y-LT
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 21:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbYATUaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 15:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbYATUaj
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 15:30:39 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:29566 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147AbYATUai (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 15:30:38 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOGADeA=
Received: from tigra.home (Fafbe.f.strato-dslnet.de [195.4.175.190])
	by post.webmailer.de (fruni mo31) (RZmta 15.4)
	with ESMTP id e03ff2k0KGlcGu ; Sun, 20 Jan 2008 21:30:33 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 01898277AE;
	Sun, 20 Jan 2008 21:30:32 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 5F18A56D22; Sun, 20 Jan 2008 21:30:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71189>

Linus Torvalds, Sun, Jan 20, 2008 02:44:58 +0100:
> 
> In the current git repository, try this:
> 
> 	gitk origin/master..origin/pu
> 
> and it starts out looking ok.
> 
> But then scroll down a bit (say, press "PageDown" ten to twenty times), 
> and scroll up again, and now that thing is totally unusable.
> 
> Is it just me?

No, it was already reported:

    Message-ID: <20071104104618.GA3078@steel.home>
