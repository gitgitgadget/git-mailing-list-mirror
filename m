From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sat, 03 Nov 2007 23:02:16 +0100
Organization: At home
Message-ID: <fgir54$7ft$1@ger.gmane.org>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home> <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org> <alpine.LFD.0.9999.0711031627000.21255@xanadu.home> <20071103204000.GA24959@glandium.org> <alpine.LFD.0.9999.0711031645350.21255@xanadu.home> <20071103210321.GA25685@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 23:02:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoR4h-0004Mp-El
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 23:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419AbXKCWCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 18:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756258AbXKCWCX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 18:02:23 -0400
Received: from main.gmane.org ([80.91.229.2]:34436 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756188AbXKCWCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 18:02:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IoR4N-00078G-NY
	for git@vger.kernel.org; Sat, 03 Nov 2007 22:02:19 +0000
Received: from abvk230.neoplus.adsl.tpnet.pl ([83.8.208.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 22:02:19 +0000
Received: from jnareb by abvk230.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 22:02:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvk230.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63318>

Mike Hommey wrote:

> On Sat, Nov 03, 2007 at 04:50:54PM -0400, Nicolas Pitre wrote:
>> [ heh, I knew someone would say something ]
>> 
>> Yes, to me, 1MB is 1024 KB.  Always been, until those idiotic hard disk 
>> manufacturers decided to redefine the common interpretation of what 
>> everyone else used to consider what a MB is just to boost their 
>> marketing claims.
> 
> How many grams in a kilogram ? How many meters in a kilometer ? How many
> joule in a kilojoule ? ... How many bytes in a kilobyte ? Oh wait...
> 
> And you know what ? It's not only a matter of hard disk manufacturers.
> 
> How fast is gigabit ethernet ? Yep, 1000000000 bits/s
> How big would people say a 44000000 bytes file is ? 44MB or 42MB ?
> And my favourite: How many bytes in a 1.44MB floppy disk ? 1474560, that
> is, 1.44 * 1024000.
> 
> Those who made this big mess are the ones who decided a KB was 1024
> bytes, not the others.

No, the problem is that in _computer science_ kB (or KB) was 1024 bytes,
and MB was 1024 kilobytes, because 1024 is a power of 2, and for example
naturally the memory which can be adressed comes as a power of 2.

Now in other parts of science k means 1000, and M means 1000000. To make
the computer sciences meaning of kB explicit SI introduced ki and Mi prefix.
And manufacturers claiming HDD size x GB in the SI meaning took part...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
