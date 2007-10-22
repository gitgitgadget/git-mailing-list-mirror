From: Scott Parish <sRp@srparish.net>
Subject: Re: how to deal with conflicts after "git stash apply"?
Date: Sun, 21 Oct 2007 21:39:33 -0700
Message-ID: <20071022043933.GL16291@srparish.net>
References: <20071021223206.GJ16291@srparish.net> <Pine.LNX.4.64.0710212338200.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 06:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijp4z-0004Zf-MO
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 06:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbXJVEjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 00:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbXJVEjh
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 00:39:37 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:37843 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXJVEjg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 00:39:36 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Ijp4h-00006F-8q; Sun, 21 Oct 2007 23:39:35 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 21 Oct 2007 21:39:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710212338200.25221@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61931>

> You should have a look into Documentation/diff-format.txt (section 
> "combined diff format") to learn more.

Ah, thanks for the pointer; i hadn't realized that this wasn't
standard diff format. With this and what Shawn said, it all makes
sense now.

sRp

-- 
Scott Parish
http://srparish.net/
