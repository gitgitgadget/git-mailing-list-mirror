From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] prefer "git COMMAND" over "git-COMMAND" in gitk
Date: Wed, 21 Mar 2007 22:04:45 +1100
Message-ID: <17921.4429.408665.577258@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0703191746150.5525@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 21 12:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTycj-0006Dd-S9
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 12:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXCULEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 07:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbXCULEz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 07:04:55 -0400
Received: from ozlabs.org ([203.10.76.45]:60340 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbXCULEy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 07:04:54 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id F0309DDE24; Wed, 21 Mar 2007 22:04:52 +1100 (EST)
In-Reply-To: <Pine.LNX.4.64.0703191746150.5525@torch.nrlssc.navy.mil>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42784>

Brandon Casey writes:

> Preferring git _space_ COMMAND over git _dash_ COMMAND allows the
> user to have only git and gitk in their path. e.g. when git and gitk
> are symbolic links in a personal bin directory to the real git and gitk.

Thanks for the patch.  It was whitespace-damaged but I fixed it up
(this once) and applied it.  Also, if you send any larger patches in
future I'd like a Signed-off-by line with them (this one was trivial
enough that I applied it without).

Paul.
