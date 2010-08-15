From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: fix regex to remove "tail" from svn tags
Date: Sun, 15 Aug 2010 23:48:33 +0000
Message-ID: <20100815234833.GA4359@dcvr.yhbt.net>
References: <1281878155-61937-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 01:48:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okmwe-0000qq-Sg
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 01:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab0HOXsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 19:48:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48031 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab0HOXse (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 19:48:34 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD8F1F761;
	Sun, 15 Aug 2010 23:48:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1281878155-61937-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153630>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>

Thank you David,

I've acked and pushed out both patches to git://git.bogomips.org/git-svn
for Junio

David D. Kilzer (2):
      git-svn: fix regex to remove "tail" from svn tags
      git-svn: fix fetch with deleted tag

-- 
Eric Wong
