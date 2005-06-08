From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.11.2
Date: Thu, 09 Jun 2005 01:35:03 +0200
Message-ID: <42A780A7.3060608@gmail.com>
References: <20050608230725.GR982@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgA33-0005YN-3d
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 01:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVFHXhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 19:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVFHXhN
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 19:37:13 -0400
Received: from main.gmane.org ([80.91.229.2]:65253 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261540AbVFHXg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 19:36:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DgA16-0005Lj-M2
	for git@vger.kernel.org; Thu, 09 Jun 2005 01:31:24 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 01:31:24 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 01:31:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81-224-201-139-no45.tbcn.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050608230725.GR982@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
>   Here's git-rev-list --pretty HEAD ^cogito-0.11.1 | git-shortlog
> (BTW, Dan, what about another cg-log option for git-shortlog output? ;-):

Well, since I try to use the same output format as git-rev-list --pretty 
does (most of the time, it *is* just that...), I can actually already do

    cg-log -r:cogito-0.11.1 | git-shortlog

and get the same thing.

/dan

