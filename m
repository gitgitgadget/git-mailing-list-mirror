From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Sat, 03 Jun 2006 17:33:30 +0200
Organization: At home
Message-ID: <e5sa47$qv8$1@sea.gmane.org>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com> <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net> <20060603151240.GA4024@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jun 03 17:34:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmY8P-0007xu-Mw
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 17:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWFCPdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 11:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWFCPdv
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 11:33:51 -0400
Received: from main.gmane.org ([80.91.229.2]:45787 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751697AbWFCPdu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 11:33:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FmY8D-0007wc-96
	for git@vger.kernel.org; Sat, 03 Jun 2006 17:33:41 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jun 2006 17:33:41 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jun 2006 17:33:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21197>

Jonas Fonseca wrote:

> I already took your hint from the other day on irc and have begun on
> implementing this revision graph visualization for tig. :)
> 
> The problem is of course to come up with some ascii-art which is both
> readable and dense. Below is my mockup of something not using line
> graphics,[...]

As I can see you use 'vertical' layout. Do I understand correctly that '*'
refers to commit on marked (by column) branch, and '|' means pass-thru?

BTW. you might want to take a look at http://revctrl.org/ diagrams;
AFAICT all the git documentation uses 'horizontal' layout, which is good
for example but perhaps not for long-lived development...

-- 
Jakub Narebski
Warsaw, Poland
