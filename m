From: Junio C Hamano <junkio@cox.net>
Subject: Re: PATCH: simplify calls to git programs in git-fmt-merge-msg
Date: Thu, 23 Feb 2006 02:35:48 -0800
Message-ID: <7vslqaicqj.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0602230226j12e88682h303d466a273bec09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 11:36:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCDpR-0000fh-HO
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 11:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWBWKfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 05:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWBWKfv
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 05:35:51 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:30698 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751677AbWBWKfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 05:35:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060223103213.SMTL20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Feb 2006 05:32:13 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602230226j12e88682h303d466a273bec09@mail.gmail.com>
	(Alex Riesen's message of "Thu, 23 Feb 2006 11:26:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16640>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> It also makes it work on ActiveState Perl.
>
> ---

ActiveState or not, this simplification is pretty much welcomed.
The only problem I _might_ have later is with shortlog, though I
have not looked at it closely yet.

Thanks.
