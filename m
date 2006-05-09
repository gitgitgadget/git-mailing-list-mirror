From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 09 May 2006 02:01:07 +0100
Message-ID: <1147136467.2694.53.camel@shinybook.infradead.org>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	 <1147131877.2694.37.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	 <1147134522.2694.45.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0605081742330.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:01:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGbQ-0007sD-3S
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWEIBBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWEIBBZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:01:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49601 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751188AbWEIBBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 21:01:25 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1FdGbJ-0007tQ-E9; Tue, 09 May 2006 02:01:21 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605081742330.3718@g5.osdl.org>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19798>

On Mon, 2006-05-08 at 17:45 -0700, Linus Torvalds wrote:
> As long as the "commit <sha1>" id is there (and "--pretty=fuller" does 
> have it), I'll be happy.

Ah, right. Those are _commit_ IDs in that strange first line. I'll
reformat those to 'Commit:' and 'Parent:' for the mailing list.

Having 'git-show --pretty=email' would be nice. I think Junio is working
on something which will achieve that, right?

>  At some point, the commit mailing list didn't 
> actually mention the commit ID itself, just the tree/parent IDs.

Yeah, I know -- and I got complaints :)

-- 
dwmw2
