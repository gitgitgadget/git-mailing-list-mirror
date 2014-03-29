From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 099/144] t9101-git-svn-props.sh: use the $( ... )
 construct for command substitution
Date: Sat, 29 Mar 2014 23:50:47 +0000
Message-ID: <20140329235047.GA20815@dcvr.yhbt.net>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
 <1395735989-3396-100-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 00:56:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU37I-0000eF-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 00:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbaC2X4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 19:56:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59816 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbaC2X4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 19:56:12 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Mar 2014 19:56:12 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8B520C94;
	Sat, 29 Mar 2014 23:50:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1395735989-3396-100-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245450>

Elia Pinto <gitter.spiros@gmail.com> wrote:
> The Git CodingGuidelines prefer the $( ... ) construct for command
> substitution instead of using the back-quotes, or grave accents (`..`).

I did not check very closely, but for the git-svn tests:
Acked-by: Eric Wong <normalperson@yhbt.net>
Thanks.
