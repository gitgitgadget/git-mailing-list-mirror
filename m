From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: Re: [PATCH] whitespace: reorganize initial-indent check
Date: Sun, 16 Dec 2007 11:31:36 -0500
Message-ID: <1197822702-5262-1-git-send-email-bfields@citi.umich.edu>
References: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 17:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3wPU-0006dk-Ls
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 17:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087AbXLPQbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 11:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933035AbXLPQbo
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 11:31:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60075 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762209AbXLPQbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 11:31:43 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3wP0-0001Qf-KX; Sun, 16 Dec 2007 11:31:42 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68468>

Wincent Colaiuta wrote:
> Any chance of either squashing this series into one patch seeing as
> its all churning over the same part of the code, or resending it with
> numbering?  The patches seemed to arrive out of order in my mailbox
> and I don't really know what order they're supposed to be applied in
> and it's a bit hard to review.

Apologies--I forgot the -n on format-patch.... Here you go.  Thanks for
the review.

--b.
