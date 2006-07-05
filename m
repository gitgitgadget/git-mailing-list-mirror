From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-base: update the clean-up postprocessing
Date: Wed, 05 Jul 2006 16:21:07 -0700
Message-ID: <7vzmfnaba4.fsf@assigned-by-dhcp.cox.net>
References: <44AB0948.9070606@gmail.com>
	<7vy7v8dctz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607050946390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 01:21:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyGgD-0008C9-1g
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 01:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWGEXVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 19:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWGEXVK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 19:21:10 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:28130 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965049AbWGEXVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 19:21:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060705232108.ODEO8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Jul 2006 19:21:08 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607050946390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 5 Jul 2006 09:50:53 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23365>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> BTW ALAS' argument about grafts not only shot down my maximumSkew, but 
> AFAICT also the generation number thing. Besides, the generation number 
> could be manipulated by a mean-spirited person also.

I think with the fixed-up version of "concepts only" patch,
generation number approach is already moot.
