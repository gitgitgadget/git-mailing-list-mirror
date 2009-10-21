From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Thu, 22 Oct 2009 06:21:45 +0900
Message-ID: <20091022062145.6117@nanako3.lavabit.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	<alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	<7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	<7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
	<81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
	<7v7huspjg0.fsf@alter.siamese.dyndns.org>
	<32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:22:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0idU-0001IX-Av
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbZJUVVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbZJUVVo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:21:44 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36347 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754684AbZJUVVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 17:21:41 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id D0AD111B8B9;
	Wed, 21 Oct 2009 16:21:46 -0500 (CDT)
Received: from 9509.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 7XVLZKEXZJ4S; Wed, 21 Oct 2009 16:21:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=WjINo7Ee2AHhnmQAtO9aLp1C/p67/BfhiQtZkohcp5EaEDa2GyRIx9JDkfMI/bC3thEamRuQ0PirfyRtiu3yURHj99po2JCYrBxKcZHTknWV8HzOQcWGcGKlEfNUQTCNs+BBNlVyECe77CGm2rDFda0UchCvlaafoYUIX2+t7l4=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130965>

Quoting Avery Pennarun <apenwarr@gmail.com>

> On Sun, Oct 18, 2009 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Helping hands in polishing it up is very welcome.
>
> I find the idea of an option for "don't do what I mean" to be pretty
> entertaining.  Or maybe just misleading :)
>
> Have fun,
>
> Avery

As Junio asked for helping hands, let's try to be helpful and constructive.

Maybe "don't second-guess" explains it better?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
