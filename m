From: Tim <timothyjwashington@yahoo.ca>
Subject: "Not currently on any branch"
Date: Fri, 2 Oct 2009 20:08:52 +0000 (UTC)
Message-ID: <loom.20091002T215942-663@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 22:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtocu-0003Lg-8o
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 22:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131AbZJBUUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756969AbZJBUUF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 16:20:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:50495 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758131AbZJBUUD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 16:20:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mtobl-0002zP-PU
	for git@vger.kernel.org; Fri, 02 Oct 2009 22:20:05 +0200
Received: from CPE001601277554-CM0014f8c5a80e.cpe.net.cable.rogers.com ([173.33.212.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 22:20:05 +0200
Received: from timothyjwashington by CPE001601277554-CM0014f8c5a80e.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 22:20:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.33.212.254 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129458>

I have some code in a git repo that is "Not currently on any branch". Now,
there's the master branch and another branch 'ui-integration' that I'm using in
this project. I don't know how the project got into this headless state, but I
need to be using the 'ui-integration' branch. 

I tried looking around the blogosphere for a solution, and tried what I found
here. But it seems like only my last commit (not the previous 10 I made) shows
up in the master branch (not ui-integration ).  
http://blog.kortina.net/post/71935540/fix-git-not-currently-on-any-branch-problem

What's the most straightforward & cleanest way to merge my changes in the
headless branch to my 'ui-integration' branch? 

Thanks in advance
Tim
