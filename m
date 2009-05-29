From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git-ls-files --added?
Date: Sat, 30 May 2009 07:01:11 +0900
Message-ID: <20090530070111.6117@nanako3.lavabit.com>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
	<m3fxeudhho.fsf@localhost.localdomain>
	<2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com>
	<7vmy921i3j.fsf@alter.siamese.dyndns.org>
	<7vws85y9n7.fsf@alter.siamese.dyndns.org>
	<2cfc40320905251756t32e092fdqda769e21669f5d86@mail.gmail.com>
	<20090529212634.GA86167@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 00:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAA9U-0000GP-Ca
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 00:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbZE2WCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 18:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZE2WCA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 18:02:00 -0400
Received: from karen.lavabit.com ([72.249.41.33]:55106 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbZE2WCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 18:02:00 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 90AC411B7CA;
	Fri, 29 May 2009 17:02:01 -0500 (CDT)
Received: from 3759.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 4TAOFFDOW3T5; Fri, 29 May 2009 17:02:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=PVUqvxiYBg9CY0gQjMrC72b2NrNMdfmXwnjSUdl6ZZr/lVUso91xE7Wsl2GceRjYfqvpbvC22zrvduD/fpU+nYVL9cY09CmyQ5D/r/vUImRp0T9udajCrGD3CF5phZHswuHpw+DnptMOqZHP7WNbrhZzNXC9tgFD/BVsM9VT8gI=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090529212634.GA86167@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120321>

Quoting David Aguilar <davvid@gmail.com> writes:

> On Tue, May 26, 2009 at 10:56:52AM +1000, Jon Seymour wrote:
>> Thanks for your answer's Junio.
>> 
>> I am indeed writing some porcelain. I currently have some bash tooling
>
> I know that for the purposes of writing scripts it would be
> really great if we had a plumbing command that gave us exactly
> what git-status tells us, but in a machine-parseable
> and stable output format.

Perhaps you weren't following the thread closely, but I think the patch in the thread quoted by Junio (http://thread.gmane.org/gmane.comp.version-control.git/97830/focus=99134) does exactly that.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
