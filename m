From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Move convert-objects to contrib.
Date: Tue, 25 Sep 2007 07:04:25 -0700
Message-ID: <20070925140425.GA6061@ftbfs.org>
References: <1190690061-6720-1-git-send-email-kraai@ftbfs.org> <Pine.LNX.4.64.0709251100560.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaB2q-000377-Q3
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbXIYOEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbXIYOEo
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:04:44 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:35343 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbXIYOEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 10:04:43 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1IaBIY-0001Tv-V4; Tue, 25 Sep 2007 07:22:07 -0700
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1IaB1W-00009M-S3; Tue, 25 Sep 2007 07:04:26 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709251100560.28395@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Score: -4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59124>

On Tue, Sep 25, 2007 at 11:01:58AM +0100, Johannes Schindelin wrote:
> the commit message looks a little bit empty to me.  I'd at least mention 
> why convert-objects was needed, why it is no longer needed, and that 
> Linus, the original author, is okay with it.
> 
> And you might want to use the "-M" flag to format-patch next time (detect 
> renames).

OK, thanks.  I've resubmitted the patch, (hopefully) taking both
suggestions into account.

-- 
Matt
