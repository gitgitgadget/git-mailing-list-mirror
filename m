From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Do not use absolute font sizes
Date: Wed, 9 May 2007 15:47:22 +0200
Message-ID: <20070509134722.GU4489@pasky.or.cz>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com> <20070509014150.7477.48489.stgit@rover> <7vvef2y21o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 15:47:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlmVt-0002KG-8G
	for gcvg-git@gmane.org; Wed, 09 May 2007 15:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbXEINrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 09:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755599AbXEINrY
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 09:47:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54953 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424AbXEINrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 09:47:23 -0400
Received: (qmail 22895 invoked by uid 2001); 9 May 2007 15:47:22 +0200
Content-Disposition: inline
In-Reply-To: <7vvef2y21o.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46715>

On Wed, May 09, 2007 at 07:54:43AM CEST, Junio C Hamano wrote:
> 	[12, 18, 10] / 12 * 100 = [100, 150, 83.33]
> 
> why not use 83% for what were originally 10px?

It seemed to me that the small parts were way too large then (this is
also why I decided not to use 'large', 'medium' and 'small' - large was
too small and small was too large, I felt), but I don't particularily
care about this detail.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
