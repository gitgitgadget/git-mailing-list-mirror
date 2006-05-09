From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 08 May 2006 18:05:39 -0700
Message-ID: <7v64kgc8ik.fsf@assigned-by-dhcp.cox.net>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	<7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	<1147131877.2694.37.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	<1147134522.2694.45.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0605081742330.3718@g5.osdl.org>
	<1147136467.2694.53.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:05:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGfX-0000AY-EA
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWEIBFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWEIBFl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:05:41 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4298 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751261AbWEIBFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 21:05:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509010540.LZZE17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 21:05:40 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1147136467.2694.53.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Tue, 09 May 2006 02:01:07 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19801>

David Woodhouse <dwmw2@infradead.org> writes:

> Having 'git-show --pretty=email' would be nice. I think Junio is working
> on something which will achieve that, right?

That's the replacement of "git format-patch".  If you have a
chance, please try out what's in "next".  Johannes did quite a
nice enhancements.
