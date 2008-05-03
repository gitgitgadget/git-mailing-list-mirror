From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 2/5] diff.c: Use show variable name in fn_out_diff_words_aux
Date: Sat, 3 May 2008 20:01:15 +0800
Message-ID: <46dff0320805030501s4bf2c68dh336efd8ba375d207@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
	 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Ping Yin" <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 14:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsGRK-0005kd-33
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 14:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763395AbYECMBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 08:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763441AbYECMBS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 08:01:18 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:60080 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763395AbYECMBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 08:01:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so394276and.103
        for <git@vger.kernel.org>; Sat, 03 May 2008 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kYOZCEiF60FPMCyuNi0dmNkJ1ZsDtdTgs8txu+4N050=;
        b=I9r+3RODFsUdx26vU61q9FKYsm6tJ8JcHSXooV6IvAW3jrrhIqmTZfYFEayDE7X3SUy4z0AI85EChY/gBi2KQNnSGqDqAv/L5zE7VaAd4iVG0M+zJ2D4uTI6CcTM1OPgKD5/JJojtxDi/tijTR48opWF2xDJPDGsMrJHimTB1hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=etIqhUmXI5BRbTnSLCn/gtbOLvCTNbz4gLwale/4HvL61A4+ml35JI47rxFCfaVeLUGgdKLMbIAjKhWmkgp8dBV5bd4RFdtxj8QBz4LIZgI2fIWR+veF16KMJ4fmpNT+fxBJcIM6+1AWZDkyH15/lkk9jseCEcjoT/pHRfaSsJ4=
Received: by 10.100.12.1 with SMTP id 1mr5885938anl.22.1209816076070;
        Sat, 03 May 2008 05:01:16 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 3 May 2008 05:01:15 -0700 (PDT)
In-Reply-To: <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81073>

On Sat, May 3, 2008 at 7:57 PM, Ping Yin <pkufranky@gmail.com> wrote:
> Signed-off-by: Ping Yin <pkufranky@gmail.com>
>  ---

Sorry, the wrong title, s/show/short/
-- 
Ping Yin
