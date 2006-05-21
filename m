From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reference git-check-ref-format in git-branch.
Date: Sun, 21 May 2006 02:07:05 -0700
Message-ID: <7vhd3jzqyu.fsf@assigned-by-dhcp.cox.net>
References: <20060521015446.GA7605@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 11:07:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhju5-0003kB-7t
	for gcvg-git@gmane.org; Sun, 21 May 2006 11:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWEUJHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 05:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWEUJHI
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 05:07:08 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60336 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932306AbWEUJHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 05:07:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521090706.VXYT15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 05:07:06 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060521015446.GA7605@spearce.org> (Shawn Pearce's message of
	"Sat, 20 May 2006 21:54:46 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20443>

Shawn Pearce <spearce@spearce.org> writes:

>  Sorry about this patch being built on pu.  It clearly has no
>  relationship to current pu, but the new -l appears in the hunk
>  below...

"am -3 -s -u" is how I handle patches anyway, and it did not
have much trouble backporting it to the tip of "master".
