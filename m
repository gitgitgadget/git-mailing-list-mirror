From: Greg KH <greg@kroah.com>
Subject: Re: [TIG RFC] Cleaning up tig's option handling
Date: Wed, 6 Feb 2008 22:30:48 -0800
Message-ID: <20080207063048.GA22148@kroah.com>
References: <20080206235734.GA9969@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Feb 07 07:28:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN0FK-0002Pe-U4
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 07:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbYBGG15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 01:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYBGG15
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 01:27:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57564 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbYBGG14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 01:27:56 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JN0Ek-0001df-Ab; Thu, 07 Feb 2008 06:27:55 +0000
Content-Disposition: inline
In-Reply-To: <20080206235734.GA9969@diku.dk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72897>

On Thu, Feb 07, 2008 at 12:57:34AM +0100, Jonas Fonseca wrote:
> Hello,
> 
> In my own usage of tig, I increasingly use git-log options like -S and
> --all and rarely use any of the "native" tig options or subcommands.

Same for my usage, and I use tig a lot too.

> I would like to ask tig users out there on how to best proceed with
> cleaning up the option handling so that tig will act more like gitk.

Anything that works more like gitk would be fine with me, no objection
to changing the options at all.

thanks,

greg k-h
