From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH repost] Multiple refs from the same remote in one git fetch
Date: Tue, 22 Aug 2006 18:34:29 -0700
Message-ID: <7v7j10jkuy.fsf@assigned-by-dhcp.cox.net>
References: <20060814051302.GB21963@mellanox.co.il>
	<20060822151029.GA19247@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 03:34:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFhda-0005yV-DU
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 03:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWHWBeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 21:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWHWBeb
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 21:34:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33251 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932178AbWHWBea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 21:34:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823013430.TYKI21457.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 21:34:30 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25887>

Although this round does not seem to break tests like before, I
still do not see a valid use case for it.  So...
