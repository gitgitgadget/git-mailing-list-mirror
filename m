From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: allow the mergeinfo property to be set
Date: Fri, 24 Sep 2010 16:27:04 +0000
Message-ID: <20100924162704.GA4513@dcvr.yhbt.net>
References: <1285289553-17998-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 18:27:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzB79-0005Sa-SP
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463Ab0IXQ1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:27:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47984 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445Ab0IXQ1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:27:05 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B407D1F970;
	Fri, 24 Sep 2010 16:27:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1285289553-17998-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157019>

Steven Walter <stevenrwalter@gmail.com> wrote:
> As a first step towards preserving merges across dcommit, we need a
> mechanism to update the svn:mergeinfo property.
> ---

Hi Steven, this looks reasonable.  Sign-off?  A test would be nice, too.

-- 
Eric Wong
