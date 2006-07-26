From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 11:58:36 -0700
Message-ID: <7vejw8ry5f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
	<7virlkrzr4.fsf@assigned-by-dhcp.cox.net>
	<9e4733910607261131q195defa7vbedd72cb0b938ba3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 20:58:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5oaf-0003an-9C
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 20:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWGZS6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 14:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWGZS6i
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 14:58:38 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49138 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750983AbWGZS6h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 14:58:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726185837.TFXI2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 14:58:37 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607261131q195defa7vbedd72cb0b938ba3@mail.gmail.com>
	(Jon Smirl's message of "Wed, 26 Jul 2006 14:31:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24237>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> git diff HEAD makes a much longer patch that deltas out the existing
> files and delta in the new file.
>
> It's applying patches in the extended git format that fails.

Thanks.
