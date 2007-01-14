From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: What's in git.git and announcing GIT v1.5.0-rc1
Date: Mon, 15 Jan 2007 01:36:09 +0200
Message-ID: <45AABE69.1070505@cc.jyu.fi>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VbT-00037T-4y
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:26:39 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8j-0003eK-2y
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbXAOB06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 20:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbXAOB06
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 20:26:58 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:59822 "EHLO posti5.jyu.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbXAOB06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 20:26:58 -0500
X-Greylist: delayed 6680 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 20:26:57 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id l0ENZYBe010142;
	Mon, 15 Jan 2007 01:35:34 +0200
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Received: from posti5.jyu.fi ([127.0.0.1])
	by localhost (posti5.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bARBg1FRLS0h; Mon, 15 Jan 2007 01:35:33 +0200 (EET)
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.120])
	by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id l0ENZWDE010137;
	Mon, 15 Jan 2007 01:35:33 +0200
Received: from [127.0.0.1] (aragorn2.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id 6B2E34680B1;
	Mon, 15 Jan 2007 01:36:09 +0200 (EET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070111)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36821>

Junio C Hamano wrote:
> The tip of 'master' branch is tagged as v1.5.0-rc1; this means a
> few things:
>   
Hi

Would it make sense to add something like this to the announcements as
it is not very easy to find references to the git-repository itself from
the net.

   You can get the git repository-itself by using a following commands

           git-clone git://git.kernel.org/pub/scm/git/git.git git_repo

   After that you can switch to tagged version <v1.5.0-rc1> or sources
from the repository by using command

          git-checkout -f v1.5.0-rc1 master

   Alternatively you can download the tar packed version of sources from
      
          http://www.kernel.org/pub/software/scm/git/

Mika
