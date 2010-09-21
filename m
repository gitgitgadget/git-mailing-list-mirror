From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.16.1
Date: Mon, 20 Sep 2010 21:48:04 -0400
Message-ID: <AANLkTin128s7SBVVLJjHkOYCEapmi9xL7Envnd6eheD0@mail.gmail.com>
References: <20100919183556.GA22302@diku.dk> <20100920023036.GB2548@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 03:48:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxryA-0006KW-QA
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 03:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab0IUBsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 21:48:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62096 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab0IUBsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 21:48:25 -0400
Received: by iwn5 with SMTP id 5so4705124iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 18:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=BhVvHPd/GOtunAs9xzHnunvuOKC8YbseaTmLU9OWrvQ=;
        b=aTsh3bXEtxwJjjXTnTO1txzp2Hjc58EtGHgyVNw349xHCMobOSpOU2Z2f6Cjgwda95
         8DmMofL4WICLt2ltrLHWEtmLslgoow5qZYOlxqyRBwlybxaSlzTimej5QGFQlJFpqdOv
         4NpjrS7X1Hdmc+heYXGBnRm2Ribt0IwaCNtVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=qqwrJTvCPqxI7pjbTG0ZAdaagkUhbqv06xLpRB/5sdRwlkNgUqmVufSUEthHXNV9lU
         qXSqTXQ0pB8Gg7AKJmxY2OBuXcg4NhDeEURAEB4UpCPUhdFApOzTCsi6ZxYiBfRZY0FK
         vyEul/qdi0b6TBI8ISqsk+mT0rjRc7C0ECdxc=
Received: by 10.231.14.5 with SMTP id e5mr10717447iba.175.1285033704238; Mon,
 20 Sep 2010 18:48:24 -0700 (PDT)
Received: by 10.231.39.194 with HTTP; Mon, 20 Sep 2010 18:48:04 -0700 (PDT)
In-Reply-To: <20100920023036.GB2548@debian.b2j>
X-Google-Sender-Auth: sLlAqBvpiYALO0xXSSEReFp_WFU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156686>

On Sun, Sep 19, 2010 at 22:30, bill lam <cbill.lam@gmail.com> wrote:
> BTW, do you plan to port tig to windows?

No, I do not. But I welcome patches.

-- 
Jonas Fonseca
