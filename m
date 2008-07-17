From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 09:21:58 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F79430238A144@emailmn.mqsoftware.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>  <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>  <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>  <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>  <7vmykhr6h1.fsf@gitster.siamese.dyndns.org> <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com> <alpine.DEB.1.00.0807170024310.4318@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUOY-0004Wo-AP
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbYGQOWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758558AbYGQOWr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:22:47 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:55005 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758189AbYGQOWq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 10:22:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.1.00.0807170024310.4318@eeepc-johanness>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Considering teaching plumbing to users harmful
Thread-Index: AcjnkzbQdi2szRrdQdK8ZNcNz+t56wAgTuXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88857>

 

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Johannes Schindelin
> Sent: Wednesday, July 16, 2008 5:28 PM
> To: Avery Pennarun
> Cc: Junio C Hamano; git@vger.kernel.org
> Subject: Re: Considering teaching plumbing to users harmful
> 
> So can those people who have something to say about _my_ 
> subject of discussion please speak up?  I think this issue 
> has not been discussed properly.
> 
I've read this whole thread with great interest as I started learning
and using git a few months ago.  While I agree with you to a degree,
there is a class of "newbies" to git who need more than just the basics
that you outlined.  For instance, I'm in the process of evaluating
VCS's, and DVCS's in particular, to replace CVS at our workplace.
Because of that, I need to get "up to speed" as fast as I can.  I need
to know about branches, how to browse history, merging, conflicts, etc.
It is true, though, that I have a lot of experience doing these things
already by virtue of the fact that I've used VCS's for over a decade and
have been evaluating DVCS's for at least the past 3 years, so I have a
bit of a head start on these things.  To learn about these things,
though, the sheer size of Git's vocabulary is huge compared to other
DVCS's.  That's a *good* thing, but it also makes it a bit harder to
learn it all.  It's just a fact of life.

The first DVCS I learned was monotone.  And I think what helped me the
most in learning it is that it's syntax is very simple (you'd probably
say limited compared to git, but that's neither here nor there, if you
stick to your original list, git is as simple as monotone), it's
repository format, the fact that each developer could keep one
repository and create workspaces off of it was perfect for our
workflows.  What I think really helped with learning monotone is that
they had a bunch of common workflows already documented and we could
simply try them out.  Maybe if Git had a few different workflows
documented that might help.  I know we have a "Git for SVN Users"
workflow, but if you want to move beyond that, it might be good to have
some of the more complex workflows documented.  I think some people have
hinted at that suggestion but that maybe it just hasn't been explicitly
said.

> Thanks.
> Dscho
> --

Cheers,
Craig
