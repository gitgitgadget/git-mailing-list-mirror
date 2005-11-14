From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Bugfix: stop if directory already exists
Date: Mon, 14 Nov 2005 10:28:01 +0100
Message-ID: <437858A1.9010007@op5.se>
References: <200511131503.32078.Josef.Weidendorfer@gmx.de> <7vpsp3zjwm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 10:29:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbadE-0000r8-IV
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 10:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVKNJ2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 04:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVKNJ2F
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 04:28:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41408 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751038AbVKNJ2D
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 04:28:03 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 099CB6BCBE; Mon, 14 Nov 2005 10:28:02 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsp3zjwm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11779>

Junio C Hamano wrote:
> 
>> usage: git clone ...
>> For more details, see 'man git-clone'
> 
> 
> And "for more details see man" goes without saying.
> 

But we name them differently, as hpa pointed out some week ago.

When I see "usage: <prog> <command>" I expect to find the info in "man 
<prog>". Soon, this will work to get the right page

	git --help <command>

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
