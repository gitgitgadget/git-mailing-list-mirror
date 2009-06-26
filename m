From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: Fix t9138-multiple-branches to use svn_cmd
	and (cd ...) syntax.
Date: Fri, 26 Jun 2009 14:54:52 -0700
Message-ID: <20090626215452.GC25118@dcvr.yhbt.net>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net> <4A451F8A.9060501@xiplink.com> <20090626205738.GB25118@dcvr.yhbt.net> <4A4538C3.5060901@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:55:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKJNv-0001Vj-Ll
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 23:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbZFZVyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbZFZVyv
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 17:54:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40247 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbZFZVyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 17:54:50 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1781F44D;
	Fri, 26 Jun 2009 21:54:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A4538C3.5060901@xiplink.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122327>

Marc Branchaud <marcnarc@xiplink.com> wrote:
> ---
> 
> This is against the master branch of Eric's git://git.bogomips.org/git-svn repo.
> 
> Eric, if there's anything else I can do to help this along please let me know!

Thanks Marc, sign-off?

-- 
Eric Wong
