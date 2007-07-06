From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Fri, 06 Jul 2007 20:12:23 +0900
Message-ID: <200707061112.l66BCb6u017186@mi1.bluebottle.com>
References: <Pine.LNX.4.64.0707052018260.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 13:12:45 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6lju-00016R-O3
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 13:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759710AbXGFLMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 07:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759900AbXGFLMj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 07:12:39 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:39545 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758384AbXGFLMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 07:12:38 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l66BCb6u017186
	for <git@vger.kernel.org>; Fri, 6 Jul 2007 04:12:37 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=arxD9C0snaZPNxd1Hf8/2oMna4YTOuVPkEA0E0ypwP0BDM2ltbhGRmY8vXC7eBTXu
	dflMNdvWUz9oEbz8bS2LpGIqeRZ7bhjWIxM2MXa6ck/TRY6g6DXVRgp1pX3x99K
Received: from nanako3.mail.bluebottle.com ([218.16.123.142])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l66BCOdo014117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2007 04:12:32 -0700
In-Reply-To: <Pine.LNX.4.64.0707052018260.9789@racer.site>
X-Trusted-Delivery: <1c778aa4c920ad1ced9b821a23421205>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51739>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> All this means that the given patch would not hardly make rerere as 
> widespread as I intended.
>
> Yes, templates are nice. But I don't think that templates are the way to 
> go for introducing nice features as rr-cache.

I am sorry, but I can't understand how it works and how it is useful,
after reading the manual page of git-rerere three times.  Are there
"rerere tutorial for stupid newbies" document somewhere?  I earlier
created .git/rr-cache folder but I have not seen anything interesting
happened in my repository.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Free pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
