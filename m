From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Fri, 23 Oct 2009 10:57:42 +0200
Message-ID: <4AE17006.9070006@drmicha.warpmail.net>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <7vzl7pyvzl.fsf@alter.siamese.dyndns.org> <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org> <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com> <7v7huspjg0.fsf@alter.siamese.dyndns.org> <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com> <20091022062145.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 23 10:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Fy9-0005XT-0k
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 10:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbZJWI5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 04:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbZJWI5p
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 04:57:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35332 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197AbZJWI5o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 04:57:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 155ADB553F;
	Fri, 23 Oct 2009 04:57:49 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 23 Oct 2009 04:57:46 -0400
X-Sasl-enc: UT97Q+iF1OfEEYyDLbgeN2e8yrIbjEXf7H2HaLkrFDdt 1256288268
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CD26F4747C;
	Fri, 23 Oct 2009 04:57:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091020 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131101>

Johannes Schindelin venit, vidit, dixit 22.10.2009 02:27:
> Hi,
> 
> On Thu, 22 Oct 2009, Nanako Shiraishi wrote:
> 
>> Quoting Avery Pennarun <apenwarr@gmail.com>
>>
>>> On Sun, Oct 18, 2009 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Helping hands in polishing it up is very welcome.
>>>
>>> I find the idea of an option for "don't do what I mean" to be pretty
>>> entertaining.  Or maybe just misleading :)
>>>
>>> Have fun,
>>>
>>> Avery
>>
>> As Junio asked for helping hands, let's try to be helpful and constructive.
>>
>> Maybe "don't second-guess" explains it better?
> 
> My take on it:
> 
> 1) --no-porcelain

Between --no-dwim and --no-porcelain, maybe --no-wimp is a good compromise?

> 2) we all are bike-shedding, not being constructive at all

That's the fun part!

Michael
