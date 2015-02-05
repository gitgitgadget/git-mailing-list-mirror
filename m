From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Improve wording in a comment
Date: Thu, 5 Feb 2015 20:22:08 +0100
Message-ID: <CAHGBnuO3wgE_pLu1jcEyExhrzd+Fk_0Uqs23pFgf1NSZpUxVfQ@mail.gmail.com>
References: <CAHGBnuPnwE8K81C_9W65Jk1FMU==gMODOKvGYBbgNRNbvx_bag@mail.gmail.com>
	<xmqqr3u4kw13.fsf@gitster.dls.corp.google.com>
	<CAHGBnuPhXWXp+OfGsX4i5xOJK81qqua8cp2fDPb76HgaU5C0ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, normalperson@yhbt.net,
	amyrick@apple.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:22:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJS0F-0001ui-F1
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbbBETWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:22:10 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:59756 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbbBETWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:22:09 -0500
Received: by mail-yk0-f172.google.com with SMTP id 9so4016071ykp.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iR1FVbjmDmR90l5JqejY+23O4QN2glakMhzh7AJwnD0=;
        b=jmytNJZFtUf/EIRdv58NdKGLFKqocgI/qyZDIpk/GfBGs5uf491Y3DvC/Dp/5BnHfx
         OUK5KzecIwHz5U9Xc9Fq41PZ1iLHdmCsAA8uiue5frK0+HuRFur5aHIAZTGLNbaTiVlB
         ja8Q/XQdsmERvI98egec8K5Eod6VcRAfHPL7oplKUrtq20akwq6f4A4X+bl574a9Iy7H
         5Csdy9PT58imfSsvCwO2JyVDjtlkqjveeaklDomPs2v6HYbj2VtrkZDnpnwj1qsr2vrU
         BaDvvlsFeu5JwJlteJAxRrHL4hdJwrty98NNZVf5aZQmw3trLOCvZIk5aZi+/TXymzvM
         QLqg==
X-Received: by 10.170.217.9 with SMTP id j9mr2603155ykf.19.1423164128729; Thu,
 05 Feb 2015 11:22:08 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 11:22:08 -0800 (PST)
In-Reply-To: <CAHGBnuPhXWXp+OfGsX4i5xOJK81qqua8cp2fDPb76HgaU5C0ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263388>

On Thu, Feb 5, 2015 at 8:19 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:

>> Is that an improvement?  Is the plural of "dup" (used as an
>> abbreviation of "duplicate") "dupes" not "dups"?
>
> My view is that the abbreviation of "duplicate" is not "dup" but
> "dupe", hence the plural "dupes".

For "duplicate" the noun, that is. For "duplicate" the verb I'd be ok
with "dup" as the abbreviation. "to dup" sounds and looks better than
"to dupe" :-)

-- 
Sebastian Schuberth
