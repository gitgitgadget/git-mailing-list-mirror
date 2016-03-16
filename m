From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Is it possible to give specific PR number
Date: Wed, 16 Mar 2016 10:10:58 -0700
Message-ID: <CAJo=hJssZ9xQv--3=hT-TO2xXf10jOJjTM4Fr59jpCfP-7oTDg@mail.gmail.com>
References: <CA+FnnTzo=D+dUdpBvPumd48vH667FAOSupBLwR4WTJy7S-TDkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Igor Korot <ikorot01@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:11:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEyk-00061u-7m
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933904AbcCPRLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:11:21 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34669 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933803AbcCPRLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:11:19 -0400
Received: by mail-vk0-f48.google.com with SMTP id e185so70193925vkb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J9u36L1fF6+Ma175KKDgBI9JQBqE8z4zp01kgT2Q7rg=;
        b=frGfcs++GQU2ZEWz4vgQb6L2Hl2OJo8Ch0CGsCiTqaDC9NmfgdJee4w6a+0zpTaxyT
         yJgAdheHQ9YnBzatAGUOUqQOJ68ia8KJFnM8CC/8D+RPGOkA1SsxwCsKqjE7Ork0HCZT
         OUxGtlj5i2AUsE67LuWi5VG9iojYdVfX63O1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J9u36L1fF6+Ma175KKDgBI9JQBqE8z4zp01kgT2Q7rg=;
        b=J15lrJB/aR39eb6vNoxRDRvW/1vJcCIdETnGJPm6T5nZheK+aCpnaep/hf1HsZu65o
         gw4zph7RWfTfHDKBcNlewTjOvaxwbMNYRfIJb+xP/Z3Pp+L+BxZkvDCRsyuEqWQK3FMT
         Qh08cZJZCVNr4dzPDlwxwNnZouPMwLA7Szr8aGeHCObDTQ3S6vLVPK/EHyPw0pqcgw/S
         FtzLCQBpmHL+O88WtZnJZ+Xw+ZBe3NHdKSoUI8JcC2J0sLyTvKzya8Mn4lT9XiKzqBf2
         eioxnvh1WrSmeWgQTQgYyxXl6CK8FVT3MECKRz2L2MxAsKbUyT+yIort835x7J89GtMQ
         ne3w==
X-Gm-Message-State: AD7BkJKkuPE9zTOd8CyIlZEUbHwOMkjoh7S8/k8SUoANsVbOYa9AOyw/3xYYquGf+0PQmpxC40iWNP9dnvRMvg==
X-Received: by 10.31.149.3 with SMTP id x3mr6089557vkd.46.1458148278289; Wed,
 16 Mar 2016 10:11:18 -0700 (PDT)
Received: by 10.103.65.211 with HTTP; Wed, 16 Mar 2016 10:10:58 -0700 (PDT)
In-Reply-To: <CA+FnnTzo=D+dUdpBvPumd48vH667FAOSupBLwR4WTJy7S-TDkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288997>

On Wed, Mar 16, 2016 at 8:20 AM, Igor Korot <ikorot01@gmail.com> wrote:
>  Hi,
> Is it possible to tell Git to have a PR with a specific number?

Git does not have PRs.

Are you referring to a GitHub Pull request? If so you should ask
GitHub support. GitHub is a commercial entity that is separate from
the Git open source project.


> If yes, is there an API for that?
> If no, would it be possible to add?
>
> Thank you.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
