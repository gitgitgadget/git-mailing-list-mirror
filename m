From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: Add some useful commandline options
Date: Thu, 14 Jun 2007 17:36:55 +0200
Message-ID: <20070614153655.GA457@planck.djpig.de>
References: <1181228221959-git-send-email-frank@lichtenheld.de> <11812282222271-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyrYF-0006SM-KM
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbXFNPr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbXFNPr1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:47:27 -0400
Received: from planck.djpig.de ([85.10.192.180]:4954 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbXFNPr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 11:47:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C417F881BB;
	Thu, 14 Jun 2007 17:47:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XVnHxK0iMvHN; Thu, 14 Jun 2007 17:44:02 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 35899881B6; Thu, 14 Jun 2007 17:36:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11812282222271-git-send-email-frank@lichtenheld.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50209>

On Thu, Jun 07, 2007 at 04:57:01PM +0200, Frank Lichtenheld wrote:
> Make git-cvsserver understand some options inspired by
> git-daemon, namely --base-path, --export-all, --strict-paths.

Note that this patch doesn't actually implement --export-all ...
Which I would have caught if I implemented a test for it, which I also
didn't do...

Will send a fix somewhen in the next days.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
http://www.djpig.de/
