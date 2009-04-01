From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Wed, 1 Apr 2009 20:06:27 +0200
Message-ID: <20090401180627.GA14716@localhost>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us> <20090329121700.GN22446@genesis.frugalware.org> <op.urk20nanso3nzr@sulidor.mdjohnson.us> <20090330110335.GF22446@genesis.frugalware.org> <op.urnad7jbso3nzr@sulidor.mdjohnson.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Michael Johnson <redbeard@mdjohnson.us>
X-From: git-owner@vger.kernel.org Wed Apr 01 20:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp4rL-00055d-IZ
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 20:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbZDASGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 14:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933191AbZDASGj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 14:06:39 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:54717 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264AbZDASGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 14:06:38 -0400
Received: from darc.dyndns.org ([84.154.109.25]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Apr 2009 20:06:33 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Lp4pX-0003w8-Jk; Wed, 01 Apr 2009 20:06:27 +0200
Content-Disposition: inline
In-Reply-To: <op.urnad7jbso3nzr@sulidor.mdjohnson.us>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 01 Apr 2009 18:06:33.0707 (UTC) FILETIME=[974EFBB0:01C9B2F4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115408>

On Tue, Mar 31, 2009 at 02:14:21AM -0500, Michael Johnson wrote:
> It would appear that the patch has already been applied to 1.6.2.1.

I don't think it has. But judging from the stack trace this bug is unrelated
to the patch anyways.

If nobody else is dealing with this I'd like to have a look at it. Could you
please send me a copy of the repo.

Thanks,
Clemens
