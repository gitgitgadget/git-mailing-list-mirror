From: Daniel Cheng <j16sdiz+freenet@gmail.com>
Subject: Re: [JGIT PATCH 3/5] Test case for pack index CRC32 when written
 by PackWriter
Date: Thu, 26 Mar 2009 23:35:01 +0800
Message-ID: <49CBA0A5.6090804@gmail.com>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org> <1238030515-31768-2-git-send-email-spearce@spearce.org> <1238030515-31768-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 16:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmri6-0003Dc-RV
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 16:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423AbZCZPkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 11:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414AbZCZPkH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 11:40:07 -0400
Received: from main.gmane.org ([80.91.229.2]:51612 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756349AbZCZPkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 11:40:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LmrgY-00022r-V8
	for git@vger.kernel.org; Thu, 26 Mar 2009 15:40:03 +0000
Received: from 116.49.49.110 ([116.49.49.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 15:40:02 +0000
Received: from j16sdiz+freenet by 116.49.49.110 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 15:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 116.49.49.110
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1238030515-31768-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114793>

Shawn O. Pearce wrote:
> Suggested-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../tst/org/spearce/jgit/lib/PackWriterTest.java   |   33 ++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 

Thanks.


-- 
