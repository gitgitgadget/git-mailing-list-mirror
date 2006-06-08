From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Some doc typo fixes
Date: Thu, 08 Jun 2006 09:22:57 +0200
Message-ID: <4487D051.6020802@op5.se>
References: <20060607125644.GT29682@craic.sysops.org> <7v1wu0lxnd.fsf@assigned-by-dhcp.cox.net> <7vwtbshp3d.fsf@assigned-by-dhcp.cox.net> <20060607174614.GU29682@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 09:23:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoEr8-00079X-G1
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 09:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWFHHW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 03:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWFHHW7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 03:22:59 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:30340 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932493AbWFHHW6
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 03:22:58 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 720C16BCC0; Thu,  8 Jun 2006 09:22:57 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Francis Daly <francis@daoine.org>
In-Reply-To: <20060607174614.GU29682@craic.sysops.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21473>

Francis Daly wrote:
> On Wed, Jun 07, 2006 at 10:07:02AM -0700, Junio C Hamano wrote:
> 
>>Junio C Hamano <junkio@cox.net> writes:
>>
>>>Francis Daly <francis@daoine.org> writes:
> 
> 
>>>Thanks.  I am not a native, and this is very much appreciated.
> 
> 
> You're welcome.
> 
> 
>>>> . It could be named hierarchically (i.e. separated with slash
>>>>-  `/`), but each of its component cannot begin with a dot `.`;
>>>>+  `/`), but each of its components cannot begin with a dot `.`;
>>>
>>>I am not sure; ...
>>
>>Sheesh, I was reading the diff backwards.  Sorry.
> 
> 
> No worries.  I had a head-scratching moment, and suspect that the whole
> stanza could be better phrased.  If only there was someone who didn't
> already know what it means, they could suggest which phrasing makes
> it clear...
> 
> How about rewriting it as
> 
> It can include slash `/` for hierarchical (directory) grouping, but no
> slash-separated component can begin with a dot `.`;
> 
> ?
> 

I like it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
