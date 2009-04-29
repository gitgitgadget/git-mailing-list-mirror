From: Marcin Zalewski <marcin.zalewski@gmail.com>
Subject: Re: Diftool problems
Date: Wed, 29 Apr 2009 17:37:37 -0400
Message-ID: <7c0fdf4f0904291437w58b2a325t5e56888aadd3780f@mail.gmail.com>
References: <7c0fdf4f0904290915i56f58981i70e7093e9bf87d8b@mail.gmail.com> 
	<200904292142.59471.markus.heidelberg@web.de> <7c0fdf4f0904291255i4076df8cubb26fdb2d51826d4@mail.gmail.com> 
	<200904292248.06107.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Apr 29 23:38:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHU8-0003ze-QH
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757447AbZD2Vh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbZD2Vh7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:37:59 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53466 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbZD2Vh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:37:58 -0400
Received: by fxm2 with SMTP id 2so1458591fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6sMp9lXiIaU9/Kt4I9Uh0pM4fKPzyjpzcmLt+udLZTY=;
        b=x2g7/pCWkD/iPVIHt1xgDbtfb5/SlCw5E+XlcD+k93GcO6XI2albNjxFSsER1mG6FH
         oe3f2sVrzWJa20MnTRpnzzPsAAwDZ8O05yCS5xK3PWEaTr886pDItQ12bQFmGYmvNYlc
         qyCyDWVZIyNgBf56FyQ8bOkPWdh4Dl1ZV6eR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T9t64IyA1ebns8bjB7SGUP/FwHmCWzwtxPXZfenTu8sLX19ajhSUGDnFS9qXcshjQS
         N8lY4nq36JV+Nxk6oYYcpqqM+FsbGpb07nuFgaviQ4ks6UQS3TGvjsaPEO71VWx0ZayC
         bxPXgaMgXSH+SSRW5seCRv4vZuZTPMYQEq5U8=
Received: by 10.103.189.15 with SMTP id r15mr506727mup.126.1241041077138; Wed, 
	29 Apr 2009 14:37:57 -0700 (PDT)
In-Reply-To: <200904292248.06107.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117953>

Markus,

I think I mostly agree with everything that you have written. I hope
that someone will fix something now. :)

Cheers,
-m
