From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH 2/5] Not all vendor diffs support GNUisms (resend)
Date: Sun, 25 Apr 2010 11:02:08 -0500 (CDT)
Message-ID: <20100425152130.GA27695@thor.il.thewrittenword.com>
References: <20100311163039.GB7877@thor.il.thewrittenword.com>
 <4B994324.9060400@lsrfire.ath.cx>
 <20100315050943.GA22128@thor.il.thewrittenword.com>
 <4BD45874.9010700@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Apr 25 18:02:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O64Hl-0000wX-Fp
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 18:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab0DYQCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 12:02:10 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:57009 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab0DYQCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 12:02:09 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 86C685CB8
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 16:23:11 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 86C685CB8
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 7E12CA63
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 16:02:08 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 47A1557C; Sun, 25 Apr 2010 11:02:08 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <4BD45874.9010700@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145745>

Apologies for the long delay before my resent repost... it took me
until now to figure out why most of my messages to this lest were
being rejected...

On Sun, Apr 25, 2010 at 04:57:56PM +0200, Ren? Scharfe wrote:
> Am 25.04.2010 10:35, schrieb Gary V. Vaughan:
> >> (I'd split the introduction of DIFF/$DIFF, the diff -> test_cmp
> >> conversions and the change to set GIT_TEST_CMP=cmp for your platform
> >> into three separate patches.)
> > 
> > Will do. And then I'll resubmit the whole series.
> 
> Commits c296134d and 4a2284b9 from Junio (in git 1.7.1) already do some
> part of the work, converting two test script to test_cmp.

Excellent.  ETA on a release from that branch so that I can finish any
necessary changes to my outstanding changesets?

...or is there time for me to clone the repository and rebase those
changes in time for the 1.7.1 release?

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
