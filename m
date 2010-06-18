From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Fixing branches from a (really messed up) subversion repository
Date: Fri, 18 Jun 2010 21:01:44 +0000
Message-ID: <AANLkTimxivcSShukg0kFPF_7ignIv3d3TUl8KELKUksF@mail.gmail.com>
References: <AANLkTinmU3tOkv9usjGogHn5cXm07FMde8ryDKuWNKD_@mail.gmail.com>
	<AANLkTink-Rm44xnzBHVo6W_29YCPrjScnolqx_9B8A5G@mail.gmail.com>
	<AANLkTim6pBqc1qQhvGrzmf5FDbVkfw1GmNP00BM_99n4@mail.gmail.com>
	<AANLkTin268tbt5E2flbzwq8Rik0D21Uf4t2z-5fgb4BZ@mail.gmail.com>
	<AANLkTingIuZQ8BB9NW0UpGt7a9uccnBX0_R7YZwJpVsd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 23:01:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPihI-0000ci-0U
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 23:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab0FRVBt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 17:01:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46570 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab0FRVBs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 17:01:48 -0400
Received: by iwn9 with SMTP id 9so1449392iwn.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kEEHZy5E2mifrqDEQ2td2oGarVTnkdF3CRAU3EtIgI0=;
        b=SeKSr65Q6iMcs6OB8gqA7/cmZ9KHyLrvsnDjhkHqK83Biuu5jNGLkklqX0OWJqNUbh
         Ub72TDhwS7zI8JcVwsdXVizAZuD/NIW4+8R59YiPG57fDLq3aK9z+u4AurzgL69dN1ma
         mObwX3pZG6wTk35sBkU8nL4pQ4qPAaRNejLXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F9p/AXKw8madrOkFAfzvEGgLaq+0zULc0UGr9Ti42IfEuqKNTjuzSu0o3LMEDeDqj/
         EVG82WprZwL7GkGbjiWuOc4xO6/cBftqaej0Eaw7fcgjFqDPxnlwx0UckPtC6BuQ2s5f
         A0+LLR+ZqlwvDS8mQcVgcVHMhwiRTC6ljOaO8=
Received: by 10.231.185.86 with SMTP id cn22mr1771618ibb.69.1276894904508; 
	Fri, 18 Jun 2010 14:01:44 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Fri, 18 Jun 2010 14:01:44 -0700 (PDT)
In-Reply-To: <AANLkTingIuZQ8BB9NW0UpGt7a9uccnBX0_R7YZwJpVsd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149363>

On Fri, Jun 18, 2010 at 20:59, Joshua Shrader <jshrader83@gmail.com> wr=
ote:
> Thanks. =C2=A0It took a couple days to get everything straightened ou=
t, but
> this seems to have worked very well.

Mind sharing the details or code for what you did?

I've only proved to myself that this approach will work, I haven't
actually done it.
