From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sun, 05 Sep 2010 20:05:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009051952390.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
 <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
 <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
 <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
 <alpine.LFD.2.00.1009041107180.19366@xanadu.home>
 <AANLkTim8XLB5SjV3JtWT-ARN_XuofKDjYRSYT8kPxEvq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_jbR45RFhUqbaykOFv1d2sw)"
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 02:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsPDI-0003v1-Qw
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 02:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab0IFAF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 20:05:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53103 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab0IFAF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 20:05:27 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8A00FS3TL0A740@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 05 Sep 2010 20:05:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTim8XLB5SjV3JtWT-ARN_XuofKDjYRSYT8kPxEvq@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155502>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_jbR45RFhUqbaykOFv1d2sw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 5 Sep 2010, Luke Kenneth Casson Leighton wrote:

> On Sun, Sep 5, 2010 at 2:18 AM, Nicolas Pitre <nico@fluxnic.net> wrote
> > I agree.  So far it has been an interesting topic for discussion, but in
> > practice I doubt the actual benefits will justify the required efforts
> > and/or constraints on the protocol. Otherwise we would have a working
> > implementation in use already.  People tried in the past, and so far
> > none of those attempts passed the reality test nor kept people motivated
> > enough to work on them further.
> 
>  then i'm all the more grateful that you continue to drop technical
> hints in my direction.  thank you for not judging.

Well, either you'll come to the same conclusion as the other people 
before you (myself included), or you'll surprise us all with some clever 
solution.  But that part is up to you.  In either cases, I think it is a 
good thing if I can help you grasp the technical limitations and issues 
faster so you don't waste your time on false assumptions.


Nicolas

--Boundary_(ID_jbR45RFhUqbaykOFv1d2sw)--
