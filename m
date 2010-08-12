From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG/TEST] git-svn: fetch fails with deleted tag
Date: Thu, 12 Aug 2010 08:11:57 +0000
Message-ID: <20100812081157.GA30970@dcvr.yhbt.net>
References: <1281159415-60900-1-git-send-email-ddkilzer@kilzer.net> <765385.99383.qm@web30004.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 10:12:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjStR-00024u-UB
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 10:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab0HLIMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 04:12:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47696 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab0HLIL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 04:11:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E041F449;
	Thu, 12 Aug 2010 08:11:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <765385.99383.qm@web30004.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153351>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> On Fri, August 6, 2010 at 10:36:55 PM, David D. Kilzer wrote:
> > The attached test fails when fetching the svn repo:
> I have a fix for this.  I hope to send it out by Friday for further review.

Thanks for the update, David.  I took a short stab but didn't
come up with much.  I'll take a look at your patch this weekend

-- 
Eric Wong
