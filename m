From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] completion: git branch --set-upstream-to=
Date: Wed, 12 Sep 2012 12:44:34 +0200
Message-ID: <50506792.4070906@drmicha.warpmail.net>
References: <bd9d638e84e7e142e94b71213bed2126ea1f1951.1347364675.git.git@drmicha.warpmail.net> <7v627kiitq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 12:44:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBkRB-00081f-WE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 12:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757447Ab2ILKoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 06:44:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37942 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756941Ab2ILKoh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 06:44:37 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1D7F421E74;
	Wed, 12 Sep 2012 06:44:36 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 12 Sep 2012 06:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=nwsx0qJ3GdLjEDmJGQuPHB
	Tw6dU=; b=ay2KT9I19q8BU/OER5mga4eQg/yJDoWlx4MEaFW/bl2MUfOTHI2Qf/
	gc/P1/lsFBYyvW9N0ph5gSvQKzQZeBy8XgvyDpdFSzvSlGtM2WGWgUozW319mJ+W
	z98mH5B636y4ql0iV7yWSt5Rx4ab2GA7uiKUTwQg5+Xx09y1pH3bg=
X-Sasl-enc: 6nCMlGgcASguxkXGs6XuC8WgZJ6YzEGpK3GhJOrz4RRM 1347446675
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7D3714836ED;
	Wed, 12 Sep 2012 06:44:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v627kiitq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205279>

Junio C Hamano venit, vidit, dixit 11.09.2012 19:13:
> Thanks; I picked up $gmane/204633 but forgot to queue.

I missed that one, thanks for reducing appropriately.

Michael
