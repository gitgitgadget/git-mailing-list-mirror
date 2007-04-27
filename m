From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/8] Removing -n option from git-diff-files documentation
Date: Fri, 27 Apr 2007 20:05:23 +0200
Message-ID: <20070427180523.GB4489@pasky.or.cz>
References: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 20:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhUpB-0005eB-5X
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 20:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbXD0SF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 14:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbXD0SF0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 14:05:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52015 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756966AbXD0SFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 14:05:25 -0400
Received: (qmail 21414 invoked by uid 2001); 27 Apr 2007 20:05:23 +0200
Content-Disposition: inline
In-Reply-To: <20070427050550.GA9594@bowser.ruder>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45740>

On Fri, Apr 27, 2007 at 07:05:50AM CEST, Andrew Ruder wrote:
> -n is not a short form of --no-index as the documentation
> suggests.  Removing it from the documentation and command
> usage string.

Nevertheless, git-diff-files does accept -n, apparently to limit the
number of outputted entries or something. Where is it documented?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
