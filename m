From: Christian Couder <christian.couder@gmail.com>
Subject: Re: A note from the maintainer
Date: Fri, 8 May 2015 16:46:26 +0200
Message-ID: <CAP8UFD15C5vU2uiKWZYKQR5MBsV_WKyGKekyCW4UAAsCBrnFxw@mail.gmail.com>
References: <xmqqzj5pxumj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 16:46:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqjXt-00020H-0E
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 16:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbbEHOq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 10:46:28 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35907 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbEHOq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 10:46:27 -0400
Received: by wgiu9 with SMTP id u9so74666214wgi.3
        for <git@vger.kernel.org>; Fri, 08 May 2015 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+Bz1WP58UXQNbKkya9TZ8i9akGsWAefeHv7MWAeB7SQ=;
        b=HyaIHQ4bEdMNVPF8Y9ul7fzgqQBx3CCY+H75kxADXq8+C4ON4W2laIbxWJXG2DVlPF
         aqHhKJAJaMQ9eGv+VSfAlvMc6ZkxhUqRPUuqdkdmK3Jzr5ZHju3YY7OKaGhSO0dz0SYm
         Rv74ZcmRggkMghT+qttQdz5JKY6HEMNYqQjb/OkXm/U2GCI8M0s9jqNXLSgiulcr4z21
         0x4AcB5TZFZuobQQr4qqHSk7Z4j0l/fADDo8H+q6lkQ8OeSLEFpnJNxevXgLedN3BHKm
         Spi1MHDCDYPS+MMzOP6DfOw24Ik8blmA6w+M2jH2y2lym7N6YZ14JFiqTZLwPqxdIOa6
         XmCA==
X-Received: by 10.194.178.227 with SMTP id db3mr7899320wjc.82.1431096386519;
 Fri, 08 May 2015 07:46:26 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Fri, 8 May 2015 07:46:26 -0700 (PDT)
In-Reply-To: <xmqqzj5pxumj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268619>

Hi Junio,

On Thu, Apr 30, 2015 at 9:51 PM, Junio C Hamano <gitster@pobox.com> wrote:

[...]

> * Other people's trees, trusted lieutenants and credits.

It seems strange to me that the above section title still talks about
"trusted lieutenants and credits" ...

> Documentation/SubmittingPatches outlines to whom your proposed changes
> should be sent.  As described in contrib/README, I would delegate fixes
> and enhancements in contrib/ area to the primary contributors of them.
>
> Although the following are included in git.git repository, they have their
> own authoritative repository and maintainers:
>
>  - git-gui/ comes from git-gui project, maintained by Pat Thoyts:
>
>         git://repo.or.cz/git-gui.git
>
>  - gitk-git/ comes from Paul Mackerras's gitk project:
>
>         git://ozlabs.org/~paulus/gitk
>
>  - po/ comes from the localization coordinator, Jiang Xin:
>
>         https://github.com/git-l10n/git-po/

... but it looks like there is only the "Other people's trees" part of
the message compared to what used to be in this section.

I am still wondering if it has been truncated on purpose or not.

Thanks anyway,
Christian.
