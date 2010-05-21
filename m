From: Andy Parkins <andyparkins@gmail.com>
Subject: [ot] Re: gitblogger
Date: Fri, 21 May 2010 09:57:57 +0100
Message-ID: <ht5huo$nd1$1@dough.gmane.org>
References: <ht3reo$b6i$1@dough.gmane.org> <AANLkTilpaRyrIgHN5eK_jRFJoukOSYlyEMwU1-LdGT0K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 10:58:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFO3d-0006Lw-FX
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 10:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831Ab0EUI6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 04:58:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:57708 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab0EUI6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 04:58:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OFO3U-0006II-0U
	for git@vger.kernel.org; Fri, 21 May 2010 10:58:08 +0200
Received: from 194.70.53.228 ([194.70.53.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 May 2010 10:58:08 +0200
Received: from andyparkins by 194.70.53.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 May 2010 10:58:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.228
User-Agent: KNode/4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147442>

Ping Yin wrote:

>> http://gitorious.org/git_blogger
>>
> 
> You may want to have a look at toto ( http://github.com/cloudhead/toto )
> git + github + herokou + markdown + txt store

Maybe I've misunderstood, but isn't this just a similar thing to ikiwiki?  I 
realise it's not a full wiki, but this toto still requires self-hosting of 
the blog?

I really wanted to be able to make someone else (Google) do the hosting for 
me, but still be able to use lovely txt + git.

The advantage (to me) of gitblogger was that it was simple: one post-receive 
hook, and only needed installing on the one central server.

(Regardless, my point was only to give some feedback and encouragement (and 
thanks) to the developers who add these features.  To show that their work 
is being used and is appreciated.  gitblogger is just a script I wrote for 
me, and published in case it was useful to someone else)



Andy

-- 
Dr Andy Parkins
andyparkins@gmail.com
