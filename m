From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Mon, 11 Jun 2007 10:34:06 +0200
Message-ID: <20070611083406.GH955MdfPADPa@greensroom.kotnet.org>
References: <1181425132239-git-send-email-hjemli@gmail.com>
 <11814251322779-git-send-email-hjemli@gmail.com>
 <20070610002802.GD31707@planck.djpig.de>
 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
 <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
 <7vzm377cjk.fsf@assigned-by-dhcp.cox.net>
 <8c5c35580706101414r72c45e84q2b81083f8f88ec40@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 10:34:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxfLp-0005mY-3V
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 10:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbXFKIeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 04:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbXFKIeK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 04:34:10 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:46131 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbXFKIeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 04:34:09 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JJG00JO5QGVWK@psmtp04.wxs.nl> for git@vger.kernel.org; Mon,
 11 Jun 2007 10:34:07 +0200 (MEST)
Received: (qmail 14199 invoked by uid 500); Mon, 11 Jun 2007 08:34:06 +0000
In-reply-to: <8c5c35580706101414r72c45e84q2b81083f8f88ec40@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49832>

On Sun, Jun 10, 2007 at 11:14:27PM +0200, Lars Hjemli wrote:
> And I'll drop the "unless otherwise
> noted, name=path" behaviour. If we later decide it would be useful we
> can always "re-add" it.

So every (sub)module subsection will have to have a path element?
Why?

skimo
