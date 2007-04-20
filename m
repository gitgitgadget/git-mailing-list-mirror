From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: cg-log "fatal: bad revision ''"
Date: Fri, 20 Apr 2007 19:03:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704201900430.4275@castor.milkiway.cos>
References: <1Hergt-0EBwVE0@fwd29.aul.t-online.de> <20070420135816.GO4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 20 19:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HewWY-0002Zq-AK
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 19:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992419AbXDTRDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 13:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993020AbXDTRDh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 13:03:37 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:44186 "EHLO
	mailout05.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992419AbXDTRDg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 13:03:36 -0400
Received: from fwd26.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1HewWD-000823-07; Fri, 20 Apr 2007 19:03:33 +0200
Received: from [192.168.2.100] (Tnz5NZZGoehs0njnEoTm1ri81pdktl9JebCTit-GRQUENR0USxuMEg@[84.163.229.10]) by fwd26.sul.t-online.de
	with esmtp id 1HewWA-10Dj7Y0; Fri, 20 Apr 2007 19:03:30 +0200
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <20070420135816.GO4489@pasky.or.cz>
X-ID: Tnz5NZZGoehs0njnEoTm1ri81pdktl9JebCTit-GRQUENR0USxuMEg
X-TOI-MSGID: 5ae89dd0-63a7-4ff0-8d2b-aa19c8907241
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45117>

On Fri, 20 Apr 2007, Petr Baudis wrote:

>   Hi,
> 
> On Fri, Apr 20, 2007 at 01:54:14PM CEST, MichaelTiloDressel@t-online.de wrote:
> > I moved a subdirectory in my working direcotry.
> > If I do cg-log on any of the files in the new subdirectory I get the
> > error:
> 
>   renames following in cg-log is known to be broken, please turn it off
> or use newer Cogito version which has it by default off.

Thanx for the reply. Is there a way to follow renaming at all, either 
with cogito or git?

Cheers,
Michael

> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
> 		-- Samuel Beckett
> 
