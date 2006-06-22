From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 23:24:06 +0200
Organization: At home
Message-ID: <e7f1pk$l1q$1@sea.gmane.org>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> <20060622205859.GF21864@pasky.or.cz> <Pine.LNX.4.64.0606221402140.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 23:24:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtWfB-0005oo-F8
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 23:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWFVVY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 17:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161344AbWFVVY2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 17:24:28 -0400
Received: from main.gmane.org ([80.91.229.2]:15262 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1160999AbWFVVY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 17:24:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtWet-0005ma-25
	for git@vger.kernel.org; Thu, 22 Jun 2006 23:24:15 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 23:24:15 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 23:24:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22375>

Linus Torvalds wrote:

> 
> 
> On Thu, 22 Jun 2006, Petr Baudis wrote:
>> 
>> Isn't manually numbering the enum choices somewhat pointless, though?
>> (Actually makes it more difficult to do changes in it later.)
> 
> Yeah, I just mindlessly followed Johannes' original scheme. 

You might want to start at 0, just in case...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
