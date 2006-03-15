From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Let merge set the default strategy.
Date: Wed, 15 Mar 2006 15:40:41 -0800
Message-ID: <7vhd5zff9i.fsf@assigned-by-dhcp.cox.net>
References: <1142463103-6986-markhollomon@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 00:40:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJfbi-0002Xi-4c
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 00:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCOXkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 18:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbWCOXkn
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 18:40:43 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12758 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751375AbWCOXkn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 18:40:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060315233902.EDKZ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Mar 2006 18:39:02 -0500
To: Mark Hollomon <markhollomon@comcast.net>
In-Reply-To: <1142463103-6986-markhollomon@comcast.net> (Mark Hollomon's
	message of "Wed, 15 Mar 2006 22:51:41 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17624>

Mark Hollomon <markhollomon@comcast.net> writes:

> If the user does not set a merge strategy for git-pull,
> let git-merge calculate a default strategy.

Makes lot of sense, thanks.

> This may be preferable to the earlier patch involving
> NO_PYTHON.

Which earlier patch???
