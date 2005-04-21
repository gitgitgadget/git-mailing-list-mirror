From: Tom Lord <lord@emf.net>
Subject: Re: [Gnu-arch-users] Re: [GNU-arch-dev] [ANNOUNCEMENT] /Arch/
	embraces `git'
Date: Thu, 21 Apr 2005 13:35:27 -0700 (PDT)
Message-ID: <200504212035.NAA06342@emf.net>
References: <1114037509.5880.62.camel@perun.redhat.usu>
Cc: duchier@ps.uni-sb.de, gnu-arch-dev@lists.seyza.com,
	talli@museatech.net, git@vger.kernel.org, torvalds@osdi.org
X-From: git-owner@vger.kernel.org Thu Apr 21 22:31:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOiKO-0008Hj-DE
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 22:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVDUUfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDUUfg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:35:36 -0400
Received: from emf.emf.net ([205.149.0.19]:16132 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261862AbVDUUfc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 16:35:32 -0400
Received: (from lord@localhost) by emf.net (K/K) id NAA06342; Thu, 21 Apr 2005 13:35:27 -0700 (PDT)
To: t8m@centrum.cz
In-reply-to: <1114037509.5880.62.camel@perun.redhat.usu> (message from Tomas Mraz on Thu, 21 Apr 2005 00:51:49 +0200)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



   > Yes, it really doesn't make much sense to have so big keys on the
   > directories.

It's official... i'm blushing wildly.... thank you for the various
replies that pointed out my thinko.

That part of my spec hasn't been coded yet --- i just wrote text.  It
really was the silly late-night error of sort: "hmm...let's see, 4 hex
digits plus 4 hex digits .... that's 16 bits.... sounds about right."

Really, I'll fix it.

-t
