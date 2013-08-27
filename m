From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [ANNOUNCE] Git v1.8.4
Date: Tue, 27 Aug 2013 00:05:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308270001040.14472@syhkavp.arg>
References: <xmqqfvu0nkim.fsf@gitster.dls.corp.google.com>
 <alpine.LFD.2.03.1308232242180.14472@syhkavp.arg>
 <CACsJy8C3rbxLmSgoR6LY6okHOC=1U4rcdH3CXSYB==+5d81aUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 06:05:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAWw-0001T6-Br
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab3H0EFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:05:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10491 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab3H0EFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:05:14 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600FZ28OIF640@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:05:06 -0400 (EDT)
In-reply-to: <CACsJy8C3rbxLmSgoR6LY6okHOC=1U4rcdH3CXSYB==+5d81aUg@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233046>

On Tue, 27 Aug 2013, Duy Nguyen wrote:

> On Tue, Aug 27, 2013 at 7:06 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Yes, after being vaporware for many many years (I don't even remember
> > when I started making references to a possible pack format version 4 --
> > certainly more than 6 years ago) I finally completed the code to produce
> > a new pack format I'm actually happy with.
> >
> > ...
> >
> > But the biggest gain will come from direct interpretation of the native
> > pack data encoding.  However I'll let others do that part, as well as
> > the required fsck support and all the backward compatibility handling,
> > etc.  Now that the encoding design is pretty much settled I think it is
> > good for review, and for others to get involved as well.
> >
> > Interested?  ;-)
> 
> A clone url, or a patch series please! :-)

This is coming next.


Nicolas
