From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: bug in gitk: history moves right when scrolling up and down with mouse wheel
Date: Fri, 7 Jan 2011 21:24:33 +0100
Message-ID: <1juqtpt.1dxkc9x1ho9gxzM%lists@haller-berlin.de>
References: <4D275F02.1030100@gmail.com>
Cc: git@vger.kernel.org
To: nkreitzinger@gmail.com (Neal Kreitzinger),
	u.kleine-koenig@pengutronix.de (=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=)
X-From: git-owner@vger.kernel.org Fri Jan 07 21:24:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIrb-0007ul-N2
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab1AGUYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 15:24:39 -0500
Received: from mail.ableton.net ([62.96.12.117]:53911 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754305Ab1AGUYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 15:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=A+F+hMercKl4IN/reMxtE7rCWDCU3SwKVx8EGni9pHM=;
	b=VcMnyuo/r2KU8H0whOQVvvOWAddLDJJ6Xeuc2nn/Ai5g/57+rk1kY8FQK471k6gSe4LD2NyU1fQglMsV1q9b2aJMJbW174DpNeESKfkgDzsT5xDnsIszs1BXOiEhYDKC20+CmgZxdZXWNHO5YvNMOBtNalpfftcM7sNWQvQU4g0=;
Received: from dslb-088-074-017-003.pools.arcor-ip.net ([88.74.17.3] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PbIqZ-0002wF-SS; Fri, 07 Jan 2011 21:23:40 +0100
In-Reply-To: <4D275F02.1030100@gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.5 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164756>

Neal Kreitzinger <nkreitzinger@gmail.com> wrote:

> Actually, I've wanted the ability to scroll left and right in the 
> history pane for quite a while.  Resorting to shrinking the fontsize and
> the other columns only goes so far when trying to see a list of 
> equivalent refs.  If the ability to scroll left and right can be kept
> that would be cool.

Interesting.  On the Mac it *is* possible to scroll left and right, and
it absolutely drives me nuts, so I disabled it in my private build. 
I guess it's ok with a mouse, where shift-wheel scrolls horizontally,
but on a track-pad with two-finger scrolling, where you can scroll both
horizontally and vertically with a single guesture, it is completely
undesirable.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
