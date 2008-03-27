From: Joe Fiorini <joe@faithfulgeek.org>
Subject: git-svn merging into branch?
Date: Thu, 27 Mar 2008 13:30:14 -0400
Message-ID: <AF82B803-0999-4C9F-95EE-184E829F2569@faithfulgeek.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 18:33:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jevy2-0004rJ-BN
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 18:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbYC0RcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 13:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYC0RcD
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 13:32:03 -0400
Received: from mail-out2.fuse.net ([216.68.8.171]:53744 "EHLO
	mail-out2.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbYC0RcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 13:32:00 -0400
X-CNFS-Analysis: v=1.0 c=1 a=iKmq7lysAAAA:8 a=XCqsXJLxntG6PhXZankA:9 a=fjB9WvDhYPA1RLSlahrVXg4sXvoA:4 a=oH_WKSxD8ioA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout2 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:55517] helo=[192.168.1.33])
	by mail-out2.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id 36/60-05263-6A9DBE74 for <git@vger.kernel.org>; Thu, 27 Mar 2008 13:30:14 -0400
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78357>

My company uses Subversion for their SCM.  I'd like to start using git  
on my dev box to eventually show how useful it is.  We're working on a  
new deploy process that involves merging changes into an svn branch.   
I have a feeling this will be accomplished much more easily with Git,  
however I also know our team will not take kindly to switching SCM  
products at the moment.  I couldn't find this in the documentation,  
but is is possible to use git-svn to merge changes from a git  
repository into a particular Subversion branch?

Thanks all!
Joe Fiorini
http://www.faithfulgeek.org // agile web development
