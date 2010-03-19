From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 20:32:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003182030480.31128@xanadu.home>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
 <46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com>
 <b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com>
 <46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com>
 <b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com>
 <46a038f91003181455u7136e011u5352c996384f086d@mail.gmail.com>
 <b4087cc51003181502y1f339cf8u268fa5388ace098@mail.gmail.com>
 <alpine.LFD.2.00.1003181935070.31128@xanadu.home>
 <b4087cc51003181644j45722911u87d4cb62a9b4ea09@mail.gmail.com>
 <alpine.LFD.2.00.1003181958430.31128@xanadu.home>
 <b4087cc51003181727k37dabd15y12ba34762b67c4d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 01:32:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsQ8w-0002A3-Ep
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 01:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab0CSAcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 20:32:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50781 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875Ab0CSAco (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 20:32:44 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZI003J76UJM840@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Mar 2010 20:32:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <b4087cc51003181727k37dabd15y12ba34762b67c4d7@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142547>

On Thu, 18 Mar 2010, Michael Witten wrote:

> On Thu, Mar 18, 2010 at 19:03, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Thu, 18 Mar 2010, Michael Witten wrote:
> >
> >> On Thu, Mar 18, 2010 at 18:37, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > On Thu, 18 Mar 2010, Michael Witten wrote:
> >> >
> >> >> You missed the other line (probably gmail's fault):
> >> >>
> >> >> Most likely, all that will happen is identification entropy won't
> >> >> increase nearly so rapidly and there might be other benefits
> >> >> such as shortlog speed improvements.
> >> >
> >> > The shortlog speed improvement is certainly not going to compensate for
> >> > all the added human time needed to process the extra piece of
> >> > information.
> >>
> >> What added human time?
> >
> > The time that humans will have to spend on this UUID
> > setup/fixing/whatnot.
> 
> Compatibility concerns aside, there is virtually no overhead. Indeed,
> there would be less overhead than there is now in terms of fixing.

In a perfect world maybe.  Let's talk about it again when we get there.


Nicolas
