From: Tom Lord <lord@emf.net>
Subject: [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Wed, 20 Apr 2005 02:58:29 -0700 (PDT)
Message-ID: <200504200958.CAA04923@emf.net>
Cc: talli@museatech.net, torvalds@osdi.org
X-From: git-owner@vger.kernel.org Wed Apr 20 11:54:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOBuW-0007gv-6f
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 11:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVDTJ6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 05:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVDTJ6f
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 05:58:35 -0400
Received: from emf.emf.net ([205.149.0.19]:50187 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261535AbVDTJ6d (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 05:58:33 -0400
Received: (from lord@localhost) by emf.net (K/K) id CAA04923; Wed, 20 Apr 2005 02:58:29 -0700 (PDT)
To: gnu-arch-users@gnu.org, gnu-arch-dev@gnu.org, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


`git', by Linus Torvalds, contains some very good ideas and some
very entertaining source code -- recommended reading for hackers.

/GNU Arch/ will adopt `git':

>From the /Arch/ perspective: `git' technology will form the
basis of a new archive/revlib/cache format and the basis
of new network transports.

>From the `git' perspective, /Arch/ will replace the lame "directory
cache" component of `git' with a proper revision control system.

In my view, the core ideas in `git' are quite profound and deserve
an impeccable implementation.   This is practical because those ideas
are also pretty simple.

I started here:

   http://www.seyza.com/=clients/linus/tree/index.html

and for those interested in `git'-theory, a good place to start is

   http://www.seyza.com/=clients/linus/tree/src/liblob/index.html

(Linus is not literally a "client" of mine.  That's just the directory 
where this goes.)

-t
