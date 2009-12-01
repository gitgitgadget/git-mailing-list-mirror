From: Mikko Oksalahti <mikko@azila.fi>
Subject: Re: Newbie
Date: Tue, 1 Dec 2009 12:00:22 +0000 (UTC)
Message-ID: <loom.20091201T125555-549@post.gmane.org>
References: <loom.20091201T101313-496@post.gmane.org> <26ae428a0912010145k61dbfc41l8243363493918445@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 13:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFRPa-0008OF-UT
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 13:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbZLAMAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 07:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbZLAMAn
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 07:00:43 -0500
Received: from lo.gmane.org ([80.91.229.12]:55826 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbZLAMAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 07:00:42 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFRPU-0008LB-FC
	for git@vger.kernel.org; Tue, 01 Dec 2009 13:00:48 +0100
Received: from xdsl-238-224.nebulazone.fi ([83.145.238.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 13:00:48 +0100
Received: from mikko by xdsl-238-224.nebulazone.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 13:00:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.145.238.224 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.33 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134199>

Howard Miller <howardsmiller <at> googlemail.com> writes:

> 
> 2009/12/1 Mikko Oksalahti <mikko <at> azila.fi>:
> > How do I now get the accidentally deleted files back from the repository 
without
> > losing local changes made to 10 files?
> 
> 'git status' should show you what files you have deleted.  'git
> checkout filename' should get them back. I can't think of a way of
> recovering every file you have just deleted although - I suspect it
> might be tricky. Thinks like 'git pull' only apply to remote
> repositories and you don't have one of those. 
> 
> Howard
> 

Ok. That helps. I just assumed the 'git pull' would work same way on local and 
remote repositories but I guess not then...

> ....You're not thinking of it the right way (yet) 

I hate when you say that :P

  /Mikko
