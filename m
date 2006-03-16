From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 13:32:09 -0600
Message-ID: <1142537528.17536.143.camel@cashmere.sps.mot.com>
References: <20060314211022.GA12498@localhost.localdomain>
	 <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	 <20060314224027.GB14733@localhost.localdomain>
	 <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	 <7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
	 <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
	 <20060316075324.GA19650@pfit.vm.bytemark.co.uk>
	 <7vmzfq8zmr.fsf@assigned-by-dhcp.cox.net>
	 <1142537257.17536.137.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Mar 16 20:32:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJyD1-0000YD-Ag
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 20:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWCPTc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 14:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWCPTc2
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 14:32:28 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:58250 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750940AbWCPTc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 14:32:27 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k2GJkM51006548
	for <git@vger.kernel.org>; Thu, 16 Mar 2006 12:46:22 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k2GJgbJv021155
	for <git@vger.kernel.org>; Thu, 16 Mar 2006 13:42:37 -0600 (CST)
To: Git List <git@vger.kernel.org>
In-Reply-To: <1142537257.17536.137.camel@cashmere.sps.mot.com>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17645>

On Thu, 2006-03-16 at 13:27, Jon Loeliger wrote:

> While we want to proved an abstraction layer to the
> user through the "git" wrapper, we still want to be
> precise internally within the scripts themselves.

Hey!  Nice English there, Jon!

s/proved/provide

jdl
