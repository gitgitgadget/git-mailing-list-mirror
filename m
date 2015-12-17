From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: test for git-svn prefixed globs
Date: Thu, 17 Dec 2015 00:32:09 +0000
Message-ID: <20151217003209.GA32491@dcvr.yhbt.net>
References: <1450270869-29822-1-git-send-email-vleschuk@accesssoftek.com>
 <1450270869-29822-3-git-send-email-vleschuk@accesssoftek.com>
 <20151216212811.GA19884@dcvr.yhbt.net>
 <5671D82B.8020107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 01:32:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9MUQ-0001Vd-Fm
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 01:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbbLQAcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 19:32:10 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60105 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbbLQAcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 19:32:09 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8A66338A3;
	Thu, 17 Dec 2015 00:32:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5671D82B.8020107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282628>

Victor Leschuk <vleschuk@gmail.com> wrote:
> Hello Eric, sorry, I just copy pasted your old
> t9108-git-svn-glob.sh, changed branch names to be prefixed and added
> test for "exact" prefix match. If it is necessary I can rewrite it
> according to current guidelines.

Yes, please do if you can.  I can do it if you're willing to wait a bit.
