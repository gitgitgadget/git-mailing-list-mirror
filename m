From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] git-send-email: Add a --cc-nobody option
Date: Tue, 18 Sep 2007 07:51:27 -0400
Message-ID: <31e679430709180451h6e451c33lcc9c07e06cc2a869@mail.gmail.com>
References: <11901157221792-git-send-email-felipebalbi@users.sourceforge.net>
	 <46EFBB5A.7090505@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Felipe Balbi" <felipe.lima@indt.org.br>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXbc8-0006Ep-V3
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbXIRLvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbXIRLva
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:51:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:35860 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbXIRLv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:51:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2387959wah
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=wJ3ZMixt1NMY6i24VHbC1b8hF5cdp6E0nh3/UNrHfYE=;
        b=JxFiCiqGXmyBr3qUkcwimcPo9Qdv3WdD1pIcP8Vmq750fRCA+Y+AXY6KvhJkji4xXwKr7kt66ydBsmBEbwf+CBTeQDx8g3nqxbjCqJ0WYm7B98nkCLbA3DklEMC3rm2C8DqiBcLA+wt3VIW4mDDvei8oAs3bNgJpFq6jYAKwhOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YGi1psn0puQukcFnb+a80RbcTkoeCIfYJoiFtYjjVmNG+x8jIwyIYvZ5H1q9bMbEGIclheplVb0QhuKrOLqFlKT/c2Sq8f9kLRmhdH4itlqscUXkKOWxPpB6V3VRK16Y8X/4YRpLRo//UkpdIW8lZ+OjWGwhokgcqGzKTwx9W/M=
Received: by 10.114.112.1 with SMTP id k1mr1555524wac.1190116287268;
        Tue, 18 Sep 2007 04:51:27 -0700 (PDT)
Received: by 10.114.61.4 with HTTP; Tue, 18 Sep 2007 04:51:27 -0700 (PDT)
In-Reply-To: <46EFBB5A.7090505@op5.se>
Content-Disposition: inline
X-Google-Sender-Auth: 2587c51a07cd1eae
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58586>

On 9/18/07, Andreas Ericsson <ae@op5.se> wrote:
> felipebalbi@users.sourceforge.net wrote:
> > From: Felipe Balbi <felipe.lima@indt.org.br>
> >
> > This patch adds a --cc-nobody option to avoid sending emails
> > to everybody but the ones listed by --to option.
> >
>
> Sounds much better than --suppress-all. Thanks

Yeah, sure...
np :-)

>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
