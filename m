From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Another problem with not existing directories
Date: Mon, 31 Oct 2005 22:38:30 +0100
Message-ID: <1130794710.31561.3.camel@blade>
References: <1130779234.5848.15.camel@blade>
	 <Pine.LNX.4.64.0510310929361.27915@g5.osdl.org>
	 <1130780772.5848.32.camel@blade>  <7vk6ftil38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 22:40:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWhMX-0007ig-4V
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 22:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVJaVih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 16:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVJaVih
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 16:38:37 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:21131 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964850AbVJaVig
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 16:38:36 -0500
Received: from blade (p5487CE7F.dip.t-dialin.net [84.135.206.127])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j9VLcVGB029294
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 31 Oct 2005 22:38:32 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6ftil38.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.1 
X-Virus-Scanned: ClamAV 0.85.1/1150/Sun Oct 30 12:20:38 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10893>

Hi Junio,

> >> Are you sure you just don't have an old version of git on the other end?
> >
> > this might be possible, but then it is an old git on kernel.org. I never
> > installed any git by myself on it.
> 
> I just tried this myself; master.kernel.org seems to have
> 0.99.8f in /usr/bin/, which explains this symptom.

so as soon as kernel.org switches to 0.99.9 everything should be fine
again. That's great.

Regards

Marcel
