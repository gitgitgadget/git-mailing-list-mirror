From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: tracking un-committed patches in mailing list?
Date: Sat, 8 May 2010 18:32:46 +0800
Message-ID: <p2obe6fef0d1005080332k26621c2fw48ea2482e84202dd@mail.gmail.com>
References: <m2u46a038f91005071044w15594056sb7753b6268979228@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 12:32:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAhL4-0001Oy-D4
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 12:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389Ab0EHKct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 06:32:49 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:41847 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab0EHKcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 06:32:48 -0400
Received: by yxe1 with SMTP id 1so1371678yxe.33
        for <git@vger.kernel.org>; Sat, 08 May 2010 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=QJ3PgVFYhTOfFm95ZFrzXpOWeOPBQyn5EEnu3XO6IEc=;
        b=t1XKN2gUsTl1m8dFi7TXpQEgo8z7jZl36MSKBMrxMtgZDaJgJAWRU7cpzWvxqAksHT
         ya6+h/kbuIXvEIY5O8hRrju2aDmd/2dpHdyFfR4bTcCE+rWJ6B5cBKnabUyOuXyDYqRM
         JrNmm4TgqYxfdWEZJzNXCusVLJKvjqwVtLtic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YNlw2WcmomYvTqxDvWwSJtjSKZULWMF1kpiH1Pe4L31L73aep7hiINkccWhy0r3boS
         AnI8q13ur0dz+kWlkzg2oCGQzWOzyTiAJ0ZGi6EVX/y4PXpjS36IHidx+SAGARkFv4LQ
         VtFCeDirRHK9x6EBhU/r66PJSFuwTiRi8gam8=
Received: by 10.231.156.75 with SMTP id v11mr804837ibw.25.1273314766133; Sat, 
	08 May 2010 03:32:46 -0700 (PDT)
Received: by 10.231.36.201 with HTTP; Sat, 8 May 2010 03:32:46 -0700 (PDT)
In-Reply-To: <m2u46a038f91005071044w15594056sb7753b6268979228@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146653>

Hi,

On Sat, May 8, 2010 at 1:44 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> ISTR some folks here in git@vger are tracking patches that were posted
> to the list but not committed with a bot that subscribes to the list.
>
> I _thought_ it was ciabot. Maybe it's something else? A read through
> the git tools wikipage doesn't lead to any likely suspects...

AFAIK, except for the authors themselves of patches, I don't know of
anything tracking them - well, that's my experience as a patch
submitter. I would browse git's branches on gitweb on kernel.org, and
sometimes keep an eye on "What's cooking" updates from Junio.

-- 
Cheers,
Ray Chuan
