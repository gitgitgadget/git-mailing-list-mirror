From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 00:03:42 +0800
Message-ID: <46B4A35E.5040601@midwinter.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>	<200708040341.36147.ismail@pardus.org.tr>	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>	<46B3F762.1050306@midwinter.com>	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>	<46B418AA.4070701@midwinter.com>	<20070804091249.GA17821@uranus.ravnborg.org>	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHM6Y-0002vf-Jh
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbXHDQDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbXHDQDr
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:03:47 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:52105 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751808AbXHDQDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:03:46 -0400
Received: (qmail 29665 invoked from network); 4 Aug 2007 16:03:46 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=qV0Du9qbf1GHnHiiKQ3Io/RsBO/WfXkYCdvBWi1z5Ro3IdF/mbWceGp1QZpKSTYM  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 4 Aug 2007 16:03:45 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <85zm17h4pn.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54871>

David Kastrup wrote:
> A system such as info, in contrast, is hierarchical, and organized
> with indexes and cross references making it much easier to find
> things.

Really? I find info a huge pain in the butt most of the time. I can't 
just do a simple text search for the information I want in the relevant 
manpage; I have to go navigating around to the appropriate subsection 
(and that's assuming I know where it is) and am forced to use the 
emacs-style pager whether I like it or not (not a big emacs fan here). 
It always ticks me off when I go to read the manpage for some command 
and it tells me to go read the info page if I want complete documentation.

I would definitely not want to move to a documentation system that 
prevented me from typing "man git-commit" to get a list of all the 
command line options for that command.

However, that said, I have no objection to an alternate view of the same 
information that's organized differently.

Am I alone in my dislike of info, I wonder?

-Steve
