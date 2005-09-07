From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add $(LIBS) and set libiconv in tools/Makefile for Darwin
Date: Wed, 07 Sep 2005 12:18:54 -0700
Message-ID: <7vd5nk6601.fsf@assigned-by-dhcp.cox.net>
References: <7v8xy9bfaj.fsf@assigned-by-dhcp.cox.net>
	<20050907150103.11609.qmail@web34311.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 21:21:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED5Ri-0001DP-Ih
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 21:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVIGTS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVIGTS4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 15:18:56 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48894 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751277AbVIGTS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 15:18:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050907191853.TLBW9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 15:18:53 -0400
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050907150103.11609.qmail@web34311.mail.mud.yahoo.com> (Mark
	Allen's message of "Wed, 7 Sep 2005 08:01:02 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8175>

Mark Allen <mrallen1@yahoo.com> writes:

> Looks good to me, Junio.  There's a very small typo in your
> commit though. :-)

Thanks.
