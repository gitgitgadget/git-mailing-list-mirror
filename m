From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Segmentation fault in git-svn
Date: Wed, 18 Apr 2007 02:01:43 -0700
Message-ID: <20070418090143.GA11894@muzzle>
References: <4623F613.5010108@midwinter.com> <20070417093743.GA9222@muzzle> <20070417095509.GA24800@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 11:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He62w-00018V-Di
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 11:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbXDRJBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 05:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbXDRJBq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 05:01:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55388 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422653AbXDRJBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 05:01:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 222852DC01A;
	Wed, 18 Apr 2007 02:01:44 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 18 Apr 2007 02:01:43 -0700
Content-Disposition: inline
In-Reply-To: <20070417095509.GA24800@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44874>

Eric Wong <normalperson@yhbt.net> wrote:
> This disables some pool allocations, forcing it to use the
> global one.

The verdict is still out on all patches and attempts I've posted
to fix the segfault.  I'm quite busy at the moment and won't
be attending to git-svn things for another few days.

-- 
Eric Wong
