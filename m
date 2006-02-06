From: Olaf Hering <olh@suse.de>
Subject: Re: git-bisect doesnt record bad commits
Date: Mon, 6 Feb 2006 23:24:48 +0100
Message-ID: <20060206222448.GA9196@suse.de>
References: <20060206215442.GA12209@suse.de> <Pine.LNX.4.64.0602061417510.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 23:24:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6En0-0000wS-2m
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 23:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWBFWYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 17:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWBFWYv
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 17:24:51 -0500
Received: from ns2.suse.de ([195.135.220.15]:20688 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932395AbWBFWYu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 17:24:50 -0500
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 30ED31CC39;
	Mon,  6 Feb 2006 23:24:49 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602061417510.3854@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15666>

 On Mon, Feb 06, Linus Torvalds wrote:

> 
> 
> On Mon, 6 Feb 2006, Olaf Hering wrote:
> > 
> > Is there a reason why git-bisect does only record good ones? I would
> > really like to know which commits did crash for me. :(
> 
> It does. Look in the bisection log (".git/BISECT_LOG").

Thats good enough for me to restore my steps, I think. Thanks.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
