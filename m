From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/4] git-instaweb: Improving handling of
 --start/--restart
Date: Tue, 28 Jun 2011 03:22:20 +0000
Message-ID: <20110628032220.GA32199@dcvr.yhbt.net>
References: <201106232129.22137.jnareb@gmail.com>
 <20110623194624.18265.82482.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gurjeet Singh <singh.gurjeet@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 05:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbOv4-0005Hy-O2
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 05:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357Ab1F1DW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 23:22:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40757 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab1F1DWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 23:22:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74F2296893;
	Tue, 28 Jun 2011 03:22:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110623194624.18265.82482.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176379>

Jakub Narebski <jnareb@gmail.com> wrote:
> This series fixes the issue reported by Gurheet Singh in "Having some
> problem with instaweb", in that --start/--restart doesn't generate
> configuration, which is documented:

Everything looks reasonable, thanks!  Acked and pushed to "instaweb"
branch on git://bogomips.org/git-svn.git

-- 
Eric Wong
