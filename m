From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Sun, 08 Jul 2007 23:10:34 +0200
Message-ID: <20070708211034.GO1528MdfPADPa@greensroom.kotnet.org>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707081729040.4248@racer.site> <46912726.5080807@midwinter.com>
 <Pine.LNX.4.64.0707081920410.4248@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:10:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7e1f-0007pF-NI
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbXGHVKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757231AbXGHVKh
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:10:37 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:54806 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757057AbXGHVKg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:10:36 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JKV00H1DPHMU2@psmtp09.wxs.nl> for git@vger.kernel.org; Sun,
 08 Jul 2007 23:10:34 +0200 (MEST)
Received: (qmail 6920 invoked by uid 500); Sun, 08 Jul 2007 21:10:34 +0000
In-reply-to: <Pine.LNX.4.64.0707081920410.4248@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51919>

On Sun, Jul 08, 2007 at 07:41:53PM +0100, Johannes Schindelin wrote:
> Hey, if skimo would be willing to work until it is a complete replacement 
> for filter-branch, and more, I will stop working on filter-branch at once.  

As I said, I'm willing to put some more time into this.
However, I didn't want to wait until I had all the bells and whistles
before sending something out.  If people don't like the direction
I'm going, then there is no point continuing and then I'll just
use it for myself.

I guess the major thing that is missing is --subdirectory-filter.
Anything else?

skimo
