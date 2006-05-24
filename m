From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 24 May 2006 15:40:48 -0700
Message-ID: <7v64jv59n3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu May 25 00:41:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj229-0006GJ-FS
	for gcvg-git@gmane.org; Thu, 25 May 2006 00:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWEXWku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 May 2006 18:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWEXWku
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 18:40:50 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32985 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964776AbWEXWkt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 18:40:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524224049.UZJK27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 18:40:49 -0400
To: git@vger.kernel.org
X-maint-at: be0c7e069738fbb697b0719f2252107261c9340e
X-master-at: 4d548150ace0816dd5fe678cdbde75b13d5e5249
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20707>

* The 'master' branch has these since the last announcement.

 - lift length limits from mktag (Bj=F6rn Engelmann)

 - misc fixes and cleanups (Alex Riesen, Bj=F6rn Engelmann,
   Linus, Martin Waitz, Peter Eriksen, Sean Estabrooks)

 - git-svn updates, ignores svn:keywords (Eric Wong)

 - documentation updates (J. Bruce Fields)

 - cvsimport updates (Jeff King, Martin Langhoff)

 - built-in format-patch (Johannes Schindelin)

 - built-in many commands (Linus, Peter Eriksen, Timo Hirvonen, me)

 - remote tar-tree

 - "git status -u" (Matthias Lederhofer)

 - more cygwin portability bits (Yakov Lerner)

* The 'next' branch, in addition, has these.

 - handle patches at the beginning and the end of file properly
   (Catalin Marinas, Linus)

 - mailinfo updates (Eric W. Biederman).

 - cache-tree to speed up "apply & write-tree" cycle.

 - http-fetch possible segfault fix (Sean Estabrooks)

 - ref-log (Shawn Pearce)
