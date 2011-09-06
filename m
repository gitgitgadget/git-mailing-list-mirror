From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [tig: PATCH] Decorate replaced commits
Date: Mon, 5 Sep 2011 22:50:56 -0400
Message-ID: <CAFuPQ1LuKo-a2SJqAMBs724S786xCKwQJDk9q7VYG86NwEGGOw@mail.gmail.com>
References: <f2c76a759d9e39c32b90033cb64f677b7a2602d8.1314608820.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 06 04:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0llT-0007iJ-Hl
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 04:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab1IFCvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 22:51:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62911 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab1IFCvR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 22:51:17 -0400
Received: by fxh19 with SMTP id 19so4213047fxh.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 19:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=76W1ApNHyNYbeNJHSNz4P79GJRxLZwWVfa4RbPIYHso=;
        b=R+j3g9auFpO0UmjcpnxYLdSYjYUSYBtPgJ+UHArGOgrtTKEFGQk1Jo8m8trnz/tTrH
         6TdspwLzyTbit+PmZLHcwR67XHFs6KJO3alAIc3vZ+S7VbhCS1lrBCD/Frjp/kHiqbqS
         XuSNJV67rCBqlbjizBxYzT5bjiS+f5z6z79QE=
Received: by 10.223.76.15 with SMTP id a15mr1110008fak.35.1315277476112; Mon,
 05 Sep 2011 19:51:16 -0700 (PDT)
Received: by 10.223.156.195 with HTTP; Mon, 5 Sep 2011 19:50:56 -0700 (PDT)
In-Reply-To: <f2c76a759d9e39c32b90033cb64f677b7a2602d8.1314608820.git.git@drmicha.warpmail.net>
X-Google-Sender-Auth: TxD2CVeFlUKGm6c_KpWSB2jvjVs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180767>

On Mon, Aug 29, 2011 at 05:08, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Decorate replaced commits by "replaced" analogous to git.git's
> 5267d29 (log: decorate "replaced" on to replaced commits, 2011-08-19).

Thanks.

> Should probably follow this up with graft decorations.

Yes, that'd be great.

-- 
Jonas Fonseca
