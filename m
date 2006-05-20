From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-patch: Support --attach
Date: Sat, 20 May 2006 10:43:46 -0700
Message-ID: <7v4pzk3831.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605201537290.17869@wbgn013.biozentrum.uni-wuerzburg.de>
	<e4n8b3$ari$1@sea.gmane.org>
	<Pine.LNX.4.63.0605201904320.31887@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 19:43:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhVUU-0000c2-D6
	for gcvg-git@gmane.org; Sat, 20 May 2006 19:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWETRns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 13:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWETRns
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 13:43:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63465 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751451AbWETRnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 13:43:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060520174346.HOIM27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 May 2006 13:43:46 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605201904320.31887@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 May 2006 19:10:02 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20387>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I only changed the "From " line (note the missing ":") to match the output 
> from git-format-patch.sh.

Not a big deal, but I was hoping you would keep the inception
date of git (April one) in the final version ;-).  The September
date is totally a random date and does not have any
significance.

Anyway, with this change (and a lot of testing ;-) I think we
can replace the script with built-in.  Thanks.
