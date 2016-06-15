From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: two-way sync; from firewalled host
Date: Sat, 03 Feb 2007 10:14:47 +0100
Organization: At home
Message-ID: <eq1jnj$rtv$2@sea.gmane.org>
References: <f36b08ee0701250331u10c6a608qcbbb3001a0481e@mail.gmail.com> <eprjep$dnm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 10:14:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDGyJ-0008M1-WF
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 10:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946403AbXBCJN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 04:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946413AbXBCJN6
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 04:13:58 -0500
Received: from main.gmane.org ([80.91.229.2]:41729 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946403AbXBCJN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 04:13:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDGxi-0000Rv-SH
	for git@vger.kernel.org; Sat, 03 Feb 2007 10:13:34 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 10:13:34 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 10:13:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38557>

[Cc: git@vger.kernel.org]

Jakub Narebski wrote:

> Yakov Lerner wrote:
> 
>> I have two hosts, host C which is firewalled (no sshd),
>> and host S which has sshd and is not firewalled. Both have
>> clone of the same repo, modified locally and differently on both hosts.
>> 
>> I need to two-way sync them by running commands on C (the firewalled one).
> 
> You can on host C pull from host S, and on host C push to host S.

See post by Junio explaining how to setup this:
    
  Message-ID: <7vfy9ndiqp.fsf@assigned-by-dhcp.cox.net>
  http://permalink.gmane.org/gmane.comp.version-control.git/38549

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
