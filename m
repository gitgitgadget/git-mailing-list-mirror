From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/2] Setting git tree of a patch (improved version)
Date: Wed, 26 May 2010 22:18:07 +0100
Message-ID: <AANLkTinKpW7cN-hQoCDpHLprPxgqwngSrk077sxp59Na@mail.gmail.com>
References: <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
	 <20100524184908.30884.65042.stgit@sambuntu>
	 <AANLkTimgpjn5KZpujtmXfd7UtEfJTg-3UcmIjvFor0bX@mail.gmail.com>
	 <AANLkTiltxW_teNgNxZnJLqbiO3Du6al3K48wlcDooVZd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 23:18:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHNzU-0004EE-Bg
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 23:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828Ab0EZVSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 17:18:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48312 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab0EZVSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 17:18:10 -0400
Received: by fxm5 with SMTP id 5so4932114fxm.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zdmC0zt22xGj1eG0S8XK5P3FcaZKv9Tt39FUyIepW5w=;
        b=qvHc0qqv/+hCvvtax/FME2o31IdFoPBLhMt25iX2s64k+/+JMte3ks5465EjSE4O/m
         S4AHaf3Wreqwciq1X9LDzRTEhZDDmAcJNVFs7fPJ9j2u4ENiOdHltZRp6jeRdt7hV7Kr
         ILzTfo3yBSMpN6utW/JP4JcO2ENrvevpMNilQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=anWb24P0+Vms77/6HUo5zx3w516Mbp0RCP7ouUaeGmvZsrbDZ6pwmIrqvoEKAuLn4z
         CPHaf8hj0VVK8pPk+PyQ92YVZY+aSHUPMSHIuyG5Z5xRuKQxs6nzXJEJhKKMvdnm/aqb
         TjQXThNTqk25nEsU0J2Vx+9KUL5F4w/CG2t1c=
Received: by 10.223.33.218 with SMTP id i26mr8210218fad.58.1274908687545; Wed, 
	26 May 2010 14:18:07 -0700 (PDT)
Received: by 10.223.117.204 with HTTP; Wed, 26 May 2010 14:18:07 -0700 (PDT)
In-Reply-To: <AANLkTiltxW_teNgNxZnJLqbiO3Du6al3K48wlcDooVZd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147825>

On 26 May 2010 16:34, Gustav H=E5llberg <gustav@gmail.com> wrote:
> On Tue, May 25, 2010 at 2:26 PM, Catalin Marinas
> <catalin.marinas@gmail.com> wrote:
>> The patches look fine to me.
>>
>> Do you want me to merge them directly or I grab them via some git tr=
ee
>> (or Karl's).
>
> You can grab them from git://github.com/gustavh/stgit.git in the
> 'set-tree' branch.

I merged it. Thanks.

> Somewhat unrelated, I have a string of patches in my 'proposed' branc=
h
> (same repository) which contain various fixes to the Emacs mode.
> Would you like me to post them here as one patch series or would you
> prefer to handle it some other way?

Well, I don't have the knowledge to review the emacs mode patches -
you are the maintainer. Just let me know when and where to pull the
patches from.

Thanks.

--=20
Catalin
