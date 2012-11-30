From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Can we ignore case for commiters name in shortlog?
Date: Fri, 30 Nov 2012 09:05:26 +0530
Message-ID: <CAKohponGXq=P88Y=cmUPbRCeJ--VkMvJyw5th1T-WdGQnn4xWg@mail.gmail.com>
References: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
	<alpine.LFD.2.02.1211292231520.4576@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 04:35:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeHOA-00017F-FK
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 04:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab2K3Df1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 22:35:27 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:47026 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2K3Df0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 22:35:26 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so29122iay.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 19:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=3hJo/kT3HqW+QNc/aRhIf4Dx7Sx+qC1Tck18u8wEoEM=;
        b=nnCmsiB+Boquaz8wW+UfBMtE6WuNFAeh9nKsumBur1UbIKKzg71DN5IDx/qP0DOqGI
         BWRkVPfuV+iH7mAVdp9BcY4yA9//2+KTNoNZH6Fe3Bc77RVAU9+qVGf+TOvf1qCALigJ
         UtllWz7/ycTEg3zYoJZoJYcM2ZGHKKLScleKO14SNkOEYRgOxLNJ7lF2Jp02kdStBW7G
         lYqGka3We/yxPKCdqmRhElF2eDp559qWp6sdmKXrltK7RSqyVV4eP8ctPoD+HqXzmblW
         9Ig+MlmROV5Kdv0EsNWuDh0MUmvSO+usrgz9z/mgVlQzBgK19NnyDggpT7MnB+jvm2FO
         vrww==
Received: by 10.50.91.195 with SMTP id cg3mr27608640igb.57.1354246526535; Thu,
 29 Nov 2012 19:35:26 -0800 (PST)
Received: by 10.64.51.134 with HTTP; Thu, 29 Nov 2012 19:35:26 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1211292231520.4576@xanadu.home>
X-Gm-Message-State: ALoCoQnoldRiiK0eLa5/tQecDyhO/oeA8QaWeRJUcwVxycSYF54fuKGfIcM0zt/GHOFBdmoypiFK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 November 2012 09:03, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> Have a look at the .mailmap file in the top directory of your repo.

Repeating what i said to David in other mail:

I have my name there :)

I thought using names with different case is actually different then misspelling
it. And so, everybody must not be required to update their names in mailmap
with different case. So, with same email id and same name (that may be in
different case), we can show commits together in shortlog.

--
viresh
