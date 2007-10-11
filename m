From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH v2 1/2] Add a --dry-run option to git-send-pack.
Date: Thu, 11 Oct 2007 22:18:11 +0200
Message-ID: <8c5c35580710111318u63a71da2w31b8c6dde6492c6f@mail.gmail.com>
References: <8c5c35580710110057r29c1fe0w7f9e2825fa33@mail.gmail.com>
	 <119213114734-git-send-email-Brian.Ewins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Brian Ewins" <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig4UC-0007YJ-Hj
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 22:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbXJKUSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 16:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbXJKUSP
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 16:18:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:34502 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbXJKUSO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 16:18:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so749598wah
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kvjY+KiJROq0nqeg/ZQbktYs/ykhEp39ZggfHUz2juA=;
        b=f5LVLGmjFCVc9TOC9eSqDrc5ZvnlPP2gCjvm5X8KWzeOtnnlORg/xhtMJuvMHj/z4wTU3KSE3juo9FFhgLjyQuTOx5TVtRvlW7cGz8c3sYlonP61L6Y83/o3ag/54K26RoKL3/5GL25qcVsb1bay2axN1qfo7owKc8ZtLSco5Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VPL8/f5u15bYD//fJO+L3cCcwRQmPAf1J0Onb49IBWBB8QwsMSKWw8wK4j/TMUjJy8m3K8I/7aEXLs5QyQKOAHRTVd3qRGoH6ItRWEgwPijAzN9NbymiADzvOfB5/tC47q9MY00eMceGMKsoOX/+qoIE5KyDqKOpPpIese0+xaU=
Received: by 10.114.61.1 with SMTP id j1mr2599688waa.1192133891875;
        Thu, 11 Oct 2007 13:18:11 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 11 Oct 2007 13:18:11 -0700 (PDT)
In-Reply-To: <119213114734-git-send-email-Brian.Ewins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60630>

Thanks

--
larsh
