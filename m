From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --temp and --stage=all options to checkout-index.
Date: Sun, 05 Mar 2006 00:55:13 -0800
Message-ID: <7v8xrpi83y.fsf@assigned-by-dhcp.cox.net>
References: <20060303012032.GC6321@spearce.org>
	<7vmzg83xro.fsf@assigned-by-dhcp.cox.net>
	<20060303151331.GA16369@spearce.org>
	<7vlkvpihm4.fsf@assigned-by-dhcp.cox.net>
	<20060305082415.GD24437@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 09:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFp1R-0004y7-Am
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 09:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWCEIzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 03:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbWCEIzR
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 03:55:17 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36595 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750726AbWCEIzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 03:55:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305085135.LKBV17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 03:51:35 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060305082415.GD24437@spearce.org> (Shawn Pearce's message of
	"Sun, 5 Mar 2006 03:24:15 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17208>

Shawn Pearce <spearce@spearce.org> writes:

> This replaces my prior patch.  It looks a heck of a lot cleaner too
> due to less indentation changes.  :-)

Much nicer.  Will put in "next" for wider exposure.
