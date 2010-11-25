From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: How to do with access control per repo with a smart http git server?
Date: Thu, 25 Nov 2010 23:35:11 +0100
Message-ID: <AANLkTi=1borEXoxZHKRQfPVhuLenp1mOQ7dezFCyKXQi@mail.gmail.com>
References: <loom.20101124T035911-773@post.gmane.org> <20101124045025.GA12399@LK-Perkele-V2.elisa-laajakaista.fi>
 <loom.20101124T060650-817@post.gmane.org> <20101124060813.GA12949@LK-Perkele-V2.elisa-laajakaista.fi>
 <loom.20101124T082340-444@post.gmane.org> <loom.20101124T110708-253@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 23:35:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLkPj-0004V5-4a
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 23:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab0KYWfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 17:35:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60983 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab0KYWfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 17:35:33 -0500
Received: by yxt3 with SMTP id 3so161097yxt.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 14:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=CmeTqTGSA6qJQhlj0Z864J/r5R6L0fvhGvK5riS8Ptw=;
        b=FBsvwjsJZseM8fj7QuVO91BJY3S18/Fo+vaeGrvb4PSX8EVxzxIw5A167N9YIIeHHn
         BM6pSWKSrLJT88t7AT1WGj2FpOu1bCht3IWff1OOcTbRUd7tu2ClNVzL3Qe3sPIPRDlJ
         7i6/3Rp6ISpOPcHIe4L2kKeemf2AaLKmwt4hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GqDWTmoRDi0hhL4/TFKgT/025J9Ltfut1h4tjH9+RDQwk+HJbJybQ+7WsmhubVgJuM
         jP5guZKgDAMSzjGBqDUBNEHHg5ZciZpJdQC8Ir8oBbHMKoHd6jsDBegf3GRVY+XWBt/u
         v3M95BakXzIYSBTVBNuLD00sfbyrcaGfIpK7U=
Received: by 10.151.84.7 with SMTP id m7mr3783342ybl.359.1290724531593; Thu,
 25 Nov 2010 14:35:31 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Thu, 25 Nov 2010 14:35:11 -0800 (PST)
In-Reply-To: <loom.20101124T110708-253@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162157>

Heya,

On Wed, Nov 24, 2010 at 11:13, Chunlin Zhang <zhangchunlin@gmail.com> wrote:
> If it is useful to someone else,can email me and I will share it.

Three years down the road someone will read this message on vger, have
their mail to you bounce, and curse their luck. Why not just put it up
on github or so, link to it here, and if someone finds a use to it at
some point, all the merrier?

-- 
Cheers,

Sverre Rabbelier
