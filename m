From: Junio C Hamano <junkio@cox.net>
Subject: Re: qgit reports errors in the git repository
Date: Fri, 16 Dec 2005 13:37:16 -0800
Message-ID: <7virtoenar.fsf@assigned-by-dhcp.cox.net>
References: <1134433440.3798.27.camel@dv>
	<Pine.LNX.4.64.0512121700010.15597@g5.osdl.org>
	<1134624477.5360.6.camel@dv>
	<e5bfff550512150501v48bb65abwf44b3fc21f33bdf6@mail.gmail.com>
	<1134665095.27212.22.camel@dv>
	<e5bfff550512151100k33a66db5tdb2eb1ff2da10a59@mail.gmail.com>
	<1134693349.22652.22.camel@dv>
	<e5bfff550512152258t3f7b2eb1i1c709572b18fe3f7@mail.gmail.com>
	<1134757942.2248.11.camel@dv>
	<e5bfff550512161247v4c187cc0gedae8234d454c3b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 22:39:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnNGV-0002ZY-Lz
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVLPVhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVLPVhT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:37:19 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24017 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932389AbVLPVhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:37:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216213519.BIB20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 16:35:19 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550512161247v4c187cc0gedae8234d454c3b6@mail.gmail.com>
	(Marco Costalba's message of "Fri, 16 Dec 2005 21:47:58 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13756>

Marco Costalba <mcostalba@gmail.com> writes:

> Type information is already available in git-ls-remote.sh...

???? is it ???? where and how ????

The only thing you know is where things are, and optionally if
that thing is a tag object or not (by presense or lack of
corresponding "it^{}").
