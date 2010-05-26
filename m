From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 022/104] Gitweb: ignore built file
Date: Wed, 26 May 2010 09:46:46 +0200
Message-ID: <AANLkTinhtH5ySZvScEo_Kjr707BwEPQNYBcBhc_WLIsc@mail.gmail.com>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz> 
	<1274853674-18521-22-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed May 26 09:47:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHBKf-0006gV-6r
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 09:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933472Ab0EZHrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 03:47:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53439 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932728Ab0EZHrK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 03:47:10 -0400
Received: by gwaa12 with SMTP id a12so575673gwa.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 00:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=/FNdhL76meCsTJQcG6fBrejnOlkJ/LrikLuoo8/kArA=;
        b=uniuhKVC26/Ty3HYfWstsbtB196fFB9MHQniDIlvxCTvsQu6RR6yOPVfDRaRlnBmR7
         qM7PttpQy39GF1s5IWaQoc7Xu4Nqd6RcnuKMk95fj1MdpFd0UvPW2dMl/GtR4N1tHOdn
         RIg/NJjOL22FhuEBQY4YjsDpaNU/ylVnGCq4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BltVZ9bZ8/Y/LAu/xoc2j2reJjFaTLxBzsGSnUAF95mguRxijPCowgOrH9MceoRNq2
         NvL68d5FNU9S6eIgXLa/QCXyRYd9b/xoc6KzwaJJmc7pTyyvPXAzOp4E7LJ7MaMogLND
         XeIpr3BXF9o94gVMImdqLk+MyXG/GWMXJfFB4=
Received: by 10.150.94.18 with SMTP id r18mr8814454ybb.320.1274860026976; Wed, 
	26 May 2010 00:47:06 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Wed, 26 May 2010 00:46:46 -0700 (PDT)
In-Reply-To: <1274853674-18521-22-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147779>

Heya,

On Wed, May 26, 2010 at 07:59, Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> From: Sverre Rabbelier <srabbelier@gmail.com>

I think this is in git.git already, somewhere? Also, what's up with
the 022/104? ;)

http://repo.or.cz/w/git.git/commit/493429b89600daf43a818701ba7011b8e538f7b0

-- 
Cheers,

Sverre Rabbelier
