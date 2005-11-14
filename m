From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Bugfix: stop if directory already exists
Date: Mon, 14 Nov 2005 11:36:18 +0100
Message-ID: <200511141136.19192.Josef.Weidendorfer@gmx.de>
References: <200511131503.32078.Josef.Weidendorfer@gmx.de> <7vpsp3zjwm.fsf@assigned-by-dhcp.cox.net> <437858A1.9010007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 11:38:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbbhJ-0008Ji-9Q
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 11:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVKNKgW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 05:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKNKgW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 05:36:22 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:51082 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750735AbVKNKgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 05:36:21 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 7745527E2;
	Mon, 14 Nov 2005 11:36:20 +0100 (MET)
To: Andreas Ericsson <ae@op5.se>
User-Agent: KMail/1.8.2
In-Reply-To: <437858A1.9010007@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11785>

On Monday 14 November 2005 10:28, Andreas Ericsson wrote:
> But we name them differently, as hpa pointed out some week ago.
> 
> When I see "usage: <prog> <command>" I expect to find the info in "man 
> <prog>". Soon, this will work to get the right page
> 
> 	git --help <command>

This is a nice feature, but still needs educating the user.
I think that the idea of a huge git man page is not that bad; for sure,
it can be created automatically.

A huge man page helps searching a command name (Ah, what was the
command to see commit logs per file? What is the counterpart of
"cvs update" called?).

Josef
