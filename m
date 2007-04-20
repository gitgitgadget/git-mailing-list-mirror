From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-log "fatal: bad revision ''"
Date: Fri, 20 Apr 2007 15:58:16 +0200
Message-ID: <20070420135816.GO4489@pasky.or.cz>
References: <1Hergt-0EBwVE0@fwd29.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Fri Apr 20 15:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hetcz-0005Qf-H4
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 15:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbXDTN6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 09:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbXDTN6S
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 09:58:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41560 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477AbXDTN6S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 09:58:18 -0400
Received: (qmail 30308 invoked by uid 2001); 20 Apr 2007 15:58:16 +0200
Content-Disposition: inline
In-Reply-To: <1Hergt-0EBwVE0@fwd29.aul.t-online.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45105>

  Hi,

On Fri, Apr 20, 2007 at 01:54:14PM CEST, MichaelTiloDressel@t-online.de wrote:
> I moved a subdirectory in my working direcotry.
> If I do cg-log on any of the files in the new subdirectory I get the
> error:

  renames following in cg-log is known to be broken, please turn it off
or use newer Cogito version which has it by default off.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
