From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Wiki "CygwinBinaryInstall" missing
Date: Wed, 18 Aug 2010 21:38:37 +0200
Message-ID: <1282160317.15085.8.camel@mastrogen>
References: <AANLkTikDBW5jUu4MYOEL-TEkD6t4jC-Wthsmbk=hGc55@mail.gmail.com>
	 <AANLkTing0yxhzvMwOsYi5j1-u4VXN=1Wg04Ebbhi4JD7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 21:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OloSy-0005aR-Vs
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 21:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0HRTiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 15:38:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58213 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab0HRTiW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 15:38:22 -0400
Received: by fxm13 with SMTP id 13so555003fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=pnqMbeldQgcjGVIpnaAiErnjST0+yJtGyq6cZQpSVv4=;
        b=HMeps0i47I6IIBM7T+HPsbM7XVW+kFK+vDpMg/kY8eDKvj9T9eAvxEZsIBiaELylTA
         Q96fXraGaFRd8GJlrhRnb8AX6wSopP00MPlvJNlDvsW/9QkDeQIsHVN/ZfsqKMbh5Ftg
         LpDMzHTn1TxgjLneVQdxaZpx5xfn8LArWmUkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=TzGYc2itlSvQFDqhw73r9apuUKukYf/TBAtEZN0/+wbXoR3rqZXt6YongRUUCzoRUH
         fUkNZPhMg+4b6lrnn0Scn5E8QftSwtXqr2lImwlmUMvsj9hVIOdspUVt9kHawTUD8nwv
         2eHjlfuFAPYoVE8tbdk9HHwp4U4CVOJBZDARo=
Received: by 10.223.116.197 with SMTP id n5mr8306909faq.53.1282160300586;
        Wed, 18 Aug 2010 12:38:20 -0700 (PDT)
Received: from [192.168.1.10] (host106-67-dynamic.20-79-r.retail.telecomitalia.it [79.20.67.106])
        by mx.google.com with ESMTPS id r8sm327762faa.37.2010.08.18.12.38.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 12:38:19 -0700 (PDT)
In-Reply-To: <AANLkTing0yxhzvMwOsYi5j1-u4VXN=1Wg04Ebbhi4JD7@mail.gmail.com>
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153879>

Il giorno lun, 16/08/2010 alle 18.55 +0800, Tay Ray Chuan ha scritto:
> Not to sure - the page was probably lost during the migration to the
> new MediaWiki setup.

I see

> If you get the time, you can just re-create the page with the
> instructions to install git on cygwin.

I'm not the right person for the job, I don't use windows and I never
installed git on cygwin nor I plan to do so (since I'll had to plan to
install windows first)

> IIRC, the usual way to get cygwin packages is to use the cygwin installer.

I thought that, but what about common configurations or specific hints
on specific version of Windows people are going to install it?

> Alternatively, you can also compile it from the source - I've been
> doing that for some time now, albeit with some features disabled (eg.
> gitk).

I've found a link on the web that speak about that
the really missing information is the less technical installation you
were talking about before.

http://techblogging.wordpress.com/2008/04/11/compiling-and-installing-git-on-windows-under-cygwin/

regards,
Daniele Segato
