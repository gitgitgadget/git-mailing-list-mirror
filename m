From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH guilt] guilt-rebase: Make fast-forward work
Date: Sat, 28 Jul 2007 16:40:43 -0400
Message-ID: <20070728204043.GB6240@filer.fsl.cs.sunysb.edu>
References: <87d4ycen0r.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Sipek <jsipek@cs.sunysb.edu>,
	Git mailing list <git@vger.kernel.org>
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:41:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEt68-0000YV-37
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 22:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbXG1Ukz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 16:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbXG1Ukz
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 16:40:55 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:41537 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097AbXG1Ukz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 16:40:55 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6SKeh1Y006691;
	Sat, 28 Jul 2007 16:40:43 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6SKehtv006689;
	Sat, 28 Jul 2007 16:40:43 -0400
Content-Disposition: inline
In-Reply-To: <87d4ycen0r.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54063>

On Sat, Jul 28, 2007 at 05:22:12AM -0700, Eric Lesh wrote:
> Merges created with --no-commit and a blank commit message didn't update
> the branch's HEAD in a fast-forward merge. Rebasing didn't actually do
> anything in that case.
> 
> Also quote the log message when displaying the new HEAD.
 
Applied. Thanks.

Josef 'Jeff' Sipek.

-- 
You measure democracy by the freedom it gives its dissidents, not the
freedom it gives its assimilated conformists.
		- Abbie Hoffman
