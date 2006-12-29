From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 29 Dec 2006 19:06:54 +0100
Organization: At home
Message-ID: <en3la8$5t7$1@sea.gmane.org>
References: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Dec 29 19:04:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0M5b-0004sb-VC
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 19:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWL2SEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 13:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWL2SEH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 13:04:07 -0500
Received: from main.gmane.org ([80.91.229.2]:41378 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965074AbWL2SEG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 13:04:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H0M5K-0008Mn-12
	for git@vger.kernel.org; Fri, 29 Dec 2006 19:04:02 +0100
Received: from host-81-190-24-56.torun.mm.pl ([81.190.24.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Dec 2006 19:04:02 +0100
Received: from jnareb by host-81-190-24-56.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Dec 2006 19:04:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-56.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35599>

Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 28 Dec 2006, Junio C Hamano wrote:
> 
>> * jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
>>  + git-merge: preserve and merge local changes when doing fast
>>    forward
> 
> I'd like this, but behind a command line switch. And in addition to saying 
> "cannot merge, blabla needs update", git could spit out "if you want to 
> risk a 3way merge, go ahead and add the --preserve-local flag to 
> git-merge".
> 
> Comments?

Good idea.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
