From: Xavier Maillard <zedek@gnu.org>
Subject: Re: Publishing on a simple HTTP server
Date: Tue, 13 Feb 2007 12:45:40 +0100
Message-ID: <23628.1171367140@localhost>
References: <14870.1171311025@localhost> <Pine.LNX.4.63.0702130009010.22628@wbgn013.biozentrum.uni-wuerzburg.de> <19695.1171344721@localhost> <Pine.LNX.4.63.0702131106230.1300@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 12:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGw93-0002RK-CQ
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 12:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbXBMLsT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 06:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbXBMLsT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 06:48:19 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:43046 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbXBMLsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 06:48:18 -0500
Received: from localhost.localdomain (cha51-2-82-244-211-40.fbx.proxad.net [82.244.211.40])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2086B27B51;
	Tue, 13 Feb 2007 12:48:15 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1DBjeG2023629;
	Tue, 13 Feb 2007 12:45:40 +0100
In-reply-to: <Pine.LNX.4.63.0702131106230.1300@wbgn013.biozentrum.uni-wuerzburg.de> 
Comments: In-reply-to Johannes Schindelin <Johannes.Schindelin@gmx.de>
   message dated "Tue, 13 Feb 2007 11:07:31 +0100."
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39516>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> In that case, please extend your mirror script to run 
> git-update-server-info before mirroring.

I thought this:

git --bare --git-dir=/tmp/my-cloned.git update-server-info

was supposed to achieve this. Doesn't it ?
 
> And if it works, a small description (maybe as a patch for 
> Documentation/howto/?) would be nice.

No problem. I won't forget.

Xavier
