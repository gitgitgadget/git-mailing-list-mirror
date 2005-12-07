From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: dotfile support
Date: Wed, 7 Dec 2005 10:19:24 -0800
Message-ID: <20051207181924.GA21343@tumblerings.org>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com> <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org> <42620092.9040402@dwheeler.com> <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org> <42628D1B.3000207@dwheeler.com> <20051207145646.GA9207@tumblerings.org> <7vacfcu7jy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 19:24:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek3tE-0006XJ-Ja
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 19:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbVLGST0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 13:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbVLGST0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 13:19:26 -0500
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:45780 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1751693AbVLGSTZ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 13:19:25 -0500
Received: from zbrown by tumblerings.org with local (Exim 4.54)
	id 1Ek3sy-0008AK-FC; Wed, 07 Dec 2005 10:19:24 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacfcu7jy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13336>

On Wed, Dec 07, 2005 at 09:43:29AM -0800, Junio C Hamano wrote:
> Zack Brown <zbrown@tumblerings.org> writes:
> 
> > What's the status of dotfile support? I can only find one thread that really
> > discusses the issue:
> >...
> > So that's my pitch: Leaving out dotfile support seems like it creates an
> > unnecessary limitation that eliminates some valid uses of git.
> 
> Valid argument, and resolved thusly quite some time ago, with
> commit 320d3a1b1aa04d75f0aaff3cc7cf582e144a84c6 on May 24th
> 2005.
> 
> You probably have missed it because unfortunately this commit
> happened after the latest issue of git traffic ;-).

Actually I've started including summaries of git list threads in Kernel Traffic
as well, for the past few issues. :)

Be well,
Zack

> 

-- 
Zack Brown
