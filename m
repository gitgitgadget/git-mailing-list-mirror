From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Big Java repositories to play with?
Date: Wed, 07 May 2014 15:38:22 +0200
Message-ID: <536A374E.2050808@gmail.com>
References: <CACsJy8ArsQMBA3hq92u-6N9MCLYBgTRa_NYDm3QKjmKq25__oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 15:38:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi23N-0004dT-8J
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 15:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933215AbaEGNi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 09:38:27 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:65505 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933123AbaEGNiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 09:38:24 -0400
Received: by mail-ee0-f49.google.com with SMTP id e53so753649eek.36
        for <git@vger.kernel.org>; Wed, 07 May 2014 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ph2sQkzhA9LuLMSSmvGeGqV4F4ihbSNsKMGOwZBcr+w=;
        b=SJFXJPrvMEG3v0sYZ9qoT+oxgId35j5FMEE/PfncVcx2i7HB2pChopIdRmSSq3R20e
         fcFfRu/gb11k3FFEyMiwxm8AcPbDKv5yODDztaTOFCsQCK2fk0QIGXFdlxbCKS/uBLlU
         s3aB9PEKAKhu1aaDV/WMvOiFXTho2nR9Gqv9zVJht1d8Y8Di6fq9UdWeXZRYiA7OVTpJ
         2uOTjJkWCt2CNjFjeGXD+rI00phmaWiXPe/C7yjDS6s0Wf7ompHea6UgII3It3DY8Gxa
         wOa4f+6dHODodpkgj2DPkr9QL7Z3spwdskipCghtE7+QM+r+oDkF37z77EBFVmQBKWFK
         a/Tw==
X-Received: by 10.15.34.197 with SMTP id e45mr3884148eev.112.1399469903450;
        Wed, 07 May 2014 06:38:23 -0700 (PDT)
Received: from [192.168.1.7] (ip-178-200-168-156.unitymediagroup.de. [178.200.168.156])
        by mx.google.com with ESMTPSA id a42sm46470479ees.10.2014.05.07.06.38.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 06:38:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CACsJy8ArsQMBA3hq92u-6N9MCLYBgTRa_NYDm3QKjmKq25__oQ@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248302>

On 07.05.2014 15:23, Duy Nguyen wrote:
> I need some big Java repos (over 100k files) to test "git status".
> Actually any repos with long path names and deep/wide directory
> structure are fine, not only Java ones. Right now I'm aware of
> gentoo-x86 and webkit. Let me know if you know some others. I'm afraid
> my Google-foo is not strong enough to search these repos.
> 

I believe LibreOffice could do?
(Just a guess, maybe I'm wrong)

https://www.libreoffice.org/about-us/source-code/
git clone http://anongit.freedesktop.org/git/libreoffice/core.git
