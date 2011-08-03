From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Wed, 3 Aug 2011 13:27:34 +0200
Message-ID: <201108031327.35071.jnareb@gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <4E384789.1000909@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 03 13:27:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoZc1-00075q-SO
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 13:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab1HCL1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 07:27:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44121 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab1HCL1j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 07:27:39 -0400
Received: by fxh19 with SMTP id 19so568360fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=aI2lUxHkuj9rIsjg1yUghdJ8u3G6Cs5zU5u7dGeLCNg=;
        b=bETYmJb/VRWmXOcPhmz7i3qRJmhY85GKKlgm7/FJt+qVk2x7F+2o/cMMZ0bj+SsEvc
         Zg/fduVkCz5cpxck+AIVJ0OBdIRyjSTmtGjIXnt6BM3nVrw9Ipy2Ub3qEyN13YAztw5j
         8mybkrHYMPPO2Go5YcmLgMaax6YFV28439/r0=
Received: by 10.223.160.144 with SMTP id n16mr9790530fax.88.1312370858497;
        Wed, 03 Aug 2011 04:27:38 -0700 (PDT)
Received: from [192.168.1.13] (abvd21.neoplus.adsl.tpnet.pl [83.8.201.21])
        by mx.google.com with ESMTPS id x2sm469393fal.20.2011.08.03.04.27.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 04:27:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E384789.1000909@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178559>

On Tue, 2 Aug 2011, Jens Lehmann wrote:
> Am 25.07.2011 22:33, schrieb Jakub Narebski:

> > I am planning doing annual Git User's Survey, and I'd like to ask for
> > feedback.
> 
> I'd appreciate to get some user feedback on submodules. What about this:
> 
> === xx. What do you use submodules for? ===
> (multiple choice, with other)
> 
>  + I don't use submodules at all
> 
>  + to import repositories maintained by others
>  + for your own (or your organization's) code shared between different projects
>  + to separate large and/or many files for performance reasons
>  + to separate data which you don't want (or aren't allowed) to disclose
> 
>  + Other, please specify

Thanks for your feedback.  I'll add it, either in the above form, or
slightly extended as

 === xx. What do you use submodules (or similar) for? ===
 (multiple choice, with other)
 
  + I don't use submodules at all

  + I use submodules
  + I use repo
  + I use git-subtree
  + I use gitslave

  + to import repositories maintained by others
  + for your own (or your organization's) code shared between different projects
  + to separate large and/or many files for performance reasons
  + to separate data which you don't want (or aren't allowed) to disclose

  + Other, please specify

-- 
Jakub Narebski
Poland
