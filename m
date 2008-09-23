From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: [ANNOUNCE] Git-1.6.0.2-preview20080923
Date: Tue, 23 Sep 2008 10:51:35 +0200
Message-ID: <46d6db660809230151tb02986du16427238092d6d74@mail.gmail.com>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
	 <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de>
	 <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:53:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki3df-0003Zw-NK
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 10:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbYIWIvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 04:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbYIWIvi
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 04:51:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:28042 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYIWIvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 04:51:37 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1515408waf.23
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6/NEJERAdG/uTyR6tZLxITRrcrqj0+eDFEcMCjyOTpQ=;
        b=FdJKA7SdUtFdVs1IVkrz2VVMQTe3CzE7ihJbd8cve/ouu9w88ncZzxCv1M7MVkki7c
         VVf/xLOLGL5tDjwQRPP32iAH7LBA2w2fweJ+iwpSSx7ktxYy8UNs4o7GR4yKSxAhK7Xk
         c6yx31j3pb5OI9VGpJ72Ci3mSR4mHATbr6zY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=C+T9cq+t+mRFjOf+wk1sMEHcrbcEuqMd2di0VdZhXP+knB6c0c2v25oUWpyFtLPzZY
         wlbpnklYZlsPrwze2vn4CpqXj1EcLcZcFaTmZp69w0yg4OqREqhCf2Ppd0quoz+cVVvE
         zR4T44SLXwravIjkDP3YNz/00mfZCwphvVrAA=
Received: by 10.115.92.2 with SMTP id u2mr6064838wal.33.1222159895136;
        Tue, 23 Sep 2008 01:51:35 -0700 (PDT)
Received: by 10.115.58.3 with HTTP; Tue, 23 Sep 2008 01:51:35 -0700 (PDT)
In-Reply-To: <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96539>

On Tue, Sep 23, 2008 at 8:09 AM, Steffen Prohaska <prohaska@zib.de> wrote:
> On Sep 21, 2008, at 7:33 PM, Steffen Prohaska wrote:
>
>> Git-1.6.0.2-preview20080921 for Windows is available at
>>
>>  http://code.google.com/p/msysgit/downloads
>
>
> I updated the installer to Git-1.6.0.2-preview20080923.
> The problems reported on the mailing list during the
> last two days should be fixed.
>
> I apologize for the quality of Git-1.6.0.2-preview20080921.
> It was unacceptable.
>
>        Steffen

working fine now on existing or new repositories.

good work!

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
