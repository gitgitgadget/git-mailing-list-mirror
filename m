From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Fix parsing peeled line in packed-ref
Date: Fri, 6 Mar 2009 08:19:15 -0800
Message-ID: <20090306161915.GK16213@spearce.org>
References: <1236355550-5764-1-git-send-email-j16sdiz+freenet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@sdiz.net>
To: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:20:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfcmz-0001yh-Fe
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbZCFQTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754708AbZCFQTR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:19:17 -0500
Received: from george.spearce.org ([209.20.77.23]:55450 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZCFQTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:19:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2E84038211; Fri,  6 Mar 2009 16:19:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236355550-5764-1-git-send-email-j16sdiz+freenet@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112462>

"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com> wrote:
> From: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@sdiz.net>
> 
> When doing a WalkTransport with packed-ref, peeled
> line are not handled correctly. This patch fix the issue.
> 
> Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>

Thanks.  Fix pushed.

-- 
Shawn.
