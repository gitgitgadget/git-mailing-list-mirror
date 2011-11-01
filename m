From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 17:42:57 -0700
Message-ID: <4EAF4091.2010205@zytor.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike> <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com> <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com> <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> <4EAF1F40.3030907@zytor.com> <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com> <4EAF2245.90308@zytor.com> <7vzkggok6u.fsf@alter.siamese.dyndns.org> <4EAF3556.3000001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: linux-ide-owner@vger.kernel.org Tue Nov 01 01:43:21 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RL2Rj-0002DO-OU
	for lnx-linux-ide@lo.gmane.org; Tue, 01 Nov 2011 01:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab1KAAnS (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Mon, 31 Oct 2011 20:43:18 -0400
Received: from terminus.zytor.com ([198.137.202.10]:41414 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716Ab1KAAnR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Oct 2011 20:43:17 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f::feed:face:f00d])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id pA10h2CH010937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=OK);
	Mon, 31 Oct 2011 17:43:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110930 Thunderbird/7.0.1
In-Reply-To: <4EAF3556.3000001@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184549>

> 
> The main worry is Linus ($human_who_pulls) gets
> cryptographically-verified data at the time he pulls.  Once Linus
> republishes his tree (git push), there will be few, if any, wanting to
> verify Jeff Garzik's signature.
> 
> So no, I don't see that as a _driving_ need in the kernel's case.
> 
> And IMO the kernel will be a mix of signed and unsigned content for a
> while, possibly forever.
> 

I think the desire is to be able to deconstruct things if things were to
go wrong.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

