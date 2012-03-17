From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: git repo in a single file
Date: Sat, 17 Mar 2012 17:13:01 +0100
Message-ID: <4F64B80D.4000308@lyx.org>
References: <20120317155445.GA18712@mailgate.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 17:13:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8wFh-0004OS-Rn
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 17:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab2CQQNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 12:13:06 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63746 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab2CQQNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 12:13:04 -0400
Received: by eekc41 with SMTP id c41so2416476eek.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 09:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=gdRHnGzphZVyWdbvmjuo4lZ0/q95egpytVeIB0V26/0=;
        b=Vf5vAbwQdTRx/JqNg62PetccOpVRvuiZxWE30THMJbJBrxhNQwrkLAauvaUtjSzPz6
         7HvENJnXd5ZJFljSHRLpWkyxeZH4+w3ZwiKivn0BfInCLbGSGLjmHeVrvAm846hlc6Ts
         lUYSSMlju24R+25Ge7J6D7Cg2ndmWoZAMRYYHpJN6hSUpecr0asvr3zRTx1Yy0vx4pQl
         pYie+UpFEzDd0iipr5Qh1GnPH7qWolRMqokkgmZeIPZZnmH6j6BpGFWn/aYLWNUY21Qr
         0rikyRp+k+MQcyGKVtCr9b1EOl3G3rLRUFEFpGGGs529TLuhVz4q1AwqfEdjfnKC150j
         4EEw==
Received: by 10.14.98.72 with SMTP id u48mr789282eef.81.1332000782600;
        Sat, 17 Mar 2012 09:13:02 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id s48sm30021292eem.0.2012.03.17.09.13.01
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 09:13:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120317155445.GA18712@mailgate.onlinehome-server.info>
X-Gm-Message-State: ALoCoQmEDbS8Cq5wRdo8SO2bEXnCBl8lJ5v0xCPTdwY1h/cA5GzGXlm2GZwO3e+rnOd3Nn2iypPn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193337>

Op 17-3-2012 16:54, Enrico Weigelt schreef:
> Hi folks,
>
>
> in several discussion with people eg. on office software fronts,
> I've seen the value of having an git repo in one file. For example,
> an office document, internally consisting of several files (like
> ODF) could be put into an git repo instead of zip. That would
> give a good basis for things like versioning, etc.
>
> IMHO, zip (without compression) could even serve as container.
>
> What do you think about this idea ?
>
>
> cu
We have had the same idea before to implement this for our software.

Vincent
