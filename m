From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: don't introduce new paragraph for git-svn-id
Date: Wed, 1 Aug 2012 23:01:18 +0000
Message-ID: <20120801230118.GA15479@dcvr.yhbt.net>
References: <1343856197-6393-1-git-send-email-robert@debian.org>
 <20120801214318.GA10384@dcvr.yhbt.net>
 <5019AD3A.8030609@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:01:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swhuu-00030n-FR
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 01:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab2HAXBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 19:01:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49893 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab2HAXBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 19:01:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9111F7BA;
	Wed,  1 Aug 2012 23:01:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5019AD3A.8030609@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202740>

Robert Luberda <robert@debian.org> wrote:
> Eric Wong wrote:
> > How about making this optional and configurable at init/clone time?
> 
> I don't think it will be hard to make it configurable. I can try to make
> such a change, do you have any preferences about the option and
> configuration key names?

No preference off the top of my head.  As long as it makes sense to
enough people here and is consistent in style with existing options in
git.

Thanks.
