From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT on MinGW problem
Date: Fri, 11 May 2007 18:17:51 -0700
Message-ID: <7vveey7scg.fsf@assigned-by-dhcp.cox.net>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Aaron Gray" <angray@beeb.net>
X-From: git-owner@vger.kernel.org Sat May 12 03:17:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmgFB-000072-53
	for gcvg-git@gmane.org; Sat, 12 May 2007 03:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671AbXELBRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 21:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759057AbXELBRw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 21:17:52 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52276 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671AbXELBRw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 21:17:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512011752.HXDG24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 21:17:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id y1Hr1W0091kojtg0000000; Fri, 11 May 2007 21:17:51 -0400
In-Reply-To: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> (Aaron Gray's message of
	"Sat, 12 May 2007 02:13:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47008>

"Aaron Gray" <angray@beeb.net> writes:

> Hello,
>
> I have installed the git-1.5.1-1.mingw.exe from
> http://lilypond.org/git/binaries/mingw/.
>
> On typing 'git' I get a message box saying :-
>
>        The procedure entry point libiconv could not be located in the
> dynamic link library libiconv-2.dll.
>
> I cannot seem to find libiconv-2.dll anywhere either.
>
> Hope you can help.
>
> Many thanks in advance,
>
> Aaron

Even myself (who does not have anything to do with Windows
machines) remembers seeing this exact thing in the past 12
hours:

	article.gmane.org/gmane.comp.version-control.git/46962

Please check the archive before asking.  Thanks.
