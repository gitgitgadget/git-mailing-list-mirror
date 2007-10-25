From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007
	unfinishedsummary continued
Date: Thu, 25 Oct 2007 16:27:44 -0400
Message-ID: <20071025202744.GE31888@fieldses.org>
References: <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <1193328386.4522.352.camel@cacharro.xalalinux.org> <20071025163835.GB31888@fieldses.org> <1193335562.4522.403.camel@cacharro.xalalinux.org> <4720FA6E.9040805@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Federico Mena Quintero <federico@novell.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:28:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il9JC-0003iW-Th
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbXJYU1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbXJYU1t
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:27:49 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43755 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbXJYU1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:27:48 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Il9Iu-0000iI-CM; Thu, 25 Oct 2007 16:27:44 -0400
Content-Disposition: inline
In-Reply-To: <4720FA6E.9040805@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62371>

On Thu, Oct 25, 2007 at 10:19:58PM +0200, Andreas Ericsson wrote:
> Federico Mena Quintero wrote:
>> On Thu, 2007-10-25 at 12:38 -0400, J. Bruce Fields wrote:
>>> Also, there's
>>> the restriction that we'd like to keep it looking good in plain ascii,
>>> so diagrams have to be done in ascii somehow.
>> Hmm, what's the rationale for this?  I'd assume that most people read
>> the user's manual as a web page (or as bedside reading if they can print
>> a PDF thereof), where diagrams can be pretty.
>
> man pages.

I think he's talking about Documentation/user-manual.txt, which isn't
turned into man pages.  (Might be nice if it could be though, I
suppose.)

--b.
