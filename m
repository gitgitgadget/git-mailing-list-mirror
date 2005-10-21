From: Ben Lau <benlau@ust.hk>
Subject: Re: How to create a new branch based on a tag?
Date: Sat, 22 Oct 2005 00:23:55 +0800
Message-ID: <4359161B.5000808@ust.hk>
References: <435901F7.9020509@ust.hk> <7vsluv5y0p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 06:25:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESoRV-0002Mh-VP
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 06:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVJUEX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 00:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVJUEX2
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 00:23:28 -0400
Received: from mx3.ust.hk ([143.89.13.11]:47631 "EHLO mx3.ust.hk")
	by vger.kernel.org with ESMTP id S964862AbVJUEX2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 00:23:28 -0400
Received: from [143.89.135.159] (atz113.rd.ust.hk [143.89.135.159])
	by mx3.ust.hk (8.12.11/8.12.11) with ESMTP id j9L4NJrS097160;
	Fri, 21 Oct 2005 12:23:20 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsluv5y0p.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10418>

Junio C Hamano wrote:

>Ben Lau <benlau@ust.hk> writes:
>
>  
>
>>As v2.6.11 is a tree object(tag), git-checkout and git-branch could 
>>not process it. The
>>only way I know is using git-read-tree to fetch v2.6.11 content into 
>>current index and start
>>a branch based on it. Is there any simpler method?
>>    
>>
>
>The way you know is as good as it gets.  v2.6.11-tree case is
>really an unfortunate special case.
>
>  
>
What is wrong with the v2.6.11-tree? I just thought it is a duplicate tag
of v2.6.11.
