From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-update-ref: add --no-deref option for overwriting/detaching ref
Date: Wed, 9 May 2007 14:39:14 +0200
Message-ID: <20070509123914.GO4489@pasky.or.cz>
References: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed May 09 14:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HllS2-0001yU-P2
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbXEIMjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756220AbXEIMjQ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:39:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37964 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441AbXEIMjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:39:15 -0400
Received: (qmail 17435 invoked by uid 2001); 9 May 2007 14:39:14 +0200
Content-Disposition: inline
In-Reply-To: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46704>

On Wed, May 09, 2007 at 12:33:20PM CEST, Sven Verdoolaege wrote:
> git-checkout is also adapted to make use of this new option
> instead of the handcrafted command sequence.
> 
> Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

Isn't this what git-symbolic-ref is about?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
