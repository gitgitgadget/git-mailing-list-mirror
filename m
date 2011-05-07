From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Sat, 7 May 2011 11:49:10 +0200
Message-ID: <BANLkTi=N2-uNb1mjOdCGbdn-DfF77D_rfw@mail.gmail.com>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: conrad.irwin@gmail.com
X-From: git-owner@vger.kernel.org Sat May 07 11:49:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIe96-0003oZ-Gk
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 11:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab1EGJtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 05:49:51 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59770 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab1EGJtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 05:49:51 -0400
Received: by qyk7 with SMTP id 7so144907qyk.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=sc6TKpnymzQVkYntZTqTKrFvs/GaR0fX8vIjzHzfSSo=;
        b=pYnvxC0V+mD8zrD4EJaBG95Lp3kDW3cXTXklgZQ9AKBM8hJdqZCIp9ertKkmjbWgqq
         noO7Ld4W3OTRajzbMXke09yPzBDexhL8lZ6cij7Gqaltaw07fFLKJCeH5b6Ust9wdkH6
         ULsF63+/K0OOTpsE6ORnbhKCzy/EECOfFJ4nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OWcNhdYVlDCAG8SiNR7u5pXxq8ahv6tq51bWbNv3a6kDuevuSH4Rg+nT+HRJKsIXEo
         9zG+zw5nu7ottzsyG+ouN5hkJI6Op8nqun6W43dKtjJDiLFnwqx2NVEL1U3Q00AFtIw3
         2ot09mpVMYb/WihR7of/VRIgBOASBQl1TRjsE=
Received: by 10.229.67.13 with SMTP id p13mr2151472qci.98.1304761790140; Sat,
 07 May 2011 02:49:50 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Sat, 7 May 2011 02:49:10 -0700 (PDT)
In-Reply-To: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173042>

Heya,

On Sat, May 7, 2011 at 07:59,  <conrad.irwin@gmail.com> wrote:
> I've rebased my support for git commit -p onto the current master
> branch. I've posted it to the list twice before [1][2].

I thought this got merged and have been disappointed a few times when
'git commit -p' didn't work. So I'm in favor :)

-- 
Cheers,

Sverre Rabbelier
