From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Mar 2007 11:59:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703251156530.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
 <7v7itx5mep.fsf@assigned-by-dhcp.cox.net> <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
 <7vk5x54snc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVPVV-0003zV-Td
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 11:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbXCYJ7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 05:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbXCYJ7G
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 05:59:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:47030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751216AbXCYJ7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 05:59:05 -0400
Received: (qmail invoked by alias); 25 Mar 2007 09:59:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 25 Mar 2007 11:59:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SZSIryCgSYfhqs70Z1q1PgRaB7IvjfjibQab0Ob
	EGtBmL6uGi1M5E
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk5x54snc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43051>

Hi,

On Sun, 25 Mar 2007, Junio C Hamano wrote:

> * jc/fpl (Tue Mar 13 01:57:22 2007 -0700) 1 commit
>  + git-log --first-parent: show only the first parent log
> 
> This makes viewing topic-heavy style of project history pleasant, at 
> least in my opinion.  With a bit of cheering up, I'd merge it to 
> 'master', as it has been cooking in 'next' without causing problems, and 
> is of low-impact kind.  But it can wait until 1.5.1 is done.

*lol* I just tried it on 'next'...

But I agree that it is ready to be merged, and that it is useful.

Ciao,
Dscho
