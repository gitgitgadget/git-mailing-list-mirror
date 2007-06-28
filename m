From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: most commonly used git commands?
Date: Thu, 28 Jun 2007 10:52:49 +0200
Message-ID: <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>
References: <20070625064017.GA2839@mellanox.co.il>
	 <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
	 <20070625071752.GB15343@mellanox.co.il>
	 <Pine.LNX.4.64.0706250846200.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 28 10:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3pkE-0003ol-1B
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 10:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbXF1Iww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 04:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761582AbXF1Iww
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 04:52:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:19801 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbXF1Iwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 04:52:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so533590ugf
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 01:52:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hObcxNpK4hLW6hV425bkIssXdiwn9y/lfMdmw0sMlHpSMu34KOpef4OChsHPwC5BEPYcTdtdsxaPmQms1eO7SiWiPwctDcQWQQ0JUPy4Dmh++gKCuGvjOpFoybjMaAhjpchfMmcM6D0x8d3BR5TOZTlEChMapjWC+DcckA2b5QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RvYObjwyirsfMGEnRxVftTy20PA9WBHUvq1SHh2yqwt5/W5WXjL3mRoD9m7YWoyg54sJZ7uqpFcIlDS/UKzIL7hThWNxTVCyo53w/FNBEarVWQsHb8E5uKXS0G7gQRWv0PzZoh/CH6sdna4KmlMDMTS2DJgHBQ115BkXG4p3d+4=
Received: by 10.78.81.20 with SMTP id e20mr747393hub.1183020769959;
        Thu, 28 Jun 2007 01:52:49 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 28 Jun 2007 01:52:49 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706250846200.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51089>

On 6/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> git update-index is really not user-friendly. That is why we have "git
> add". It is commonly used as a porcelain _instead of_ update-index.

which reminds me: "git-add" lacks "--chmod=[+-]x".
