From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: fix typo when diffing committed -> staged
Date: Tue, 3 Nov 2009 22:32:42 +1100
Message-ID: <19184.5338.488429.366571@cargo.ozlabs.ibm.com>
References: <4AE72A46.5040201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 12:33:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Hdh-00020U-BU
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 12:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbZKCLdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 06:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbZKCLdS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 06:33:18 -0500
Received: from ozlabs.org ([203.10.76.45]:56778 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbZKCLdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 06:33:08 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5AEC1B7BE5; Tue,  3 Nov 2009 22:33:08 +1100 (EST)
In-Reply-To: <4AE72A46.5040201@web.de>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131967>

Jens Lehmann writes:

> When highlighting a commit, using the context menu over the staged changes
> and then selecting "Diff this -> selected" the diff was empty. The same
> happened when highlighting the staged changes and using "Diff selected ->
> this" over a commit.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>

Thanks, applied.

Paul.
