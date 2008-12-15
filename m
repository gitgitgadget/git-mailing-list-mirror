From: "Li Frank" <lznuaa@gmail.com>
Subject: Re: TortoiseGit: missing CloneDlg.htm
Date: Mon, 15 Dec 2008 09:17:37 +0800
Message-ID: <1976ea660812141717h7a7b4ad0o7925e973b5d9a6dd@mail.gmail.com>
References: <8666c7870812140955t7da5461avc17562b8aa17dbaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Jamie Border" <jborder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 02:19:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC26w-0000oB-2j
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 02:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbYLOBRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 20:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbYLOBRk
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 20:17:40 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:4634 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbYLOBRk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 20:17:40 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1024715ywe.1
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 17:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=W57f+LuSLPE1g+yjMCv9ljzCER66zEP8HCwsmI/i1lE=;
        b=MHs4ZD+kDw1wH7oT2hAlzr1i1iqFI8KMWfwqwOSFie14hBUONPmQEMkv6FfZPvzX9F
         YihXU1R+1lfvqsX90ZVtak3spjM5rBrQxgHip+KxJ8m4lVhHtm64TH4d/hyXt3y9SqeE
         G6HwIGWWCvejbnYoOfqgpg5Fwl27rtBnUopNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=M59WtXAxEG3/PDB5cSQ/OKfbKRFQD7/B0yfh/XwjDxAZgpjmtLzYmb2729V9nlbyfI
         +qhokSy8CQboyBisUieQOY7Zakb9UuaGDLpqRcR3wxjDciOM+pGpepx/G+GfR5Fs4zKI
         xvvfNOQdJ9Ksz39+zTPkLtTawMLaIrRP68WyA=
Received: by 10.151.112.10 with SMTP id p10mr9298849ybm.79.1229303857533;
        Sun, 14 Dec 2008 17:17:37 -0800 (PST)
Received: by 10.151.134.2 with HTTP; Sun, 14 Dec 2008 17:17:37 -0800 (PST)
In-Reply-To: <8666c7870812140955t7da5461avc17562b8aa17dbaf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103123>

Okay, I will check it.
Clone have not completed.

2008/12/15 Jamie Border <jborder@gmail.com>:
> Hey Frank!
>
> Nice work, but I think you might have left src\Tortoise\CloneDlg.htm
> out of the repo...
>
> TortoiseProcENG.rc line 2348 (IDR_HTML_CLONEDLG)
>
> master @ 3b2f3b4...
>
> Keep up the good work!
>
> Jamie
>
> --
>
> Jamie Border <jborder@gmail.com>
>
