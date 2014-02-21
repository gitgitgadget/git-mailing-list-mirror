From: =?UTF-8?Q?Lars_Gullik_Bj=C3=B8nnes?= <larsbj@gullik.org>
Subject: Re: [PATCH] git-contacts: do not fail parsing of good diffs
Date: Fri, 21 Feb 2014 01:07:34 +0100
Message-ID: <CAOYg4Ax=i3h7mgNxhDsV_OKz12SOWJumh8ub6vuYEr6NN3+FJw@mail.gmail.com>
References: <m3wqgw2srh.fsf@black.gullik.net>
	<xmqqppmkau9n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 01:07:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGdeZ-0004bK-TO
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 01:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151AbaBUAHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 19:07:37 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:45403 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbaBUAHf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 19:07:35 -0500
Received: by mail-qc0-f175.google.com with SMTP id x13so4541004qcv.20
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 16:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Dwip/h64ijc4MvFBRTJaYCfYsS1sEDvSRIZob93rL6Q=;
        b=FzQ+slrnaTyIO1cYb17b1AYFGfb+yoH4fyOENEHHPSdsIKyk+8ue4PbrdmUxJdpPr4
         2YFu92bWaIfJMFV5iGCTlVNIl+hjVH3sAGDezArNcxH3tRZCNUulKPW/dRqeW9IHw8CG
         onU7IfJcK8AeL7kk+V4aOOSbC7Un315tIREw56i48DEaNH7THcUnURQeJdGqfQGIu1Ke
         sZM9zxeemcmAlLADqGFiyHe8zn2bYhhryB1hIxYIx93cAkH025hy2Blyk3vD98p7TAdn
         ncIvvEz+EEShXAIMl8v9oq4RRXW+n08EwVRoLwYzPCT8PRxwCjPblZ9AfdUSq8sxP4ka
         P3tQ==
X-Gm-Message-State: ALoCoQkM4aQrK9DsczbB3OatG5MUA8pEVkTuhYRgAQS90w9ADVyhp7JqjhN+RjevE5htXYB8rQ7Q
X-Received: by 10.224.28.131 with SMTP id m3mr5649821qac.101.1392941254435;
 Thu, 20 Feb 2014 16:07:34 -0800 (PST)
Received: by 10.140.108.52 with HTTP; Thu, 20 Feb 2014 16:07:34 -0800 (PST)
In-Reply-To: <xmqqppmkau9n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242453>

On 19 February 2014 00:14, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> The patch was whitespace damaged, by the way.  It was easy to hand
> tweak so there is no need to resend this particular patch, but if
> you are planning to send more patches, please check your MUA and
> tell it not to.

Suits me right for doing cut-n-paste. Emacs/Gnus usually does not do
stupid things
like that.

Thanks.
