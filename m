From: Junio C Hamano <junkio@cox.net>
Subject: Re: [git-svn PATCH] Fix markup in git-svn man page
Date: Fri, 04 May 2007 15:06:45 -0700
Message-ID: <7vslacs0p6.fsf@assigned-by-dhcp.cox.net>
References: <20070504070003.9117.75385.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat May 05 00:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk5vP-0001PE-35
	for gcvg-git@gmane.org; Sat, 05 May 2007 00:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031509AbXEDWGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 18:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031562AbXEDWGs
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 18:06:48 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38688 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031509AbXEDWGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 18:06:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504220646.JZWD1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 18:06:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vA6m1W0081kojtg0000000; Fri, 04 May 2007 18:06:46 -0400
In-Reply-To: <20070504070003.9117.75385.stgit@yoghurt> (Karl =?utf-8?Q?Has?=
 =?utf-8?Q?selstr=C3=B6m's?=
	message of "Fri, 04 May 2007 09:03:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46222>

Looks sane to me.  I did not know about double-semicolon, which
is mentioned in the user guide documentation at the asciidoc
site but I could not tell how it is different from double-colon
form.  I am guessing (from the behaviour after applying your
patch) that it allows second level of listing...
