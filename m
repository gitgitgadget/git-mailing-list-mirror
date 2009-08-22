From: Thell Fowler <git@tbfowler.name>
Subject: Re: What's a good setup for submitting patches to the list
 properly?
Date: Sat, 22 Aug 2009 10:01:22 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908220953460.2012@GWPortableVCS>
References: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 17:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mes6T-0000km-Ea
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 17:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbZHVPBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 11:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755354AbZHVPBr
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 11:01:47 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:34587 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbZHVPBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 11:01:47 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mes6G-0008V5-7A
	for git@vger.kernel.org; Sat, 22 Aug 2009 10:01:48 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126811>

Thell Fowler (git@tbfowler.name) wrote on Aug 19, 2009:

> I haven't been able to figure out a good setup for posting patches to the 
> list correctly, perhaps someone could tell me where I'm going wrong.
> 
> Alpine is setup to access git @ tbfowler.name with the 'postpone' folder 
> being the 'Drafts' folder on the remote mail host, and a local mbox folder 
> ~/mail/git
> 
> Locally I prepped the emails using:
> 
> git format-patch --cover-letter --full-index -n 
> --in-reply-to=1249428804.2774.52.camel@GWPortableVCS --thread --signoff -6 
> --stdout>>~/mail/git
> 

Did I miss something with that command?

> http://article.gmane.org/gmane.comp.version-control.git/124834
> 
> Thinking that the cover letter would be in reply to a previous thread, and 
> that the rest would show as a reply to that.  After doing the 
> format-patch, I went into Alpine's git folder selected the messages and 
> saved them to the Drafts folder, then did 'compose' for each one, filling 
> in the information I thought was needed.
> 

Perhaps the saving to a new folder could've messed something up with the 
headers?

[snip]
> What could I have done/checked before sending to make sure that these 
> would have posted properly?

No input on this?  Perhaps I should've posted to the git user or alpine 
lists?

Either way, I'll be sending a new version of the patch I've been working 
on and rather than have them show as top posts again I'd rather do it 
correctly.

Or perhaps there is an easier more direct route...

-- 
Thell
