From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 10/10] user-manual: listing commits reachable from some refs not others
Date: Mon, 14 May 2007 17:48:33 +0200
Message-ID: <20070514154833.GD5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon May 14 17:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hncmx-0004f1-LB
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbXENPsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXENPsj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:48:39 -0400
Received: from planck.djpig.de ([85.10.192.180]:3418 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbXENPsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:48:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 16C8E274014;
	Mon, 14 May 2007 17:48:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ydCucEx1oULZ; Mon, 14 May 2007 17:48:33 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id A9173274013; Mon, 14 May 2007 17:48:33 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47261>

On Mon, May 14, 2007 at 11:21:29AM -0400, J. Bruce Fields wrote:
> +Suppose you would like to see all the commits reachable from the branch
> +head named "master" but not from any other head in your repository.

This should probably be "maint", because later you have:

> +And then we can ask to see all the commits reachable from maint
> +but not from these other heads:

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
