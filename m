From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Thu, 10 Aug 2006 12:46:44 +0200
Organization: At home
Message-ID: <ebf2pu$8qv$1@sea.gmane.org>
References: <200608091257.19461.jnareb@gmail.com> <20060809192815.GA7954@c165.ib.student.liu.se> <7vk65h1t8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 10 12:46:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB83h-0002iq-Hw
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 12:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWHJKqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 06:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWHJKqe
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 06:46:34 -0400
Received: from main.gmane.org ([80.91.229.2]:64692 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161155AbWHJKqd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 06:46:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GB83X-0002hf-M3
	for git@vger.kernel.org; Thu, 10 Aug 2006 12:46:27 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 12:46:27 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 12:46:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25180>

Junio C Hamano wrote:

> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
>> I don't think it was dropped in favor --full-history.
> 
> Correct.
> 
> The --full-history option is about merge simplification and has
> nothing to do with renames.

By the way, --full-history option is not documented: neither in
Documentation/git-rev-list.txt, nor in git-rev-list --usage

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
