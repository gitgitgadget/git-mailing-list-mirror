From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 14:05:42 -0700
Message-ID: <58E42279-D489-4356-9B4C-148A95F402E5@cs.indiana.edu>
References: <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu> <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com> <20080827230903.GB11005@flint.arm.linux.org.uk> <48B5E90E.3000601@s5r6.in-berlin.de> <20080828191956.GA7906@flint.arm.linux.org.uk> <48B71128.8040400@s5r6.in-berlin.de>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmk@arm.linux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYojo-0005Ci-S4
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbYH1VH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbYH1VH6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:07:58 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:54384 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbYH1VH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:07:58 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SL5qND004332;
	Thu, 28 Aug 2008 17:05:52 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SL5hY9008998
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 17:05:49 -0400
In-Reply-To: <48B71128.8040400@s5r6.in-berlin.de>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94156>


On Aug 28, 2008, at 1:57 PM, Stefan Richter wrote:

> Russell King wrote:
>> On Thu, Aug 28, 2008 at 01:53:50AM +0200, Stefan Richter wrote:
>>> "-" -> " "?  Molehill.
>> "ls" -> "listfiles" - how would you feel about that change happening
>> behind your back?
>
> I would feel betrayed, then add another alias to .bashrc, then feel  
> deeply satisfied by my cunning betrayal of the betrayers, knowing  
> that only a true genius hacker could come up with a countermeasure  
> like that.

When I started with VMS (ahem) years ago, my buddies handed me eunice  
(a unix like environment) and a big bag of aliases to make my  
environment look like unix.  I did this for years and was happy.

But one day I lost my command shell init scripts, and was left to fend  
for myself with pure VMS commands.  I was completely helpless.  Moral:  
never again will I customize my programming environment to that extent.

Your solution is that sort of over-customization.  Sticking git's  
libexec in your path is too.  I'm still allergic.

-- Perry

PS.  </offtopic>
