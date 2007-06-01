From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 01 Jun 2007 10:57:05 +0200
Message-ID: <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
References: <1180385483418-git-send-email-hjemli@gmail.com>
 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:57:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu2wZ-000487-L3
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 10:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbXFAI5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 04:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbXFAI5I
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 04:57:08 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:33502 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbXFAI5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 04:57:07 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIY004E08V5L2@psmtp03.wxs.nl> for git@vger.kernel.org; Fri,
 01 Jun 2007 10:57:06 +0200 (MEST)
Received: (qmail 19727 invoked by uid 500); Fri, 01 Jun 2007 08:57:05 +0000
In-reply-to: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48855>

On Thu, May 31, 2007 at 02:17:30AM +0200, Lars Hjemli wrote:
> 1. 'git-submodule init' saves submodule name and suggested url from
> .gitmodules into .git/config (submodule.$name.url)

Could you please document the proposed .gitmodules first?
Since it looks like I'm going to be forced to my submodule URLs there,
I need to know how to do it before I can start using submodules properly.

skimo
