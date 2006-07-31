From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1]   Make git-tar-tree more flexible
Date: Sun, 30 Jul 2006 18:17:58 -0700
Message-ID: <7v4pwybmih.fsf@assigned-by-dhcp.cox.net>
References: <20060730174847.GA32574@eve.kumria.com>
	<7vbqr6dd4t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607310225190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 03:18:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7MQC-0007we-Ds
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 03:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWGaBSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 21:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWGaBSA
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 21:18:00 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25518 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932508AbWGaBR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 21:17:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731011759.MQKH1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Jul 2006 21:17:59 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607310225190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 31 Jul 2006 02:26:27 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24486>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So how about this:
>
> -- 8< --
> [PATCH] tar-tree: illustrate an obscure feature better
>
> Since you can tar just a subdirectory of a certain revision, tell
> the users so, by showing an example how to do it.

Sounds sensible.  Thanks.
