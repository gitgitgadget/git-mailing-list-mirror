From: Scott Haneda <talklists@newgeo.com>
Subject: Is this an appropriate list for general git questions
Date: Sun, 21 Mar 2010 15:59:44 -0700
Message-ID: <5C4288BC-B87E-41CB-B3CB-90122098B7E9@newgeo.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 00:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtUCR-0000MN-JM
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 00:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab0CUXEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 19:04:47 -0400
Received: from moses.hostwizard.com ([64.84.37.6]:52098 "EHLO
	gonepostal.hostwizard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab0CUXEq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 19:04:46 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2010 19:04:46 EDT
Received: from [192.168.1.102] (173.164.173.161) by 
 gonepostal.hostwizard.com with ESMTP (EIMS X
 3.3.9) for <git@vger.kernel.org>; Sun, 21 Mar 2010 15:59:45 -0700
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142871>

Hello Git users, 

I am 100% new to git.  Very new to any form of version control at all.  Unless you call keeping directories around, or rsync'd versions a version control system :)

I subscribed to this list yesterday, because the short description and some of the messages in the archives led me to believe that it was the correct place for beginner and intro questions regarding git usage.

I have seen there are a lot of patches, diffs, and what appear to be development related posts on this list.  Am I in the correct place?  If not, can someone point me in the right direction?

** - My question if appropriate - ** 
My needs are simple.  I do some scripting, some coding, web development etc.  I try my best to take what I have done and release it back out to the public.  This has become something that takes too much effort.

My general steps are
1) Create project, code, snippet, whatever
2) Write a read me, install notes, etc
3) Maintain a change log of some form
4) Deploy on my system, and other systems I am in control of

At that point, I have to make a decision.  Pack it all up, tar it, and put it online, perhaps on my website, or perhaps announce it on twitter, or a relevant mailing list.  Of I make a change, even a one character change, I have to update the distribution that is on my website.  There could be links to it I forgot about that would contain an older broken version.  It may also be a simple 30 line bash script, it may not even get a version number, it is a quick hack.

I am thinking github is going to be where I put all this stuff, but I am completely lost on where to even begin with all this.  I watched a few of the videos on the kernel.org website, and will continue with the git tutorials and documentation.

The second reason I came to this list is that I am a Mac user, and some of the tools I have created are resource fork dependent.  If they are ftp'd they will be broken.  Rsync is the only tool I know of that can accurately transfer the files without destroying them.  However, this requires a custom patched version of rsync, and must be equal on both ends.  I am not sure git hub is going to have that patch applied.  I may be getting into git hub specifics here, and going outside of the lists scope being focussed on git, if I am, plesae let me know and I can find a git hub resource.

I am just one person, with some rather small and hackish things that I am looking to put out there in case someone else has any interest in them.   I do not expect anyone to contribute to my work, or do anything other than *maybe* consume it.  I see a lot of people use SourceForge for this type of thing.  I wanted to try to get ahead of the curve and at least learn something that may help me down the road; git seemed to fit that bill.  At the very least, I can use it locally and just push my files around locally, keeping versions on my own machine in a way that I can step back if I screw up.

Suggestions, comments, and any general help are most appreciated.
Thanks everyone
-- 
Scott * If you contact me off list replace talklists@ with scott@ * 
