From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 11:12:49 +0200
Message-ID: <20070804091249.GA17821@uranus.ravnborg.org>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr> <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com> <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 11:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHFfs-0004h2-1D
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 11:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759336AbXHDJLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 05:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759204AbXHDJLf
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 05:11:35 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:59791 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758091AbXHDJLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 05:11:34 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 91B65E31476;
	Sat,  4 Aug 2007 11:11:31 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 02631580D2; Sat,  4 Aug 2007 11:12:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46B418AA.4070701@midwinter.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54816>

On Sat, Aug 04, 2007 at 02:11:54PM +0800, Steven Grimm wrote:
> Junio C Hamano wrote:
> >If I read you correctly, what you are proposing to offer is a
> >clone of asciidoc, perhaps AsciiDoc 7, with only xhtml11 and man
> >backends.  It is a subset in the sense that you will do only two
> >backends, but otherwise is a clone in the sense that you are
> >going to implement the input language we use (one thing I
> >personally care about while probably other people do not is the
> >conditional compilation "ifdef::stalenotes[]" in git.txt).
> >  
> 
> Yes and no. I am not offering to clone *all* of AsciiDoc, just whatever 
> subset is necessary to format the git documentation. (Of course, having 
> looked at this very little so far, perhaps that really is all of 
> AsciiDoc -- but it's certainly not all of xmlto.)

Never looked at Ascii-doc... but how about finding the loopholes
in Ascii-doc to make it 10x faster?
That would benefit a larger user-base than just doing-it-ourself.

	Sam
