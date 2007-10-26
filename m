From: David Kastrup <dak@gnu.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinishedsummary continued
Date: Fri, 26 Oct 2007 11:17:49 +0200
Message-ID: <86fxzy2q0y.fsf@lola.quinscape.zz>
References: <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?Pine.LNX.4.64.07?= =?ISO-8859-1?Q?10242258201=04.252?=
	=?ISO-8859-1?Q?21@racer.site>?= <1193328386.4522.352.camel@cacharro.xalalinux.org> <20071025163835.GB31888@fieldses.org> <1193335562.4522.403.camel@cacharro.xalalinux.org> <4720FA6E.9040805@op5.se> <20071025202744.GE31888@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 11:19:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlLLI-0003NQ-0U
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 11:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbXJZJSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 05:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbXJZJSq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 05:18:46 -0400
Received: from main.gmane.org ([80.91.229.2]:37084 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbXJZJSp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 05:18:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IlLKp-0005bn-Vf
	for git@vger.kernel.org; Fri, 26 Oct 2007 09:18:32 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Oct 2007 09:18:31 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Oct 2007 09:18:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:skMDGvbNkpHCRHF+6x8qDdPFptY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62404>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Thu, Oct 25, 2007 at 10:19:58PM +0200, Andreas Ericsson wrote:
>> Federico Mena Quintero wrote:
>>> On Thu, 2007-10-25 at 12:38 -0400, J. Bruce Fields wrote:
>>>> Also, there's
>>>> the restriction that we'd like to keep it looking good in plain ascii,
>>>> so diagrams have to be done in ascii somehow.
>>> Hmm, what's the rationale for this?  I'd assume that most people read
>>> the user's manual as a web page (or as bedside reading if they can print
>>> a PDF thereof), where diagrams can be pretty.
>>
>> man pages.
>
> I think he's talking about Documentation/user-manual.txt, which
> isn't turned into man pages.  (Might be nice if it could be though,
> I suppose.)

I think it would be nicer if the man pages could be turned into an
appendix in the user manual.

I had no success in persuading the toolchain to do that, however.
_WAY_ above my head to figure out the interaction of Docbook, Asciidoc
and similar in order to achieve that effect.

-- 
David Kastrup
