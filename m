From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 11:54:00 +0200
Message-ID: <20070719095400.GB999MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site>
 <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707190258550.14781@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 11:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBShz-0001WC-Dx
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 11:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbXGSJyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 05:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbXGSJyE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 05:54:04 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:35427 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbXGSJyC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 05:54:02 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JLF000RL7I0Y5@psmtp09.wxs.nl> for git@vger.kernel.org; Thu,
 19 Jul 2007 11:54:00 +0200 (MEST)
Received: (qmail 2047 invoked by uid 500); Thu, 19 Jul 2007 09:54:00 +0000
In-reply-to: <Pine.LNX.4.64.0707190258550.14781@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52956>

On Thu, Jul 19, 2007 at 03:30:43AM +0100, Johannes Schindelin wrote:
> +If such a path exists in the given ref, the referenced blob is read, and
> +appended to the commit message, separated by a "Notes:" line.  If the
> +given ref itself does not exist, it is not an error, but means that no
> +notes should be print.

printed?

skimo
