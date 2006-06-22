From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: whitespace cleanup around '='
Date: Thu, 22 Jun 2006 11:52:53 +0200
Organization: At home
Message-ID: <e7dp9m$v48$1@sea.gmane.org>
References: <20060622023546.28cb4291.froese@gmx.de> <11509591773212-git-send-email-jnareb@gmail.com> <7vejxhwts4.fsf@assigned-by-dhcp.cox.net> <e7dh1c$61n$1@sea.gmane.org> <7vodwlsfek.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 11:53:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtLsS-0006DV-NU
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 11:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWFVJx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 05:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWFVJx2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 05:53:28 -0400
Received: from main.gmane.org ([80.91.229.2]:13536 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161022AbWFVJx1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 05:53:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtLsB-0006Ar-R1
	for git@vger.kernel.org; Thu, 22 Jun 2006 11:53:15 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 11:53:15 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 11:53:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22319>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:

>> I'm very sorry, I forgot that I applied Timo Hirvonen patch
>>
>>   "[PATCH] gitweb: Start search from HEAD"
>>   Message-ID: <20060620152515.23e59396.tihirvon@gmail.com>
> 
> But I think what you have is this one instead:
> 
> Message-ID: <20060620164105.7276a45f.tihirvon@gmail.com>

Is the 'note' extension to commit header implemented yet? It it is,then it
would be nice if git-am recorded original email message-ids in the note
header. Usually it is of no interest to user, so it should be hidden by
default.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
