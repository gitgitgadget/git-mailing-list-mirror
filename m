From: David Miller <davem@davemloft.net>
Subject: Re: Issue: repack semi-frequently fails on Windows (msysgit) -
 suspecting file descriptor issues
Date: Thu, 16 Apr 2015 11:56:55 -0400 (EDT)
Message-ID: <20150416.115655.1025728315437891295.davem@davemloft.net>
References: <20150416113505.GA30818@rhlx01.hs-esslingen.de>
	<20150416152849.GA30137@peff.net>
	<a710472d7bf37757b7341dd99f8c76f3@www.dscho.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, andi@lisas.de, thomas.braun@virtuell-zuhause.de,
	git@vger.kernel.org, msysgit@googlegroups.com,
	git-owner@vger.kernel.org
To: johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Thu Apr 16 17:57:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YimA3-0005fn-F1
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbbDPP47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 11:56:59 -0400
Received: from shards.monkeyblade.net ([149.20.54.216]:33217 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbbDPP45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 11:56:57 -0400
Received: from localhost (cpe-66-108-87-106.nyc.res.rr.com [66.108.87.106])
	(Authenticated sender: davem-davemloft)
	by shards.monkeyblade.net (Postfix) with ESMTPSA id B73CD581BDD;
	Thu, 16 Apr 2015 08:56:56 -0700 (PDT)
In-Reply-To: <a710472d7bf37757b7341dd99f8c76f3@www.dscho.org>
X-Mailer: Mew version 6.6 on Emacs 24.4 / Mule 6.0 (HANACHIRUSATO)
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Apr 2015 08:56:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267303>


Please remove git-owner from the CC: list in future replies, thank
you. :-)
