From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Another problem with not existing directories
Date: Mon, 31 Oct 2005 18:46:12 +0100
Message-ID: <1130780772.5848.32.camel@blade>
References: <1130779234.5848.15.camel@blade>
	 <Pine.LNX.4.64.0510310929361.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 18:49:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWdjw-0005wI-9v
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 18:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVJaRqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 12:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVJaRqd
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 12:46:33 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:12427 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932515AbVJaRqc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 12:46:32 -0500
Received: from blade (p5487CE7F.dip.t-dialin.net [84.135.206.127])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j9VHkDGB025480
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 31 Oct 2005 18:46:14 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510310929361.27915@g5.osdl.org>
X-Mailer: Evolution 2.4.1 
X-Virus-Scanned: ClamAV 0.85.1/1150/Sun Oct 30 12:20:38 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10868>

Hi Linus,

> > I think there exists another problem with git-unpack-objects if the
> > sub-directory in "objects" doesn't exists.
> 
> Are you sure you just don't have an old version of git on the other end?

this might be possible, but then it is an old git on kernel.org. I never
installed any git by myself on it.

Regards

Marcel
