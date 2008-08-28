From: david@lang.hm
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 11:18:13 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808281117410.2713@asgard.lang.hm>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm> <48B6E3C0.4010608@zytor.com> <alpine.DEB.1.10.0808281111310.2713@asgard.lang.hm> <48B6EAF5.4030704@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYm5O-0000KC-HC
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbYH1SSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 14:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYH1SSD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:18:03 -0400
Received: from mail.lang.hm ([64.81.33.126]:40997 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbYH1SSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 14:18:03 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7SIHlvt017396;
	Thu, 28 Aug 2008 11:17:47 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <48B6EAF5.4030704@zytor.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94109>

On Thu, 28 Aug 2008, H. Peter Anvin wrote:

> david@lang.hm wrote:
>> 
>> Ok, I was wrong, thanks to everyone for correcting me. I now know this.
>> 
>
> It's an easy mistake to make given HTTP's apparent connections with MIME. 
> However, all it uses from MIME is the type tags, it doesn't use MIME 
> encapsulation format at all.

as I said earlier, it's never a waste of time to learn things, no matter 
who is right. ;-)

David Lang
