From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: mangle refnames forbidden in git
Date: Sun, 9 May 2010 01:35:00 -0700
Message-ID: <20100509083500.GB12627@dcvr.yhbt.net>
References: <4BE3249B.7050100@theblacksun.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Torsten Schmutzler <git-ts@theblacksun.eu>
X-From: git-owner@vger.kernel.org Sun May 09 10:35:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB1ye-0006dm-Ed
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 10:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab0EIIfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 04:35:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59529 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab0EIIfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 04:35:00 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44EE61F449;
	Sun,  9 May 2010 08:35:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4BE3249B.7050100@theblacksun.eu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146713>

Torsten Schmutzler <git-ts@theblacksun.eu> wrote:
> git-check-ref-format(1) describes names which
> cannot be used as refnames for git.  Some are
> legal branchnames in subversion however.
> Mangle the not yet handled cases.
> 
> Signed-off-by: Torsten Schmutzler <git-ts@theblacksun.eu>

Thanks,

Acked-by: Eric Wong <normalperson@yhbt.net>

...and pushed out to git://git.bogomips.org/git-svn

-- 
Eric Wong
