From: Paul Mackerras <paulus@samba.org>
Subject: Re: [gitk] [PATCH] Fix selection of tags.
Date: Thu, 19 Nov 2009 20:33:23 +1100
Message-ID: <19205.4323.125029.520399@cargo.ozlabs.ibm.com>
References: <87r5s0vnas.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Nov 19 10:33:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB3OO-0000vR-Pn
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 10:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbZKSJdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 04:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbZKSJdV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 04:33:21 -0500
Received: from ozlabs.org ([203.10.76.45]:56566 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbZKSJdU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 04:33:20 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6879B1007D1; Thu, 19 Nov 2009 20:33:26 +1100 (EST)
In-Reply-To: <87r5s0vnas.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133220>

Pat Thoyts writes:

> When a tag is clicked an error is raised due to a missing parameter in
> a function call.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Thanks, applied.

Paul.
