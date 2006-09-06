From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GitWiki lost ability to parse macros
Date: Wed, 06 Sep 2006 19:18:37 +0200
Organization: At home
Message-ID: <edmvsn$lt7$3@sea.gmane.org>
References: <edm7h3$nij$1@sea.gmane.org> <20060906113052.GC23891@pasky.or.cz> <edmcd6$9or$1@sea.gmane.org> <Pine.LNX.4.64.0609061712410.7168@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 06 19:19:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL136-0005A3-KU
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 19:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWIFRSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 13:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWIFRSt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 13:18:49 -0400
Received: from main.gmane.org ([80.91.229.2]:38336 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751752AbWIFRSs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 13:18:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GL12m-000567-Lv
	for git@vger.kernel.org; Wed, 06 Sep 2006 19:18:33 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 19:18:32 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 19:18:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26543>

Julian Phillips wrote:

> On Wed, 6 Sep 2006, Jakub Narebski wrote:
> 
>> Hmm... I still get for http://git.or.cz/gitwiki/RecentChanges
>>
>> {{RandomQuote()}}
>>
>> {{RecentChanges}}
>>
>>
> 
> MoinMoin caches a copy of the generated html page, which is automatically 
> updated when you edit the page.  Since fixing the macros doesn't mean 
> updating the page you have to manually delete the cache - this can be done 
> from the "More Actions:" list.

Could admin of GitWiki then delete cache of all files?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
