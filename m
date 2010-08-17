From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC] Libgit2, Summer of Code is over
Date: Tue, 17 Aug 2010 17:16:38 +0530
Message-ID: <20100817114634.GB24886@kytes>
References: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com>
 <AANLkTim92DyfsMb=qvaDz02xzhF7ZPfOy06mCGsn_Xen@mail.gmail.com>
 <AANLkTimGMRoGc9fGMxQCBg3LFK6i0sV2HWg+LqST0hOM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 13:48:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlKek-0000rF-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 13:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab0HQLsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 07:48:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59514 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0HQLsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 07:48:32 -0400
Received: by pwi4 with SMTP id 4so2013571pwi.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UrAvvd/+RBfOwpbq+pTgGlzGt74OrH3ER7ol4nI1VuI=;
        b=v12HNyIQfBvVL0v18K2I4btwcRbCE1Ks6Tch3AkLQ0c0GrV6gB0USTF6a9tMfntO25
         LU26qgt1RovCppZX8tuWdUi2aoYm99xzVP2vlZVy0QgXcv9fm95dZRafwn+E31H7FVAE
         hki276B5asntBTFsCbzU8feerfjY9T1otS/lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MHuqdEjBkUDRNCHoAgO+6LjDK3VT1uAKs9jPoyAqxPidvXLJwkK3NK7YddyxJUGRiJ
         gteJIbxg/+sIMHi66scCwrOlqb+S7TITGtPPud6QfvxQgvgkJXB8Rj/uaK6vvbeK+fti
         04dGgbZjrwxkxWtZbk2SC+X/8dwnrO2/qntfU=
Received: by 10.114.36.18 with SMTP id j18mr7726710waj.46.1282045711746;
        Tue, 17 Aug 2010 04:48:31 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x9sm14190672waj.15.2010.08.17.04.48.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 04:48:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimGMRoGc9fGMxQCBg3LFK6i0sV2HWg+LqST0hOM@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153747>

Hi Vincent,

Vicent Marti writes:
> > How about getting git.git using it? That would make sure it would
> > actually be usable and maintained. :)
> 
> That would be certainly great, however libgit2 is still missing too
> many features to replace the core of git.git. We are working on it,
> though.

Are there some rewrites of existing components that can be merged
immediately? I'm sure we can pull together some manpower if necessary
and start merging it bit-by-bit. It'll be impossible to review the
whole thing at once anyway.

-- Ram
