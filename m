From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH v3] git-svn: New flag to emulate empty directories
Date: Wed, 17 Aug 2011 13:39:34 -0700
Message-ID: <20110817203934.GC24581@dcvr.yhbt.net>
References: <1311201446-26895-1-git-send-email-rchen@cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Ray Chen <rchen@cs.umd.edu>
X-From: git-owner@vger.kernel.org Wed Aug 17 22:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtmwP-0002Ij-JX
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 22:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab1HQUjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 16:39:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50353 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329Ab1HQUje (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 16:39:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E02221091;
	Wed, 17 Aug 2011 20:39:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1311201446-26895-1-git-send-email-rchen@cs.umd.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179536>

Ray Chen <rchen@cs.umd.edu> wrote:
> Is anybody else willing to review this patch?  I'd feel better if we had more
> than two sets of eyes look this over.

We haven't heard anything in a few weeks.  Everything looks acceptable
to me.  I'm inclined to just accept it since it's unlikely to break
existing functionality.

-- 
Eric Wong
