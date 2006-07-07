From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] do not use locale specific strftime when preparing 2822 date
Date: Fri, 07 Jul 2006 22:01:34 +0200
Organization: At home
Message-ID: <e8meic$8ur$3@sea.gmane.org>
References: <7vlkr7bvc1.fsf@assigned-by-dhcp.cox.net> <1152298675925-git-send-email-jnareb@gmail.com> <7vzmflw7vd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jul 07 22:05:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FywZg-0008Ct-Sa
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 22:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWGGUFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 16:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWGGUFN
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 16:05:13 -0400
Received: from main.gmane.org ([80.91.229.2]:59521 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932305AbWGGUFL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 16:05:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FywZS-00088X-4g
	for git@vger.kernel.org; Fri, 07 Jul 2006 22:05:02 +0200
Received: from host-81-190-22-25.torun.mm.pl ([81.190.22.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 22:05:02 +0200
Received: from jnareb by host-81-190-22-25.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 22:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-25.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23466>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Signed-off-by: Junio C Hamano <junkio@cox.net>
>> Acked-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>> This patch is sent from patched version of git-send-email.perl
>> with git tools 1.3.0. This patch is generated from current master
>> after Junio's patch 
>>   Message-ID: <7vd5cnv1v5.fsf@assigned-by-dhcp.cox.net>
>> applied.
> 
> Good test.  Thanks.

By the way, patch didn't apply cleanly (some fuzz was used).
The patch I send was from _applied_ (to master) patch.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
