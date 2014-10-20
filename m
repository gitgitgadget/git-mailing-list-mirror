From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn.txt: advertise pushurl with dcommit
Date: Mon, 20 Oct 2014 03:59:18 +0000
Message-ID: <20141020035918.GA27885@dcvr.yhbt.net>
References: <1412894999-5961-1-git-send-email-sveinung84@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 05:59:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg485-0007A4-R7
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 05:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbaJTD7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 23:59:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34316 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaJTD7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 23:59:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60801F8B3;
	Mon, 20 Oct 2014 03:59:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1412894999-5961-1-git-send-email-sveinung84@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net> wrote:
> Advertise that the svn-remote.<name>.pushurl config key allows specifying
> the commit URL for the entire SVN repository in the documenation of git
> svn's dcommit command.
> 
> Signed-off-by: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>

Thanks, minor grammar+spelling fix to the commit message:

    Advertise that the svn-remote.<name>.pushurl config key allows specifying
    the commit URL for the entire SVN repository in the documentation of the
    git svn dcommit command.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

Pushed with updated commit message to "master" of git://bogomips.org/git-svn
