From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 06 Feb 2007 20:58:35 +0100
Organization: At home
Message-ID: <eqamic$7es$1@sea.gmane.org>
References: <87odognuhl.wl%cworth@cworth.org> <87y7nbdeaw.wl%cworth@cworth.org> <7vveifkczt.fsf@assigned-by-dhcp.cox.net> <87wt2vce31.wl%cworth@cworth.org> <7vwt2vgkuc.fsf@assigned-by-dhcp.cox.net> <87sldjcbxt.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 20:58:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEWS0-0004MQ-1n
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 20:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbXBFT5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965395AbXBFT5c
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 14:57:32 -0500
Received: from main.gmane.org ([80.91.229.2]:55253 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965389AbXBFT53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 14:57:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEWRD-0006Fm-89
	for git@vger.kernel.org; Tue, 06 Feb 2007 20:57:11 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 20:57:11 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 20:57:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38871>

Carl Worth wrote:

> On Tue, 06 Feb 2007 11:14:03 -0800, Junio C Hamano wrote:
>> If you tell your users to --use-separate-remote in the "git
>> clone" instruction, would that solve your backward compatibility
>> problem?
> 
> Ah, yes. That should actually do the trick.

Actually git has this option removed (at least from docs; perhaps it is
simply no-op).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
