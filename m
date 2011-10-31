From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:54:28 -0700
Message-ID: <4EAF2724.8040001@zytor.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike> <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com> <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com> <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> <4EAF1F40.3030907@zytor.com> <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com> <4EAF2245.90308@zytor.com> <7vzkggok6u.fsf@alter.siamese.dyndns.org> <CA+55aFwnVZ-mK3FChvFn778Z-cT107f4v-h0CDmwkP88=Z9aHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Mon Oct 31 23:54:42 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RL0kb-00036z-IG
	for lnx-linux-ide@lo.gmane.org; Mon, 31 Oct 2011 23:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934744Ab1JaWyj (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Mon, 31 Oct 2011 18:54:39 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40827 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934723Ab1JaWyj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Oct 2011 18:54:39 -0400
Received: from anacreon.sc.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id p9VMsXxa006075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 31 Oct 2011 15:54:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <CA+55aFwnVZ-mK3FChvFn778Z-cT107f4v-h0CDmwkP88=Z9aHA@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184540>

On 10/31/2011 03:52 PM, Linus Torvalds wrote:
> 
> Save it in the commit we generate. BAM! Useful, readable, permanent,
> and independently verifiable.
> 

Note: this means creating a commit even for a fast-forward merge.  Not
that there is any technical problem with that, of course.

	-hpa

