From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: first impressions to git
Date: Mon, 19 Sep 2005 21:14:28 +0200
Message-ID: <20050919191428.GG15165MdfPADPa@greensroom.kotnet.org>
References: <20050918111259.GA10882@schottelius.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
	Christian Gierke <ch@gierke.de>
X-From: git-owner@vger.kernel.org Mon Sep 19 21:14:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHR68-0003cc-SN
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 21:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVISTOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVISTOi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 15:14:38 -0400
Received: from smtp13.wxs.nl ([195.121.6.27]:6807 "EHLO smtp13.wxs.nl")
	by vger.kernel.org with ESMTP id S932563AbVISTOh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 15:14:37 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN200AHYW44UE@smtp13.wxs.nl> for git@vger.kernel.org; Mon,
 19 Sep 2005 21:14:28 +0200 (CEST)
Received: (qmail 20807 invoked by uid 500); Mon, 19 Sep 2005 19:14:28 +0000
In-reply-to: <20050918111259.GA10882@schottelius.org>
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Mail-followup-to: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
 git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
 Christian Gierke <ch@gierke.de>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8899>

On Sun, Sep 18, 2005 at 01:12:59PM +0200, Nico -telmich- Schottelius wrote:
> - gitweb.cgi could be better documentated and supported
>    recursive directories when using $projects_list = $projectroot;
>    and splitting configuration completly outside of gitweb.cgi would be nice
>    (having .gitweb in the same directory as gitweb.cgi for instance)

If you don't mind running an "unofficial" gitweb, then you could use this:

http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=commitdiff;h=4e9ef72b3ad9a072c3b3a78d8f44ef7d592b7303;hp=cf893c76de670164e8d90be5ccf1d871e60188ae

skimo
