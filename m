From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 16:18:36 -0600
Message-ID: <E1E3LNk-0005f0-11@highlab.com>
References: <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org> <20050811202410.GB5411@kiste.smurf.noris.de> <42FBCD73.3090507@chandlerfamily.org.uk>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 00:17:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3LLs-0001Za-9Y
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 00:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVHKWQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 18:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVHKWQh
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 18:16:37 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:28037 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932444AbVHKWQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 18:16:37 -0400
Received: from highlab.com ([67.165.222.77])
          by comcast.net (sccrmhc12) with ESMTP
          id <20050811221632012005oo06e>; Thu, 11 Aug 2005 22:16:36 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1E3LNk-0005f0-11; Thu, 11 Aug 2005 16:18:36 -0600
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-reply-to: <42FBCD73.3090507@chandlerfamily.org.uk> 
Comments: In-reply-to Alan Chandler <alan@chandlerfamily.org.uk>
   message dated "Thu, 11 Aug 2005 23:13:07 +0100."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> Matthias Urlichs wrote:
> > A small Debian-specific patch to rename the offending scripts (and drop
> > the Conflicts: entries) is cheap.
> 
> Not sure I understand the proper use of dpkg-divert in Debian, but could 
> _this_ git-core package perhaps ask the user which set of the two 
> packages he wish to keep as git command and use dpkg-divert to change 
> the other to another name to some other name?

This may be a possibility.  I'm discussing the details of this kind of
solution on the debian-devel list right now.

Come join the fun!  I make a poor flame-conduit between the git list
and the debian-devel list, cut out the middle man and save.  ;-)


-- 
Sebastian Kuzminsky
