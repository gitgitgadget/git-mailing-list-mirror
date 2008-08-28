From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 22:57:12 +0200
Message-ID: <48B71128.8040400@s5r6.in-berlin.de>
References: <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu> <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com> <20080827230903.GB11005@flint.arm.linux.org.uk> <48B5E90E.3000601@s5r6.in-berlin.de> <20080828191956.GA7906@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	=?ISO-8859-1?Q?Kristian_H=F8g?= =?ISO-8859-1?Q?sberg?= 
	<krh@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Jeff King <peff@peff.net>, Perry Wagle <wagle@cs.indiana.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYoba-0002yl-Hj
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbYH1U7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757051AbYH1U7Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:59:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43101 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433AbYH1U7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:59:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] ([83.221.231.7])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m7SKvHca013487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 28 Aug 2008 22:57:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080722 SeaMonkey/1.1.11
In-Reply-To: <20080828191956.GA7906@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.95.6
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94146>

Russell King wrote:
> On Thu, Aug 28, 2008 at 01:53:50AM +0200, Stefan Richter wrote:
>> "-" -> " "?  Molehill.
> 
> "ls" -> "listfiles" - how would you feel about that change happening
> behind your back?

I would feel betrayed, then add another alias to .bashrc, then feel 
deeply satisfied by my cunning betrayal of the betrayers, knowing that 
only a true genius hacker could come up with a countermeasure like that.
-- 
Stefan Richter
-=====-==--- =--- ===--
http://arcgraph.de/sr/
