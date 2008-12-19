From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Odd merge behaviour involving reverts
Date: Sat, 20 Dec 2008 08:12:38 +0900
Message-ID: <20081220081238.6117@nanako3.lavabit.com>
References: <7vljub7oko.fsf@gitster.siamese.dyndns.org>
 <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
 <1229642734.5770.25.camel@rotwang.fnordora.org>
 <20081219124452.6117@nanako3.lavabit.com>
 <20081220064532.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDoaH-0001ZW-BA
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbYLSXPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYLSXPX
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:15:23 -0500
Received: from karen.lavabit.com ([72.249.41.33]:52769 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbYLSXPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:15:22 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 10452C7A71;
	Fri, 19 Dec 2008 17:15:20 -0600 (CST)
Received: from 1808.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id HRR2K8T74BR9; Fri, 19 Dec 2008 17:15:20 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=vdns8oC2/pHEX2ULX/lAL0gY89547hJud76+SLkYW3TBVcGcWIdL13R0IUNGFDrzUxHqLuRMYjPSD/Kgoz7Zj0xKB80UhZ/boGVTiVf79KCW54Zebaf3zw/7yWypEVfOBo1sJ3yHPbo1EbOMrrNdG2hFs9QQGtKnAJzyp9EP9Gk=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vljub7oko.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103598>

Quoting Junio C Hamano <gitster@pobox.com>:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> I think your explanation will help people if we make it part of the
>> documentation.  Especially because two different cases need two
>> different recovery methods, and people need to learn which is which.
>
> Sure.  It needs copyediting to make it readable standalone by not
> mentioning "your misunderstanding", inlining "earlier Linus's suggestion",
> etc., though.
>
> Patches welcome ;-)

Okay, I'll send one later.

Thanks.
-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
