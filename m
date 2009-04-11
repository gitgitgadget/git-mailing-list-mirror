From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn hangs
Date: Fri, 10 Apr 2009 19:09:19 -0700
Message-ID: <20090411020919.GA30267@dcvr.yhbt.net>
References: <49DE2796.4090406@bestmail.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Babka <babka@bestmail.us>
X-From: git-owner@vger.kernel.org Sat Apr 11 04:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsSgb-0004Xk-H7
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 04:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbZDKCJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 22:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbZDKCJV
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 22:09:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46691 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811AbZDKCJU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 22:09:20 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFB411309A;
	Sat, 11 Apr 2009 02:09:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49DE2796.4090406@bestmail.us>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116291>

Jim Babka <jim@babkas.info> wrote:
> I need some help. I have tried both the native Windows git (git version  
> 1.6.2.2.1669.g7eaf8, coming from Git-1.6.2.2-preview20090408) and the  
> git in Cygwin (git version 1.6.1.2), but I see almost the same behavior.  
> I try to run the following command and see the following results:

Hi Jim,

Can you test the clone operation from a Linux/Unix machine?  Does
git-svn on Windows work for you with other (public) repositories?  I
can't support Windows other than accepting patches from others.

-- 
Eric Wong
