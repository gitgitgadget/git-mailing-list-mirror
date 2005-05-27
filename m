From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 19:43:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 19:45:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbisM-00068u-TD
	for gcvg-git@gmane.org; Fri, 27 May 2005 19:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVE0RpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVE0Ro3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:44:29 -0400
Received: from gate.perex.cz ([82.113.61.162]:51433 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261969AbVE0Rnp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 13:43:45 -0400
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP
	id C988074831; Fri, 27 May 2005 19:43:44 +0200 (MEST)
Received: from pnote.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP
	id AB8371102F; Fri, 27 May 2005 19:43:44 +0200 (CEST)
Received: by pnote.perex-int.cz (Postfix, from userid 500)
	id 53BBD1875B; Fri, 27 May 2005 19:43:44 +0200 (CEST)
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 27 May 2005, Linus Torvalds wrote:

> On Fri, 27 May 2005, Jaroslav Kysela wrote:
> > 
> > 	I created new git tree for the ALSA project at:
> > 
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> 
> Your scripts(?) to generate these things are a bit strange, since they
> leave an extra empty line in the commit message, which confuses at least
> gitweb (ie just look at
> 
>    http://www.kernel.org/git/?p=linux/kernel/git/perex/alsa.git;a=summary
> 
> and note how the summary thing looks empty).

Okay, sorry for this small bug. I'll recreate the ALSA git tree with
proper comments again. Also, the author is not correct (should be taken
from the first Signed-off-by:).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
