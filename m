From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 1/3] git-submodule summary: --for-status option
Date: Thu, 10 Apr 2008 23:57:36 +0800
Message-ID: <46dff0320804100857y2037263fodb7795e0ff33cd0c@mail.gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
	 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Ping Yin" <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 18:00:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjzAY-0008VI-Dq
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbYDJP5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbYDJP5i
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:57:38 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:51187 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbYDJP5h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:57:37 -0400
Received: by an-out-0708.google.com with SMTP id d31so8362and.103
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WcziPiuRe6QCl4eheIEw1diHMQ8MqVVg59FizqQ2T0U=;
        b=Q/z82vE2CVD/lv/KWuLBil61dZ+lP3eA7ASQY4p/EpxO/SKI5UKof1bcD6630/yAMEjBALNSdkxMhM0/J/i+6tgAgRTBsC1MWVefManmXawO7iDlF302GKBVgadQ2yXcpuPBKUQNcfqdujhe2TQGanP67Ji5nHSraElIRsrwZvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lyWjWWKdQGjfsZhEnEbPFTWCvFKlPn1klLd5VnJeIx+sdmjP7rR17hzUA+dfJFG2ZtdAvGrcUlGCOQB9rqXw8vkJpwbEGfhoT1XF8IU+I+Mbycd95QzBF0+Gzp+SEuhoyfI4vIJNsnh8u206HcEbS+LYaUZTU75S3I1lzCZh7x4=
Received: by 10.100.13.5 with SMTP id 5mr3036741anm.110.1207843056655;
        Thu, 10 Apr 2008 08:57:36 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Thu, 10 Apr 2008 08:57:36 -0700 (PDT)
In-Reply-To: <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79233>

On Thu, Apr 10, 2008 at 11:50 PM, Ping Yin <pkufranky@gmail.com> wrote:
>
> The --for-status option is mainly used by builtin-status/commit.
>  It adds 'Modified submodules:' line at top and  '# ' prefix to all
>  following lines.
>

Sorry for the repeated mail. I don't know how it happened. Maybe
send-email bug or my misoperation.

So just Ignore the second one.




-- 
Ping Yin
