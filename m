From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cogito remote branch
Date: Sat, 10 Nov 2007 12:52:39 +0100
Organization: At home
Message-ID: <fh4627$men$1@ger.gmane.org>
References: <1IqTj5-24rt3I0@fwd33.aul.t-online.de> <47345E85.8090702@op5.se> <1IqUGN-1XXOVs0@fwd33.aul.t-online.de> <Pine.LNX.4.64.0711091417060.4362@racer.site> <1IqWRW-0QQ4LA0@fwd26.aul.t-online.de> <1194625691.1471.3.camel@ld0161-tx32> <Pine.LNX.4.64.0711101217130.4330@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 12:53:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqouF-0007rN-Sl
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXKJLxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 06:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbXKJLxa
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:53:30 -0500
Received: from main.gmane.org ([80.91.229.2]:40055 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbXKJLx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 06:53:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iqotc-0001IM-1U
	for git@vger.kernel.org; Sat, 10 Nov 2007 11:53:04 +0000
Received: from abvi124.neoplus.adsl.tpnet.pl ([83.8.206.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 11:53:04 +0000
Received: from jnareb by abvi124.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 11:53:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvi124.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64335>

Michael Dressel wrote:
> On Fri, 9 Nov 2007, Jon Loeliger wrote: 
>> On Fri, 2007-11-09 at 10:10, MichaelTiloDressel@t-online.de wrote:
>>
>>>  There are just some features
>>> which simplify things for me in cogito. E.g. in cogito in the simplest
>>> way you don't need to be aware of the index. While with git
>>> you have to remember to add the changes to the index explicitly
>>> to get them committed. 
>> 
>> "git commit -a ..." might be useful for you.
>> 
>> Other lingering cogito-isms you think are lacking in git?
> 
> Thanks for the hint. I have to use git for a while to understand what may 
> still be lacking (at least for me, if at all). Off the top of my head one 
> other difference is that if I do a cg-push the remote (or origin) head is 
> updated automatically, I think.

If you mean that tracking branches are updated on push, this is what
git also does from some time (perhaps not in released version, so please
wait or run 'master').

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
