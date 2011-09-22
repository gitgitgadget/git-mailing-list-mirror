From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Docs: Clarify the --tags option of `git fetch'
Date: Thu, 22 Sep 2011 03:48:57 +0000
Message-ID: <CAMOZ1BuunD4x9eWMseJcJ1nWszmo8eR56uZQ2AVO+4PLmhq0PA@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org> <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
 <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
 <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
 <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com> <58d5d7abced4468ea7587a8aeddfb5ed-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 05:49:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6aI3-0000lM-3I
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 05:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab1IVDt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 23:49:28 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58031 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab1IVDt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 23:49:27 -0400
Received: by qyk30 with SMTP id 30so5749252qyk.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 20:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hO1nA+xi2djaF1/KotoZxMhRZ15TjeEujAWWkd1h/10=;
        b=hfIPp6gCHotUAZ6xrav/klPWJi7IxWAgZUYaOCG+WRrsYLrfZ9nVFb+6gSIVKZDVrW
         Muipy+SbAxNwurQae7Z3/WDJPzZxgV0fhZuL7Vco6Wah+U6YZZWNsRbO5z4wjge8jnUL
         ERTMcE5OaAJGuZUgECI9G/1np0uk5dvycZX+c=
Received: by 10.229.83.143 with SMTP id f15mr1254911qcl.241.1316663367125;
 Wed, 21 Sep 2011 20:49:27 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Wed, 21 Sep 2011 20:48:57 -0700 (PDT)
In-Reply-To: <58d5d7abced4468ea7587a8aeddfb5ed-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181881>

On Thu, Sep 22, 2011 at 03:39, Michael Witten <mfwitten@gmail.com> wrote:
> ...
> +This option is merely a short-hand for writing the
> ...

Junio, make that `shorthand', if you please.
