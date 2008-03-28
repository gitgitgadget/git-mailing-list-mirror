From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Re: git-svn merging into branch?
Date: Fri, 28 Mar 2008 02:32:45 -0400
Message-ID: <B3FD53D6-CB70-4D21-ACE2-7B9D4B19F675@faithfulgeek.org>
References: <AF82B803-0999-4C9F-95EE-184E829F2569@faithfulgeek.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 07:35:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf8BK-000257-7E
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 07:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbYC1Geh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 02:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbYC1Geh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 02:34:37 -0400
Received: from mail-out2.fuse.net ([216.68.8.171]:56869 "EHLO
	mail-out2.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbYC1Geg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 02:34:36 -0400
X-CNFS-Analysis: v=1.0 c=1 a=iKmq7lysAAAA:8 a=VwQbUJbxAAAA:8 a=rJQfuLcY7EeqBxPc1xcA:9 a=2aB1P97WX64THWQsvakA:7 a=XNbqDn_q4cApP40r0x4K7FZN9ecA:4 a=CWfAmLVWKswA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout2 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:58573] helo=[192.168.1.33])
	by mail-out2.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id B3/7E-05263-D019CE74 for <joe@faithfulgeek.org>; Fri, 28 Mar 2008 02:32:51 -0400
In-Reply-To: <AF82B803-0999-4C9F-95EE-184E829F2569@faithfulgeek.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78390>

I'll take that as a no? :-)

-Joe

On Mar 27, 2008, at 1:30 PM, Joe Fiorini wrote:

> My company uses Subversion for their SCM.  I'd like to start using  
> git on my dev box to eventually show how useful it is.  We're  
> working on a new deploy process that involves merging changes into  
> an svn branch.  I have a feeling this will be accomplished much more  
> easily with Git, however I also know our team will not take kindly  
> to switching SCM products at the moment.  I couldn't find this in  
> the documentation, but is is possible to use git-svn to merge  
> changes from a git repository into a particular Subversion branch?
>
> Thanks all!
> Joe Fiorini
> http://www.faithfulgeek.org // agile web development
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
