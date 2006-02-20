From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Prepend the history of one git tree to another
Date: Mon, 20 Feb 2006 13:20:52 +0100
Message-ID: <20060220122052.GD5318@cip.informatik.uni-erlangen.de>
References: <20060220090909.GT6558@cip.informatik.uni-erlangen.de> <43F99684.5070403@op5.se> <20060220104345.GG26454@cip.informatik.uni-erlangen.de> <43F9A0B3.6020304@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 13:21:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBA2C-00071K-W3
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 13:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWBTMUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 07:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWBTMUy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 07:20:54 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:40119 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S964920AbWBTMUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 07:20:53 -0500
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id A573A305DC; Mon, 20 Feb 2006 13:20:52 +0100 (CET)
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <43F9A0B3.6020304@michonline.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16480>

Hello,

> I wrote a program called "graft-ripple", that takes a commit, and
> rewrites the current branch's history to reflect as if it started at
> that commit. It doesn't ever actually work with diffs or anything, it
> just reads commits and trees and recreates them.

> http://www.gelato.unsw.edu.au/archives/git/0511/12965.html

that is *exactly* what I was looking for. Thanks.

> Hope this helps!

Well it does!

Thanks,
        Thomas
