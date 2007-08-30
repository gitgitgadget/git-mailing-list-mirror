From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 18:54:42 +0200
Organization: At home
Message-ID: <fb6sof$6rt$1@sea.gmane.org>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com> <Pine.LNX.4.64.0708301415150.28586@racer.site> <550f9510708300810y1ca84e8dt4d0bab8fc99deb3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 18:55:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQnIc-0003w3-Bv
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 18:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXH3QzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 12:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbXH3QzH
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 12:55:07 -0400
Received: from main.gmane.org ([80.91.229.2]:32963 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091AbXH3QzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 12:55:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQnIE-0000jH-QN
	for git@vger.kernel.org; Thu, 30 Aug 2007 18:54:54 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 18:54:54 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 18:54:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57051>

Tom Clarke wrote:

> On 8/30/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

>> In my TODO, there is "add the 'rebase' strategy".  It is definitely
>> something post-1.5.3, so I do not look into it.  But the most logical
>> place for me would be to have a strategy 'rebase'.  IOW a
>> git-merge-rebase.sh.
> 
> The following is my first naive attempt, is this the kind of thing you
> were thinking of?

By the way, such strategy appeared some time ago on git mailing list IIRC as
'subjugate' (then renamed to 'rebase') merge strategy.

As with all good ideas (stash, submodules) the idea returns... :-)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
