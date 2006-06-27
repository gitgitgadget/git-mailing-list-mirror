From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] t4014: fix for whitespace from "wc -l"
Date: Tue, 27 Jun 2006 10:10:24 -0700
Message-ID: <7vy7vi8qyn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606271011500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 27 19:10:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvH53-0005ri-Tt
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 19:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWF0RK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 13:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWF0RK1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 13:10:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64692 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161221AbWF0RK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 13:10:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627171025.NLYZ554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 13:10:25 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606271011500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 27 Jun 2006 10:12:12 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22746>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Some "wc" insist on putting a TAB in front of the number.

My bad.  I think this is the third time I had others correct
this exact habit of mine.

Thanks.
