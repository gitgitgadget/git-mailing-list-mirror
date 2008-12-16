From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git-scm.com transition
Date: Tue, 16 Dec 2008 12:41:39 +0100
Message-ID: <20081216114138.GM12856@machine.or.cz>
References: <d411cc4a0812151007n1be9ce95h92c8c11592ea5f9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 12:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCYKg-0006QR-Ii
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 12:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813AbYLPLlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 06:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758101AbYLPLlp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 06:41:45 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49146 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758055AbYLPLln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 06:41:43 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 09C683939A0C; Tue, 16 Dec 2008 12:41:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d411cc4a0812151007n1be9ce95h92c8c11592ea5f9d@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103271>

  Hi,

On Mon, Dec 15, 2008 at 10:07:05AM -0800, Scott Chacon wrote:
> I've been working on some docs, like an easy reference, that I could
> put up at git-scm.com.  I was wondering if we were still planning on
> transitioning the site from git.or.cz -> git-scm.com?

  sure - I just need to be prodded about it, as I said. ;-)

> Is there anything I need to do to help you with that?  Are there any
> elements missing still?

  hmm... I'm really busy before the end of the year, but this should
take just a really short while by now, so let's see if there are still
some nits:

	"$ git clone git://github.com/git/hello-world.git" on the
frontpage overflows from the box for me, and so does "git commit -m
'Initial commit'" in the other box. I work on smallish notebook with
1024x768 resolution, but there are still wide white stripes on the
sides.

	Mention FAQ in the "Got a question?" box?

	Migrate the SVN crash course to git-scm.com too? Would make
sense, imho. Or maybe we can just throw it on the wiki.

	Has anyone reviewed " Pragmatic Version Control Using Git by
Travis Swicegood " if we advertise it on the homepage? I remember
looking at some very early preview and feeling quite uncomfortable
about it. Mentioning a book on the homepage is some kind of an
endorsement.

	Merge "Multimedia" into "Videos"?

	I'm wondering if the "Related Tools" section shouldn't get a
kind of facelift (as e.g. by now imho people are perceiving gitk,
git-gui and gitweb all as integral git components, you might want to
mention TopGit instead of Cogito, etc.) and the 4x4 format is probably
not too appropriate (the hosting sites aren't a natural fit there, and I
chose it originally only to reduce the vertical length of the
single-page homepage). But that's certainly not a blocking issue for the
redirect.

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
