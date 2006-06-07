From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Some doc typo fixes
Date: Wed, 07 Jun 2006 09:48:38 -0700
Message-ID: <7v1wu0lxnd.fsf@assigned-by-dhcp.cox.net>
References: <20060607125644.GT29682@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 18:49:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo1D8-0002Y2-2t
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 18:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWFGQsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 12:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWFGQsk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 12:48:40 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65436 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932326AbWFGQsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 12:48:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060607164839.JMNS554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 12:48:39 -0400
To: Francis Daly <francis@daoine.org>
In-Reply-To: <20060607125644.GT29682@craic.sysops.org> (Francis Daly's message
	of "Wed, 7 Jun 2006 13:56:45 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21442>

Francis Daly <francis@daoine.org> writes:

> All should be clear enough, except perhaps committish / commitish.
> I just kept the more-used one within the current docs.

Thanks.  I am not a native, and this is very much appreciated.

>  . It could be named hierarchically (i.e. separated with slash
> -  `/`), but each of its component cannot begin with a dot `.`;
> +  `/`), but each of its components cannot begin with a dot `.`;

I am not sure; shouldn't the wording be "each of <plural>" to mean
"there are/can be more than one, and you look at them one by one
and make sure the condition holds for each of them" (oops,
that's cyclic explanation and I failed to paraphrase it without
using "each of")???

All the others look good.  Thanks.
