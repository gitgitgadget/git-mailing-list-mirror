From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Suggestion: doc restructuring [was: Re: Considering teaching plumbing to users harmful]
Date: Fri, 18 Jul 2008 13:52:56 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F79430238A204@emailmn.mqsoftware.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <48806D03.30603@fastmail.fm> <4880E041.8070001@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Jon Loeliger" <jdl@freescale.com>,
	"Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJv6Q-0003r1-Jw
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 20:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbYGRSxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 14:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755903AbYGRSxq
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 14:53:46 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:10991 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129AbYGRSxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2008 14:53:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <4880E041.8070001@freescale.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Suggestion: doc restructuring [was: Re: Considering teaching plumbing to users harmful]
Thread-Index: AcjpBH8pV9qiRLnjQn6btW/2rYXwKgAAhkMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89072>

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Jon Loeliger
> Sent: Friday, July 18, 2008 1:26 PM
> To: Michael J Gruber
> Cc: git@vger.kernel.org
> Subject: Re: Suggestion: doc restructuring [was: Re: 
> Considering teaching plumbing to users harmful]
> 
> I always have to painfully search the page for it instead.
> 
I don't want to complain too loudly because I don't think I have any
good solutions, maybe yours is a good one, having an alphabetized list
of commands.  What I wanted to second, though, was that I too use the
browser search for all of the Git pages and that indicates that
*something* isn't optimal.

One easy thing I could suggest, and I'd be willing to try submitting
some patches if people agreed it's a valuable change (at least that's
something I think I could handle contributing for now ;-) ) is that when
you hit the "Documentation" link off the main page, instead of going
straight to the Man page, maybe it should go to a page that clearly has
the options that people are looking for.  E.g. a link to the tutorial, a
link to the man page, a link to the Git User's manual, a link to the
FAQ, a link to the "Git for SVN Users" page, etc.  The way it is now,
once you're used to the html rendered man page, it's not hard, but I do
think it's not the most newbie friendly way to navigate the
documentation atm.  Or maybe just feature those links more prominently
at the top of the man page so they're dead easy to spot.  Just my $0.02.
If someone definitively says what should be done, I'd be willing to give
it a shot.

> I'm not saying get rid of the Categorical organization.
> I am saying, we need a first-page with a straight, 
> alphabetized command index somewhere easy and located conveniently.
> 
> Thanks for listening,
> jdl
> --
> To unsubscribe from this list: send the line "unsubscribe 
> git" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Cheers,
Craig
