From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 11:39:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031118280.6399@intel-tinevez-2-302>
References: <7v63itbxe7.fsf@gitster.siamese.dyndns.org> <20090301100039.GD4146@coredump.intra.peff.net> <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org> <20090303070937.GB30609@coredump.intra.peff.net>
 <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org> <20090303080603.GA3158@coredump.intra.peff.net> <7v63irf21u.fsf@gitster.siamese.dyndns.org> <20090303082706.GC3158@coredump.intra.peff.net> <7v1vtff1op.fsf@gitster.siamese.dyndns.org>
 <20090303092301.GE32284@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 03 11:40:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeS3R-000413-8h
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 11:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZCCKjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 05:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZCCKjZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 05:39:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:33258 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752868AbZCCKjY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 05:39:24 -0500
Received: (qmail invoked by alias); 03 Mar 2009 10:39:21 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 03 Mar 2009 11:39:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/P5lkDTMXPotXJHjCHmMzYAk9S6F96wevfy6qApB
	s7DcXXr9R/gJBn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090303092301.GE32284@mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112050>

Hi,

On Tue, 3 Mar 2009, Theodore Tso wrote:

> On Tue, Mar 03, 2009 at 12:30:46AM -0800, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > But I think that coincides with what I was trying to say in my 
> > > original response to the series, which is "this issue is complex, 
> > > and we need to hear from the people who would really want this 
> > > exactly what it is they want".
> > 
> > And we haven't heard from them at all, unless you and/or Shawn are 
> > interested.  After all we may not have to worry about this at all ;-)
> 
> Junio, I assume you saw Scott James Remnant blog posts, "Git Sucks"?
> 
>        http://www.netsplit.com/2009/02/17/git-sucks/
>        http://www.netsplit.com/2009/02/17/git-sucks-2/
>        http://www.netsplit.com/2009/02/17/git-sucks-3/
>        http://www.netsplit.com/2009/02/23/revision-control-systems-suck/

I have to admit that I only skimmed the first two: happily, this guy just 
wanted to vent, and chose the correct forum.  His personal blog.

Because he would have had to do something completely different if he 
wanted to change things.  He would have had to:

- write in the public (i.e. this mailing list),

- guard his language much more,

- actually come up with something useful, constructive instead of 
  repeating several times that Git is hard to use,

- defend that the most important purpose of a revision control system is 
  the initial publication of a branch, as opposed to controlling 
  revisions.

It reminds me very much of the question: "Does a universe exist when there 
is nobody in it to observe it?"

Only in this case, I would rephrase it to: "Is a usability wart really 
serious when the guy does not even bother to report it where it can be 
fixed?"

Needless to say, I consider the answer to the latter to be "No.  Really, 
no."

I mean, it is easy, really, really easy to say that something sucks.  It 
is so easy that nobody should even pay attention.  Certainly so easy that 
I should not even have bothered writing this mail.

It is much harder work to come up with solutions, and that is what I am 
interested in.  So I'll try very hard to ignore everything else.

Ciao,
Dscho
