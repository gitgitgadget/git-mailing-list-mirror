From: Junio C Hamano <junkio@cox.net>
Subject: Re: dotfile support
Date: Wed, 07 Dec 2005 09:43:29 -0800
Message-ID: <7vacfcu7jy.fsf@assigned-by-dhcp.cox.net>
References: <20050416230058.GA10983@ucw.cz>
	<118833cc05041618017fb32a2@mail.gmail.com>
	<20050416183023.0b27b3a4.pj@sgi.com>
	<Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
	<42620092.9040402@dwheeler.com>
	<Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org>
	<42628D1B.3000207@dwheeler.com>
	<20051207145646.GA9207@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 18:48:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek3KJ-0000x0-ED
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 18:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVLGRnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 12:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVLGRnc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 12:43:32 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17548 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751428AbVLGRnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 12:43:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207174147.XRWZ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 12:41:47 -0500
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20051207145646.GA9207@tumblerings.org> (Zack Brown's message of
	"Wed, 7 Dec 2005 06:56:46 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13333>

Zack Brown <zbrown@tumblerings.org> writes:

> What's the status of dotfile support? I can only find one thread that really
> discusses the issue:
>...
> So that's my pitch: Leaving out dotfile support seems like it creates an
> unnecessary limitation that eliminates some valid uses of git.

Valid argument, and resolved thusly quite some time ago, with
commit 320d3a1b1aa04d75f0aaff3cc7cf582e144a84c6 on May 24th
2005.

You probably have missed it because unfortunately this commit
happened after the latest issue of git traffic ;-).
