From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Thu, 11 Jan 2007 22:41:43 +0100
Message-ID: <20070111214143.GB6058@steel.home>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vhcuyaaxq.fsf@assigned-by-dhcp.cox.net> <81b0412b0701101326p11069c76w2873106cb2d46ebf@mail.gmail.com> <7vy7oa765a.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:42:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57gI-0002No-Sc
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXAKVlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbXAKVlv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:41:51 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:42372 "EHLO
	mailout11.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932071AbXAKVlu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jan 2007 16:41:50 -0500
Received: from fwd28.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1H57gB-0008N4-00; Thu, 11 Jan 2007 22:41:47 +0100
Received: from tigra.home (Vmf8giZv8e9gykV3vbL4wknYT1TfGY-s40grgxt-Sl4y2x26h9vCYs@[84.163.96.128]) by fwd28.sul.t-online.de
	with esmtp id 1H57g8-12Y5nU0; Thu, 11 Jan 2007 22:41:44 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E746F277B6;
	Thu, 11 Jan 2007 22:41:43 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A746BC166; Thu, 11 Jan 2007 22:41:43 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7oa765a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-ID: Vmf8giZv8e9gykV3vbL4wknYT1TfGY-s40grgxt-Sl4y2x26h9vCYs
X-TOI-MSGID: a7516cad-7ccb-42fa-9e8d-4e62bae241a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36614>

Junio C Hamano, Thu, Jan 11, 2007 01:34:41 +0100:
> >> I would prefer it to be rather automatic -- how about this instead?
> > ...
> >> +ifneq (,$X)
> >
> > Perfect! :)
> 
> Heh, you couldn't have tested -- I still had "echo rm -f" in the
> patch ;-).

Didn't. Just liked the approach :)
