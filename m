From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: svn2git question: error: unknown switch `t'
Date: Tue, 21 Sep 2010 13:05:24 +0000
Message-ID: <AANLkTikDhzeDmh4k-HOgrGxtyiEzDAAVKn0mrVmA7W_g@mail.gmail.com>
References: <4E10ACF241081344B9702AA8C6440440C5B14FB331@MX01A.corp.emc.com>
	<AANLkTik_ouA-AD+tmGEvvcJeZqVj4Rge=hcoJ5Bqgt-R@mail.gmail.com>
	<4E10ACF241081344B9702AA8C6440440C5B14FB337@MX01A.corp.emc.com>
	<AANLkTi=X3NqcURV8GSmZiq5CbVwikFF5skFt_t6gkSp9@mail.gmail.com>
	<4E10ACF241081344B9702AA8C6440440C5B14FB33A@MX01A.corp.emc.com>
	<4E10ACF241081344B9702AA8C6440440C5B14FB34F@MX01A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: nolan.ring@emc.com
X-From: git-owner@vger.kernel.org Tue Sep 21 15:05:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy2XN-0003wK-H5
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 15:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab0IUNF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 09:05:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53963 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0IUNF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 09:05:27 -0400
Received: by yxp4 with SMTP id 4so1624699yxp.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+PPNR6Ikf6Qqwnzz/7pJvhozlOSnQ1bcZg0OjDt5WMk=;
        b=PRoYYFQAaocuxSjmKiX5mRasmki83NB3Swv0+/pbl4jn/y+CLQgAjQW9rmw92Kgurr
         6qCqmYJ0rOLV/3PDo+wD/xPpD2vEObXq5MuV3ir1ff9FOkRdHmzWOcGByV+xsFX6V/Zz
         BJWn+oGDaeByKdVUSnUsdivHsuEelgKjfIIO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=X715S8J6DTGqJpvWVnNXsqS/u3r0MRjf+wwFqRBzCCLLaUYtfJQBAMY6e4/ZgVqyFz
         uBpsUPmJKBlf6XDtF0ysFzMhs7Dka5OLU8Z1i7OyTB0rawxREypPsfq6XGPdjD0L/nnq
         8sWIf51Qmqh5mXVR0KUglNVus3aYFB72GIbO0=
Received: by 10.151.6.5 with SMTP id j5mr10398648ybi.332.1285074324532; Tue,
 21 Sep 2010 06:05:24 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 21 Sep 2010 06:05:24 -0700 (PDT)
In-Reply-To: <4E10ACF241081344B9702AA8C6440440C5B14FB34F@MX01A.corp.emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156723>

On Tue, Sep 21, 2010 at 12:08,  <nolan.ring@emc.com> wrote:

> Am I doing something wrong here?
>
> Thanks again for any insights.

You could get the VirtualBox package for SuSE, install Debian, and run
svn2git there.
