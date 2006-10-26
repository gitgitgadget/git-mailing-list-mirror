X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] make =?ISO-8859-2?Q?index=2Dp=E2ck?= able to complete
 thin packs
Date: Thu, 26 Oct 2006 09:25:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610260924520.12418@xanadu.home>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home>
 <7vr6wvr1ca.fsf@assigned-by-dhcp.cox.net> <ehppbg$phq$1@sea.gmane.org>
 <20061026091925.GD13780@diana.vm.bytemark.co.uk>
 <7vpscfo1z1.fsf@assigned-by-dhcp.cox.net> <ehq0md$i44$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_eZUBCHVGPgyHcQ7jxjR0AA)"
NNTP-Posting-Date: Thu, 26 Oct 2006 13:26:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <ehq0md$i44$2@sea.gmane.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30214>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5FY-0007Vn-42 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161090AbWJZN0U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWJZN0U
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:26:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56436 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1161090AbWJZN0T
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 09:26:19 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Q005J2VZ6FBA0@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 26 Oct 2006 09:25:54 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_eZUBCHVGPgyHcQ7jxjR0AA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Thu, 26 Oct 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > Karl Hasselström <kha@treskal.com> writes:
> > 
> >> On 2006-10-26 09:50:48 +0200, Jakub Narebski wrote:
> >>
> >>> That said, git-am should understand QP with coding in mail headers.
> >>
> >> I really hope it does, since I just patched StGIT to generate such
> >> headers. (Out of pure vanity -- I don't want my name mangled!)
> > 
> > Sorry for an earlier hiccup.
> 
> That said, I don't think that Nicolas Pitre wanted to have "index-pâck"
> in subject instead of "index-pack".

Indeed.  I don't know how that â ended up there.


Nicolas

