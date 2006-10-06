From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Remove redundant "commit" link from shortlog
Date: Fri, 06 Oct 2006 17:08:43 +0200
Organization: At home
Message-ID: <eg5rgf$58c$2@sea.gmane.org>
References: <20060928234840.25950.qmail@web31809.mail.mud.yahoo.com> <20061006135508.GO20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 06 17:11:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVrLy-0005Ww-FJ
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 17:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWJFPK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 11:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWJFPK5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 11:10:57 -0400
Received: from main.gmane.org ([80.91.229.2]:14745 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750772AbWJFPK4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 11:10:56 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GVrKt-0005Gs-9F
	for git@vger.kernel.org; Fri, 06 Oct 2006 17:10:03 +0200
Received: from host-81-190-18-48.torun.mm.pl ([81.190.18.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 17:10:03 +0200
Received: from jnareb by host-81-190-18-48.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 17:10:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-48.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28406>

Petr Baudis wrote:

> Dear diary, on Fri, Sep 29, 2006 at 01:48:40AM CEST, I got a letter
> where Luben Tuikov <ltuikov@yahoo.com> said that...
>> Remove the redundant "commit" link from shortlog.
>> It can be had by simply clicking on the entry title
>> of the row.
>> 
>> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> 
> And what if the commit message is empty?
> 
> Witness at http://repo.or.cz/?p=test;a=summary

By the way, commitdiff view in this case also looks strange.
I think that simplyfying the git_difftree_body went too far,
Luben.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
