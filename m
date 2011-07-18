From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] Documentation/Notes: Remove 'footnote:' warning
Date: Mon, 18 Jul 2011 14:31:20 +0530
Message-ID: <CAK9CXBUjTQVsJrERKwmYT=9mBLLDu9uG9+DrFvaOaDPBUpJjzg@mail.gmail.com>
References: <1310855420-21183-1-git-send-email-pavan.sss1991@gmail.com>
 <1310908271.21563.17.camel@drew-northup.unet.maine.edu> <20110717215858.GA9906@elie>
 <CAK9CXBVSq_j7naHzVLMj=bW8WMKq_WfkDQP4zspkK_QizC26=g@mail.gmail.com>
 <20110718055108.GA4254@elie.gateway.2wire.net> <CAK9CXBV=OMRVzEjUmb6JP8nM9bQ4DqM0D7xCywxs0TUD5+scrw@mail.gmail.com>
 <20110718071308.GA4745@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 11:01:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qijhy-0003ib-Mz
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 11:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab1GRJBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 05:01:42 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:33787 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab1GRJBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 05:01:41 -0400
Received: by eye22 with SMTP id 22so1157823eye.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yqFwrexnt1ZiOSXKroPscPY+8+EgOfNVuNx0bE0tnI8=;
        b=KxoYBZaltol/Ond5+NIRo54HqNy/H8TziLrI4b6vx4ICNuyewGTxaMcxVz4fWpaZAm
         G594FbgFJ80LYrmlWF8TQtYfjqCVMefk+5EC8XuLD+N9jPHPBy7pMJL09usQrDzB9Zva
         /IOw5sxb4Qds8ARV29K2VkQKDyhHatCbm4TFc=
Received: by 10.14.99.205 with SMTP id x53mr1426268eef.103.1310979700168; Mon,
 18 Jul 2011 02:01:40 -0700 (PDT)
Received: by 10.14.53.74 with HTTP; Mon, 18 Jul 2011 02:01:20 -0700 (PDT)
In-Reply-To: <20110718071308.GA4745@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177362>

>
> Barring that, it should be possible to put this information in the
> discussion section without disrupting the flow of the text so much,
> for example by putting it in parentheses or making it the last
> paragraph of the discussion section.

That is what I did.

> A patch with such a change and
> mentioning in the commit message the two bugs you're working around
> would seem sane to me.
>
> Thanks,
> Jonathan
>

I agree. So, if the patch is ok, I will rewrite the commit msg and
send it again.

Thanks,
Pavan Kumar Sunkara

-- 
- Pavan Kumar Sunkara
