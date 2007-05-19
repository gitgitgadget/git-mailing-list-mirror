From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sat, 19 May 2007 02:34:10 +0200
Message-ID: <20070519003410.GA4489@pasky.or.cz>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163061588-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 02:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCtv-0005I4-O7
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbXESAeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbXESAeN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:34:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48264 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbXESAeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:34:13 -0400
Received: (qmail 23762 invoked by uid 2001); 19 May 2007 02:34:10 +0200
Content-Disposition: inline
In-Reply-To: <11795163061588-git-send-email-skimo@liacs.nl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47696>

On Fri, May 18, 2007 at 09:24:56PM CEST, skimo@liacs.nl wrote:
> From: Sven Verdoolaege <skimo@kotnet.org>
> 
> This option currently has no effect.
> 
> Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

Nacked-by: Petr Baudis <pasky@suse.cz>

Please do not add more undocumented parameters - include documentation
in the patch adding the parameter.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
