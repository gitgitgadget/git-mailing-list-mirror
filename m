From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 19:44:32 +0100
Message-ID: <e5bfff550909251144ma9e4dccmb54a64f364b820fa@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <4ABC9C5D.5030202@viscovery.net>
	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
	 <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>
	 <4ABCCFE4.6070202@viscovery.net>
	 <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>
	 <4ABCE167.7060204@viscovery.net>
	 <e5bfff550909251125t6ed59b1fv953eee597adc4471@mail.gmail.com>
	 <4ABD0E90.5030301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: alexandrul <alexandrul.ct@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:44:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrFmZ-00045o-6b
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 20:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbZIYSoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 14:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZIYSoa
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 14:44:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:55390 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZIYSo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 14:44:29 -0400
Received: by ey-out-2122.google.com with SMTP id d26so650948eyd.19
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=h7VcX5oe5uEZ9j4ajqiQrqybyrt4n7/uikRuBAPVZDU=;
        b=Zf0yUvJJi+kut6g63COUQQDwzWyuzH/vb1bRsJ+w76u95ffJXU+Ho1GynVKkwCtmxh
         +ZwXLgpheSUI7SFsxX6mbim72+mIKTdHpLtzu7fYCRW6nz2wW806XTptbxSFxSdgGm2o
         /dT6tI2suv5sehcv1MzKUy0vEIjNkyRJQaRn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cSpELWkCz8zev+9RA7zKZJFpfboxVo0vailpEFpdBtAB+nABk0X6Z73pggfEDFC398
         LOiCvT28zHddObPCEkwp/KTvafUwyrhO8pOnQ5ggwc7qJ8G1fyIRTkvWEHaLbQmUD+fm
         DfmJjIgK5GutsKzkDtEc6O/g7eCF2JeRmjWb0=
Received: by 10.216.90.14 with SMTP id d14mr96496wef.30.1253904272189; Fri, 25 
	Sep 2009 11:44:32 -0700 (PDT)
In-Reply-To: <4ABD0E90.5030301@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129103>

On Fri, Sep 25, 2009 at 19:40, alexandrul <alexandrul.ct@gmail.com> wrote:
>> Now path is C:\Program Files\Git\bin
>>
>> I have even deleted the contents of cmd directory to be sure they were
>> not called.
>>
>> But unfortunatly the problem persists.
>
> Could you copy the git installation folder to another PC and see if the
> problem is still present? Or archive it and upload it on some file sharing
> service?
>

This is a good idea, thanks. I will copy the git folder to a working
PC and we will see....
