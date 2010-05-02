From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v4 3/3] pretty: add aliases for pretty formats
Date: Sun, 02 May 2010 14:38:20 +0100
Message-ID: <1272807500.24767.4.camel@dreddbeard>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
	 <1272798044-10487-4-git-send-email-wmpalmer@gmail.com>
	 <20100502123039.GB13419@progeny.tock>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 15:38:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ZNl-0002JH-HX
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 15:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852Ab0EBNit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 09:38:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61138 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab0EBNir (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 09:38:47 -0400
Received: by wye20 with SMTP id 20so1128228wye.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=OvYUoO7VMjtYekdRfFEGYWsYdADuwMqHm4LBMW25wHY=;
        b=f1VtTFoDE1cwcwiKqVvl3ry/+NI97NPtVTSH24KezxeZtr/f7UUCpDcI6w+ctRo4VO
         +eDLGzB7J1Vp7YYa6MToSOOrrhpVDwqBAOANgPEF/pPxpVZNERAdO3009MxXUwftbMiu
         DbjsZvyJUMZUARsAJZTiC2n36Ihwki3eTXzm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=sZ2XChl+7m9HuL6PqNrU/n3K2SWQhYIXL57GqgpwzzatH3nwTuxYqeQrk6IiL4C4S7
         /aUJTdGzeut/OYrJA0iEOgKLpGtlPInjARWy/+msS4UgSkydiU4EVU8Qm4dz6QDZKQYR
         kmync0tiRQqAq9EmsZzzHTLVYQ8VZ08w++fJk=
Received: by 10.216.90.143 with SMTP id e15mr2044808wef.22.1272807526181;
        Sun, 02 May 2010 06:38:46 -0700 (PDT)
Received: from [192.168.0.129] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id u8sm32661326wbc.5.2010.05.02.06.38.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 06:38:45 -0700 (PDT)
In-Reply-To: <20100502123039.GB13419@progeny.tock>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146175>

On Sun, 2010-05-02 at 07:30 -0500, Jonathan Nieder wrote:

> Likewise.
> 
> With whatever subset of the above changes you deem suitable,
> 
>   Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks again.
> 

I'm not familiar enough with the patch submission process. Should I add
your changes (all except for the config documentation I agree with, and
that one I agree with the reasoning for) into my series and re-submit,
or is saying "I agree with those changes" enough to assume that they
will be applied to my series if it is accepted?


-- 
-- Will
