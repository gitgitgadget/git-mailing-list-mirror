From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Wed, 12 Dec 2007 07:22:30 +0900
Message-ID: <200712112223.lBBMNGiT007085@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2DZ2-0006n6-Rc
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 23:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611AbXLKWXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 17:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755299AbXLKWXS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 17:23:18 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:41272 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267AbXLKWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 17:23:17 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBBMNGiT007085
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 14:23:16 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=t42AM8qFYXxBPQc3FBofu6H1vcWGcoKbL3LRzJnnixmmy25VZrcD1sBCN5meXtbI0
	yew7B8+xmEMhn3oL/yds8CpXcN1Ct2eXIdJ6XV4bSg8seatWc7YxHE8ggcXA9Lb
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBBMMqWe023758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 14:22:59 -0800
X-Trusted-Delivery: <770b0b081e9758ef2c0770e99e7444f8>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67959>

Quoting Jeff King <peff@peff.net>:

> On Tue, Dec 11, 2007 at 12:59:14PM +0100, Pierre Habouzit wrote:
>
>> > Not exactly, as it does not give us email address.
>> 
>>   maybe it should be "fixed" so that it does, not to mention that other
>> concerns ingo raised look legit to me.
>
> Perhaps Junio is a time-traveller.
>
> $ git show 4602c17d
> commit 4602c17d8911e14d537f6f87db02faab6e3f5d69
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Fri Dec 7 17:19:31 2007 -0800
>
>     git-shortlog -e: show e-mail address as well
>
>     This option shows the author's email address next to the name.
>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Or, Junio and Ingo are the same person ;-)

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Free pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
