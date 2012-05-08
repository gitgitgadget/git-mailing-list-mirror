From: Egor Ryabkov <egor.ryabkov@gmail.com>
Subject: Re: Git fetch/pull stopped working
Date: Wed, 9 May 2012 01:28:08 +0400
Message-ID: <CADB4Qb3sqy859k6QPuqU9u1cdxwz0LSQ7bdUXXFW_gQqaT+P3A@mail.gmail.com>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org> <CADB4Qb35FfTL=XX04iR71+2Rg8p4s2roqAF8b_BdFNP9YN=sfA@mail.gmail.com>
 <7v8vh2v501.fsf@alter.siamese.dyndns.org> <20120508200842.GA14779@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 08 23:28:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRrxO-0005BY-27
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 23:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab2EHV2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 17:28:25 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39362 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab2EHV2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 17:28:24 -0400
Received: by vbbff1 with SMTP id ff1so2413472vbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nBGeKzsv1miCK0MuiRqyOU+MPIjxJN8gmFTqPY+tEaI=;
        b=a8iSuHPAHl2phP1vMCxeZbP1Nd21tdRPkR/hxVCLVdPh0j/23HAu/mm3zAqn2akhv7
         d2/+W4uptL7vdslqSCLsSo/HdMSLQwGmmcdKeKFnUoCI8yXd0WB9Egd2uI//WbMRTR+k
         d5XzcoHQi+mWdPeqIglHY8/eUMTqBz7q9uGptVMMQ3zrXmL5aLKK8YhSJx7ih0pae4JI
         OR4/SdWZOp14HC6tHSVoKCIdg9xlui613z30PQNhHE+Xv9c5iUGPMlKXO9xLQVdWOEcj
         VHuxqm+jkgTzeZnJ+FYXHuCcX+C/2pwAPQNORJjzf/acbtDYV2rSAphcx1cRYJOMPHB7
         XNQg==
Received: by 10.52.30.9 with SMTP id o9mr5667057vdh.52.1336512503861; Tue, 08
 May 2012 14:28:23 -0700 (PDT)
Received: by 10.220.9.84 with HTTP; Tue, 8 May 2012 14:28:08 -0700 (PDT)
In-Reply-To: <20120508200842.GA14779@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197426>

> Agreed. It's hard to tell if there's a real problem or not. If the
> redacted bits are the same,

Yes, I checked this a few times and tried re-creating remote with the
address copied from GH site.
HTTP worked, SSH didn't.


> then it is probably a github issue. In that
> case, Egor, you should email support@github.com about it and mention the
> name of the problematic repo.

Yes, I actually contacted them last Friday, working with Simon Rozet now.
I updated him on what we've found and sent him the link to this thread.


Thanks for your help guys :)
