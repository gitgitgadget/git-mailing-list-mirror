From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 14:55:05 +0200
Message-ID: <E1G8GFd-00036i-6y@moooo.ath.cx>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net> <E1G8ArX-0006r2-6D@moooo.ath.cx> <E1G8CUz-0002KI-VW@moooo.ath.cx> <46a038f90608020231l37de81f0i5f14c7c264fc40bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 14:55:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8GFt-0004lX-JK
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 14:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWHBMzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 08:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWHBMzL
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 08:55:11 -0400
Received: from moooo.ath.cx ([85.116.203.178]:31945 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751127AbWHBMzJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 08:55:09 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90608020231l37de81f0i5f14c7c264fc40bd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24646>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 8/2/06, Matthias Lederhofer <matled@gmx.net> wrote:
> >Just another idea: add something like @@FOO@@ on a line of its own and
> 
> We kind-of had that in a few Perl scripts before, and it's a mighty
> pain to develop and debug from your git repo because it makes your
> checked-in code invalid.
> 
> You might want to see this patch:
> http://kernel.org/git/?p=git/git.git;a=commitdiff;h=e923effb43fa952f9cb72ffe4c3625fce7655bff;hp=ced9456a27197fc038fbc5b5ebad87e55f1920d2
Perhaps # @@INSERT_YOUR_CODE_HERE@@?
