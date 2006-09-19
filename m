From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 23:58:42 +0200
Organization: At home
Message-ID: <eepp4s$rm9$1@sea.gmane.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <20060919211844.GB8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 19 23:58:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnbv-0000hL-Un
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWISV6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWISV6c
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:58:32 -0400
Received: from main.gmane.org ([80.91.229.2]:63905 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751131AbWISV6b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 17:58:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPnbT-0000b0-6g
	for git@vger.kernel.org; Tue, 19 Sep 2006 23:58:07 +0200
Received: from host-81-190-31-133.torun.mm.pl ([81.190.31.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 23:58:07 +0200
Received: from jnareb by host-81-190-31-133.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 23:58:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-133.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27292>

Petr Baudis wrote:
 
> We already have support for recording something similar, it's called a
> revlog. You would just need to modify it to aggregate all the branches
> in a single file.

_reflog_, not revlog.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
