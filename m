From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH] guilt-header: Add -e option for editing
Date: Mon, 30 Jul 2007 15:09:54 -0400
Message-ID: <20070730190954.GA17253@filer.fsl.cs.sunysb.edu>
References: <87r6mqarkb.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Sipek <jsipek@cs.sunysb.edu>,
	Git mailing list <git@vger.kernel.org>
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFadh-0002qO-71
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 21:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967953AbXG3TKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 15:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967835AbXG3TKL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 15:10:11 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53216 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967875AbXG3TKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 15:10:09 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6UJ9s0o017625;
	Mon, 30 Jul 2007 15:09:54 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6UJ9skV017623;
	Mon, 30 Jul 2007 15:09:54 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <87r6mqarkb.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54250>

On Mon, Jul 30, 2007 at 07:34:28AM -0700, Eric Lesh wrote:
> Signed-off-by: Eric Lesh <eclesh@ucla.edu>
> ---
>  Documentation/guilt-header.txt |    6 ++++--
>  guilt                          |    9 +++++++++
>  guilt-header                   |   20 +++++++++++++++++---
>  3 files changed, 30 insertions(+), 5 deletions(-)

Applied. Right after applying your patch, I decided to clean things up a
bit. This includes removal of the scan of the series => not needed as we
already know the patch name anyway.

Thanks,

Josef 'Jeff' Sipek.

-- 
I already backed up the [server] once, I can do it again.
