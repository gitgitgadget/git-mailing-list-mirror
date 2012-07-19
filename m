From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 6/7] build: "make clean" should not remove configure-generated
 files
Date: Thu, 19 Jul 2012 09:59:04 +0200
Message-ID: <5007BE48.809@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com> <cover.1342649928.git.stefano.lattarini@gmail.com> <e763e7f466efa34f48589f8353a7316fff469145.1342649928.git.stefano.lattarini@gmail.com> <vpqy5mgdyro.fsf@bauges.imag.fr> <5007B780.7010500@gmail.com> <vpqpq7sdwmd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 19 09:59:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srldj-00044R-SM
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab2GSH7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:59:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56497 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab2GSH7J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:59:09 -0400
Received: by bkwj10 with SMTP id j10so2142673bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=DMAUbVWrqe73lSVTusV4l2PDWhDKL512ZH8ZxyEcpHE=;
        b=k/wvwrtfyvxhvbT493UOj7ny4KJFqVoOrH+QBtYHr2OoqIlnhHjeZt/cAMLhvESH7L
         UrdtPHiOnkHKnj9LWoPROLiv8mNXAZLNMTBspSPdTbnrsiXCQG45oKtgpCxXBfCOUS78
         nITcurfVOqFlxX2ljduQGKJwzcscNG3pCZsPnIFCGpu9pyT5NGU47STXM3UJJqziNlJa
         Ii7U9TbfmhlR0ADcSPJuwEBgWEbL1vRL78/jo4IdP2Ai222Fj1u+pWp1UkaascHJJ53F
         xwDhulsQR1yIRep/VhnxhIgTIEQkxr8lq1COMcss2N9F30xOx3heaaoBREZPFE7GJxgC
         9xYA==
Received: by 10.205.123.8 with SMTP id gi8mr280648bkc.92.1342684748431;
        Thu, 19 Jul 2012 00:59:08 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id g6sm452112bkg.2.2012.07.19.00.59.05
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:59:07 -0700 (PDT)
In-Reply-To: <vpqpq7sdwmd.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201726>

On 07/19/2012 09:43 AM, Matthieu Moy wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> Should I add "Acked-by: Matthieu Moy" then?  (Sorry if it's a dumb
>> question, but I'm not sure which the preferred policy is around here).
> 
> Not necessarily needed if the patch is not otherwise controversial. The
> email discussions are usually sufficient for that. I'd say you may add
> it if you need to resend.
> 
OK, thanks for the info.  In light of this, since I've already send a re-roll
without any "Acked-by:" line added, I won't bother sending a further re-roll
just to add such lines.

Thanks,
  Stefano
