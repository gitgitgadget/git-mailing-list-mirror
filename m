From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git + SFC Status Update
Date: Mon, 13 Apr 2015 17:24:18 +0200
Message-ID: <552BDFA2.5000901@drmicha.warpmail.net>
References: <20150413115613.GA4589@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 17:24:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhgDp-0006Um-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 17:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbbDMPYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 11:24:21 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34935 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753652AbbDMPYU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 11:24:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 153D5208FF
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 11:24:20 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 13 Apr 2015 11:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=R4Mm5WGj/L171dZlzUGpHeAPufw=; b=doQFBG
	2YwwvNxzbw0AGrdYh88nRs5BuHF5hyQANldwcerSrEuGVJ2coNYkwyVolShTsCF5
	Sv83tCxM+hyXTbbrcIreU9duAwuVad/t7CQnDdkjjGM+Ilkj63s/kIR6Grw5g93G
	iJ2Bmj7tgCjXLLaCo7UDQLoZ6FG8pW+6Zxt50=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=R4Mm5WGj/L171dZ
	lzUGpHeAPufw=; b=SntViCVExfrcOsQvheQNQw9c1wqO0cv3FK6ucvGDogfbJMl
	/8Z8UBhpeUJ6SJvGHpASEkUUSqbNPvU07Gkc8E+nzwRFl5klg/HVRDQoID1/mCos
	BNXgMyrpqdWe3RJkzP9YH6VvUzM2INCowR/c6lgXTnhxkd8sgCFuFDugtlg0=
X-Sasl-enc: AgdEC9/DDqrluvaQRBrk0GPw7+R49yB7ti/X91Exdjdq 1428938659
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 94100C00022;
	Mon, 13 Apr 2015 11:24:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150413115613.GA4589@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267086>

Thanks for the report, and thanks to everyone on the committee (and the
conservancy).

I'm somewhat disappointed to see that violent revolutions are excluded,
though ;)

Seriously, keeping the scope of "The Git Project" (the SCF member) as
limited as it is seems to be the best approach to keeping it as
hasslefree and fucntional as it is.

Michael
