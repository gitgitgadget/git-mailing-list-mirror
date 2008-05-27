From: Joshua Haberman <joshua@reverberate.org>
Subject: Re: visualizing Git's Git repo
Date: Tue, 27 May 2008 20:36:16 +0000 (UTC)
Message-ID: <loom.20080527T202009-498@post.gmane.org>
References: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15v6-00081I-Lq
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108AbYE0Ug0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758105AbYE0Ug0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:36:26 -0400
Received: from main.gmane.org ([80.91.229.2]:43221 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757972AbYE0Ug0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:36:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K15uC-0000e9-L4
	for git@vger.kernel.org; Tue, 27 May 2008 20:36:24 +0000
Received: from 206-169-226-162.static.twtelecom.net ([206.169.226.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 May 2008 20:36:24 +0000
Received: from joshua by 206-169-226-162.static.twtelecom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 May 2008 20:36:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 206.169.226.162 (Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9) Gecko/2008051202 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83044>

Joshua Haberman <joshua <at> reverberate.org> writes:
> 1. what do you all do to get a high-level view of what's going on with  
> Git development?  do you use gitk?  if so, what options?

I get the impression from this thread that core Git developers don't make
visualizing the repository a regular part of their development workflow.  Is
that accurate?  What do you all do to keep tabs on Git development?

> 2. as a project, why don't you rebase when merging long-running  
> branches into master?

Is there really no rationale that anyone can offer for why you do things this
way?  I look to Git's own Git repo for best practices, and given Git's emphasis
on "history hygiene" I'm certain that there are reasons for why you do things
the way you do.

Josh
