From: Paul Dickson <paul@permanentmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.16.1
Date: Mon, 12 Dec 2005 18:26:36 -0700
Message-ID: <20051212182636.d3b73900.paul@permanentmail.com>
References: <20051212011210.GC12373@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Dec 13 02:27:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElywW-0000ty-50
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVLMB0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVLMB0n
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:26:43 -0500
Received: from vds.fauxbox.com ([208.210.124.75]:60593 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1750766AbVLMB0n (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 20:26:43 -0500
Received: from thorn (localhost [127.0.0.1])
	by thorn.pobox.com (Postfix) with ESMTP id 375A411F
	for <git@vger.kernel.org>; Mon, 12 Dec 2005 20:27:00 -0500 (EST)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by thorn.sasl.smtp.pobox.com (Postfix) with ESMTP id D976D520E
	for <git@vger.kernel.org>; Mon, 12 Dec 2005 20:26:59 -0500 (EST)
Received: from white.pwd.internal ([192.168.1.9])
	by red.pwd.internal (8.13.5/8.13.4) with SMTP id jBD1Qaw9013267
	for <git@vger.kernel.org>; Mon, 12 Dec 2005 18:26:36 -0700
To: git@vger.kernel.org
In-Reply-To: <20051212011210.GC12373@pasky.or.cz>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.8; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13557>

On Mon, 12 Dec 2005 02:12:10 +0100, Petr Baudis wrote:

>   this is Cogito version 0.16.1, the next stable release of the
> human-friendly version control UI for the Linus' GIT tool.

Can the -help argument be supported too?  It's pretty annoying to end up
typing -help and having that used as a tag or commit.

Any chance of man files?  I'm more use to type man than cg-help.

How about giving instructions in the edited commit message about how to
abort the commit.  I've figured out you can just delete all the
referenced files, but this was just by accident. (0.15.1)  I had my emacs
segfault and that commit was performed too.

Any chance a creating a very simple cg-mv?  Having to switch is a lower
level (git) to perform this function takes time (verifying the
functionality).

Is there a cogito equivalent of "git-branch foo"?  It seems cg-branch-add
does everything but that.

	-Paul
	Using git/cogito for 9 days.
