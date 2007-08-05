From: Bruce Korb <bkorb@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 14:43:09 -0700
Organization: Free Software Foundation
Message-ID: <46B6446D.4030607@gnu.org>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr> <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com> <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com> <20070804091249.GA17821@uranus.ravnborg.org> <46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org> <85myx7dwb3.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org> <85bqdndqgr.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org> <85bqdmctcl.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708051004480.5037@woody.linux-foundation.org> <85bqdlj1lh.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708051221290.5037@woody.linux-foundat
 ion.org>
Reply-To: bkorb@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHo0c-0008QP-AB
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 23:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbXHEVvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 17:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbXHEVvY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 17:51:24 -0400
Received: from flpi101.sbcis.sbc.com ([207.115.20.70]:35265 "EHLO
	flpi101.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbXHEVvY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 17:51:24 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2007 17:51:24 EDT
X-ORBL: [75.2.142.109]
Received: from [10.0.0.2] (adsl-75-2-142-109.dsl.pltn13.sbcglobal.net [75.2.142.109])
	by flpi101.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id l75LhFuw018563;
	Sun, 5 Aug 2007 14:43:16 -0700
User-Agent: Thunderbird 1.5.0.12 (X11/20060911)
In-Reply-To: <alpine.LFD.0.999.0708051221290.5037@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55073>

Linus Torvalds wrote:
>> Yes, name-calling and ad hominem attacks again.
> 
> No. Emacs _is_ odd. It's not even installed by default on most modern 
> Linux distributions.

Hi Linus,

Thus disparaging distributions that do install it.  I've not had
to pull any extra packages to get it so far, but I only update
every few years.  I've been a happy emacs user for 24 years.

> There's no name-calling there. That's just a solid fact.

The name calling is unseemly on all sides.

>> Please try to remember that Texinfo is a _source_ format, and it
>> produces reasonably hyperrefed and coherent PDF and HTML documents as
>> well as plain ASCII.  That it is also able to produce working info
>> files should not bother you.
> 
> You do not even know what you are talking about.
> 
> AsciiDoc is *also* a source format. But the source format is already 
> readable IN ITSELF. Which is the whole point!

Readable, just not writable.  It's markup language is a bunch
of special characters that require familiarity to understand.
Sure, you can peruse the text just fine, but why should this
sort of thing:

   = My Doc Title =

be preferred to:

    @settitle My Doc Title

@chapter, @section, @subsection really make a lot more sense to me
than this sort of cruft (my disparaging term):
Level 0 (top level):     ======================
Level 1:                 ----------------------
Level 2:                 ~~~~~~~~~~~~~~~~~~~~~~
Level 3:                 ^^^^^^^^^^^^^^^^^^^^^^
Level 4 (bottom level):  ++++++++++++++++++++++

It really boils down to preferences and familiarity and should
not degenerate into nasty name calling.

> Headers? Lists? They look like headers and lists in the .txt files. No 
> need to think about it as a reader. 

So do well-formatted .texi docs.  I don't really like anything
other than WYSIWYG, but that doesn't lend it self to reformatting
into man pages et al.

> See? Texinfo is decidedly inferior. But you don't have to take it so 
> personally. So is pretty much anything else. Anything XML/SGML is even 
> *worse*.

Bah!  They all have their drawbacks and preferences are going to weight
drawbacks differently.

So let's all dislike all our choices, eh?  Cheers - Bruce
