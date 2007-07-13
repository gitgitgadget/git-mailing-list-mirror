From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Draft release notes for v1.5.3, as of -rc1
Date: Fri, 13 Jul 2007 11:29:09 +0200
Message-ID: <20070713092908.GO1528MdfPADPa@greensroom.kotnet.org>
References: <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
 <7vejl0546b.fsf@assigned-by-dhcp.cox.net>
 <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
 <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
 <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
 <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
 <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
 <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
 <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
 <7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 11:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9HSe-00046o-Sz
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 11:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231AbXGMJ3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 05:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763283AbXGMJ3L
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 05:29:11 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:45078 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759312AbXGMJ3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 05:29:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL400D9N2CLLX@smtp17.wxs.nl> for git@vger.kernel.org; Fri,
 13 Jul 2007 11:29:09 +0200 (CEST)
Received: (qmail 21171 invoked by uid 500); Fri, 13 Jul 2007 09:29:09 +0000
In-reply-to: <7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52373>

On Thu, Jul 12, 2007 at 11:40:39PM -0700, Junio C Hamano wrote:
>   - "git-filter-branch" lets you rewrite the revision history of
>     the current branch, creating a new branch. You can specify a
>     number of filters to modify the commits, files and trees.

Are you sure you want to announce this so publicly given that
Dscho has basically declared git-filter-branch dead?
(I know, I'm mostly to blame.)

skimo
