From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Error on git clone
Date: Wed, 6 Oct 2010 10:55:17 +0200
Message-ID: <AANLkTin2PKP1aR+_3eSasemO72Ak3MVX8iwvYx=Mb4-b@mail.gmail.com>
References: <193301.7835.qm@web114608.mail.gq1.yahoo.com> <4CAC18C7.8020302@viscovery.net>
 <960844.34400.qm@web114603.mail.gq1.yahoo.com> <4CAC31C4.5060809@viscovery.net>
 <972161.65826.qm@web114601.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 10:55:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Pms-0005EA-IS
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 10:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773Ab0JFIzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 04:55:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50531 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab0JFIzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 04:55:39 -0400
Received: by yxp4 with SMTP id 4so2334958yxp.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=RNPIbxt974PxCnOl66R+0cuZXYJEUta6SH9GXnA0H24=;
        b=w65CX3dDv7c9rxplNr2nEdDtdg3BuEoFe4/5GbXpbAgo5RKwFl5SijZMMgMvfysswX
         KM9DAUbFp6Q9016jZu6GmyMspaZKgnTVGqH7Z7FByfXS4vk7hoYCR1/jsVgTWPUZb+k+
         xle4Xf9HfGhwg6illGcSJLj0mVWaaH0ke+1pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=j8Iwz2QoaVxdkYoCY6eWb3Im1326UvQcv9NSSoF57x3T2T2g0oTXMQVo5YfzU87Etf
         0dYCIbdJSulK1ZVW7iaLG5t7pWbtiFOtng8OxAXP1YH8p8zYhG2thPTAOmrEYwvAV5y0
         j0Sma1MvkFqs9KFeKRNZf3aZgIMQygewl3hnI=
Received: by 10.150.201.18 with SMTP id y18mr1419606ybf.329.1286355338033;
 Wed, 06 Oct 2010 01:55:38 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Wed, 6 Oct 2010 01:55:17 -0700 (PDT)
In-Reply-To: <972161.65826.qm@web114601.mail.gq1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158277>

Heya,

On Wed, Oct 6, 2010 at 10:50, Hocapito Cheteamo
<hocapitocheteamo@yahoo.com> wrote:
> So I did what you suggested:

Please use 'git init sss3' instead.

> mkdir sss3
> cd sss3

Or you can of course run 'git init' here.

> git remote add origin git@github.com:XXX/YYY.git
>
> Then an error occurs:
> fatal: Not a git repository (or any of the parent directories): .git


-- 
Cheers,

Sverre Rabbelier
