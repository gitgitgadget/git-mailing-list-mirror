From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: How do I...
Date: Fri, 06 May 2005 17:36:07 +0100
Message-ID: <1115397368.16187.266.camel@hades.cambridge.redhat.com>
References: <427B3DB3.4000507@tuxrocks.com>
	 <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:34:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5kh-0005dd-3c
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVEFQi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVEFQiV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:38:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31624 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261224AbVEFQgO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 12:36:14 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DU5o9-00019n-Ai; Fri, 06 May 2005 17:36:10 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 09:13 -0700, Linus Torvalds wrote:
> There has been at least two different scripts for this posted, and one C 
> source code version.
> 
> I just haven't integrated them, because I'm an idiot, and too much choice 
> makes me run around in small circles and clucking.
> 
> Guys - whoever wrote one of the scripts, can you please send out your 
> current version to the git list and cc me, and explain why yours is 
> superior to the other peoples version. Please?

I already explained why mine sucks and shouldn't be merged. It was a
proof of concept; hoping for the stone soup effect.

I haven't seen a C version or indeed anything which actually does the
right thing, although I outlined how it would work and _threatened_ to
do one. I had a half-arsed attempt at it on the way home from
linux.conf.au but my brain tends to melt while I'm on airplanes so I
didn't get very far.

-- 
dwmw2

