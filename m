From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH 2/2] filter-branch: update current branch when rewritten
Date: Thu, 18 Oct 2007 07:43:13 -0500
Message-ID: <18199.21729.535096.397497@lisa.zopyra.com>
References: <18197.24051.863751.436705@lisa.zopyra.com>
	<Pine.LNX.4.64.0710170322000.25221@racer.site>
	<Pine.LNX.4.64.0710170322400.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:44:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiUji-0000zs-8j
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 14:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761128AbXJRMoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 08:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757517AbXJRMoO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 08:44:14 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61641 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216AbXJRMoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 08:44:14 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l9IChFg13846;
	Thu, 18 Oct 2007 06:43:15 -0600
In-Reply-To: <Pine.LNX.4.64.0710170322400.25221@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61524>

On Wednesday, October 17, 2007 at 03:23:10 (+0100) Johannes Schindelin writes:
>
>Earlier, "git filter-branch --<options> HEAD" would not update the
>working tree after rewriting the branch.  This commit fixes it.
>
>Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>---
>
>	Bill, I hope this clarifies some things for you, too...

Thanks very much.  I hope so, too.  I'll pull this in to my tree
when it gets into the git repository (how do I know when that happens,
or do I just need to pull and inspect?).


Bill
