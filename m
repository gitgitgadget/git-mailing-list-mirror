From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Mon, 11 Jun 2007 13:04:45 +0200
Message-ID: <20070611110445.GJ955MdfPADPa@greensroom.kotnet.org>
References: <1181425132239-git-send-email-hjemli@gmail.com>
 <11814251322779-git-send-email-hjemli@gmail.com>
 <20070610002802.GD31707@planck.djpig.de>
 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
 <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
 <7vzm377cjk.fsf@assigned-by-dhcp.cox.net>
 <8c5c35580706101414r72c45e84q2b81083f8f88ec40@mail.gmail.com>
 <20070611083406.GH955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706110347u55a944ds86f06dabce9e6435@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Lars Hjemli <hjemli@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 13:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxhj8-0007xx-L8
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 13:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbXFKLFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 07:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbXFKLFU
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 07:05:20 -0400
Received: from smtp18.wxs.nl ([195.121.247.9]:37988 "EHLO smtp18.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbXFKLEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 07:04:47 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JJG003KXXFYRF@smtp18.wxs.nl> for git@vger.kernel.org; Mon,
 11 Jun 2007 13:04:46 +0200 (CEST)
Received: (qmail 15919 invoked by uid 500); Mon, 11 Jun 2007 11:04:45 +0000
In-reply-to: <8c5c35580706110347u55a944ds86f06dabce9e6435@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49845>

On Mon, Jun 11, 2007 at 12:47:43PM +0200, Lars Hjemli wrote:
> On 6/11/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> >On Sun, Jun 10, 2007 at 11:14:27PM +0200, Lars Hjemli wrote:
> >> And I'll drop the "unless otherwise
> >> noted, name=path" behaviour. If we later decide it would be useful we
> >> can always "re-add" it.
> >
> >So every (sub)module subsection will have to have a path element?
> 
> Yes
> 
> >Why?
> 
> It addresses Junio's concern about ambiguity and confusion.

Junio, is this really what you meant?

Linus even advocated removing the mapping completely
(http://article.gmane.org/gmane.comp.version-control.git/48871),
but I wouldn't go that far.

skimo
