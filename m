From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git2rss --- publish changes from git-log via RSS
Date: Fri, 07 Jul 2006 20:38:11 +0200
Organization: At home
Message-ID: <e8m9m2$m37$1@sea.gmane.org>
References: <20060704191135.GB10534@rahul.net> <e8elej$4sa$1@sea.gmane.org> <20060706125328.GA19414@rahul.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jul 07 20:38:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyvDL-0000Zp-RN
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 20:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWGGSiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 14:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGGSiE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 14:38:04 -0400
Received: from main.gmane.org ([80.91.229.2]:18857 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751224AbWGGSiD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 14:38:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FyvDF-0000Yy-7P
	for git@vger.kernel.org; Fri, 07 Jul 2006 20:38:01 +0200
Received: from host-81-190-22-25.torun.mm.pl ([81.190.22.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 20:38:01 +0200
Received: from jnareb by host-81-190-22-25.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 20:38:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-25.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23451>

Bennett Todd wrote:

> 2006-07-04T21:09:32 Jakub Narebski:

>> BTW. gitweb includes RSS feed, see e.g.:
>>   http://www.kernel.org/git/?p=git/git.git;a=rss
>>   http://www.kernel.org/git/?p=git/git.git;a=opml
> 
> Can it be used for offline generation? I don't run any CGIs on my
> webserver, I re-generate bent.xml whenever I push any updates.

Just run it as a script. IIRC there is a way to pass CGI params
to a script...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
