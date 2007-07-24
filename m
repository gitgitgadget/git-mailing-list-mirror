From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Tue, 24 Jul 2007 12:16:09 +0200
Organization: At home
Message-ID: <f84jh8$e27$2@sea.gmane.org>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com> <Pine.LNX.4.64.0707222013200.14781@racer.site> <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com> <Pine.LNX.4.64.0707222238180.14781@racer.site> <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com> <Pine.LNX.4.64.0707230048570.14781@racer.site> <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com> <Pine.LNX.4.64.0707230136360.14781@racer.site> <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com> <Pine.LNX.4.64.0707231933030.14781@racer.site> <9e4733910707231743w759afabfvd43045ad2e2eba5a@mail.gmail.com> <Pine.LNX.4.64.0707240214500.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 12:16:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHRF-0000tR-5b
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762386AbXGXKQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759451AbXGXKQS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:16:18 -0400
Received: from main.gmane.org ([80.91.229.2]:59024 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761947AbXGXKQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:16:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IDHR9-0000bi-Cf
	for git@vger.kernel.org; Tue, 24 Jul 2007 12:16:15 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 12:16:15 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 12:16:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53554>

[Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org]

Johannes Schindelin wrote:

> On Mon, 23 Jul 2007, Jon Smirl wrote:
> 
>> Thanks for working on this. I'd like to see it added to git toolkit. 
> 
> I plan to submit it to patchutils instead, since this is not really 
> dependent on git.

Could you also add it to contrib/ area, please?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
