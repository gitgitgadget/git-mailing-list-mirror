From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG] git-svn: --no-metadata related bug
Date: Wed, 7 Sep 2011 03:39:15 +0000
Message-ID: <20110907033915.GA415@dcvr.yhbt.net>
References: <20110405190722.GB25644@kytes>
 <4D9C64EB.5060703@drmicha.warpmail.net>
 <20110406181234.GB667@kytes>
 <1315033269582-6756044.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: DaveAbrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 05:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R18yw-00037I-FD
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 05:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab1IGDjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 23:39:18 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44328 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144Ab1IGDjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 23:39:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B343E21095;
	Wed,  7 Sep 2011 03:39:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1315033269582-6756044.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180850>

DaveAbrahams <dave@boostpro.com> wrote:
> I am reproducing the problem here.  Unfortunately I can't share the
> repository with you but I'm willing to try debugging it a bit.

Which version of git/git-svn are you using? (run: "git svn --version")
Can you reproduce it with newer versions?  (I can't)

-- 
Eric Wong
