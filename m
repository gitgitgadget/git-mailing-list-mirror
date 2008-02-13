From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Heed the lines of context in merge commits.
Date: Thu, 14 Feb 2008 10:50:43 +1100
Message-ID: <18355.33363.669732.192506@cargo.ozlabs.ibm.com>
References: <47B31A72.7020502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 01:09:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPRf0-0007XK-Ro
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 01:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760838AbYBNAId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 19:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762466AbYBNAIc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 19:08:32 -0500
Received: from ozlabs.org ([203.10.76.45]:50185 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758645AbYBNAIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 19:08:30 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id A2426DDF3E; Thu, 14 Feb 2008 11:08:29 +1100 (EST)
In-Reply-To: <47B31A72.7020502@viscovery.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73830>

Johannes Sixt writes:

> There is an edit box where the number of context lines can be chosen.
> But it was only used when regular diffs were displayed, not for
> merge commits. Fix this.

Thanks, applied.

Paul.
