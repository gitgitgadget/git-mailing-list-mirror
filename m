From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] ref-filter: mark some file-local functions static
Date: Thu, 3 Dec 2015 11:42:51 +0530
Message-ID: <CAOLa=ZTxihUu+kOacyia29i7xKAB2mG00hRGLyLvydWzNAY9XQ@mail.gmail.com>
References: <565F4E69.5050800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 07:15:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4NAf-0004e1-Bv
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 07:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758689AbbLCGPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 01:15:06 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34511 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758717AbbLCGNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 01:13:21 -0500
Received: by vkbs1 with SMTP id s1so39407239vkb.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 22:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q5RMoLK0p99itsiBvD/mFFSKYcwUDtHq1pU/g7u/nME=;
        b=yPoO2jSdU/xV8SmDCuSvSYB27dY+TftSBM0tZm/m/wlCSf+vo5EXUokEmw3wM3mXK6
         nYmbcq7AaW59N3aHh/PRsw5ul5GxZ2uk7XQAtOJ1o2HvZ/bg76Amn8GN+X844dr1Amg4
         2UPmuu2eXRuE3h+m3uT/gjg1zLxIt4QiUD5iQBOKDkcmFQrg/rf6mNcafYO2OmE5cIQX
         DOOlI6Q+KwgD6hBanpT0yY1nhaCbOuA6aEPrMzbB9Ok4/nkbGVS8FpcxdVmeARgwnxRg
         7K8MEfoygr5+7cP3f64kmptcW75MXvJtGofujQCb6nTDiox0F3qoIrsynjnKY9DwKuzs
         cHjw==
X-Received: by 10.31.8.204 with SMTP id 195mr5012715vki.30.1449123200357; Wed,
 02 Dec 2015 22:13:20 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Wed, 2 Dec 2015 22:12:51 -0800 (PST)
In-Reply-To: <565F4E69.5050800@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281944>

Hello,

On Thu, Dec 3, 2015 at 1:32 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Karthik,
>
> If you need to re-roll the patches in your 'kn/ref-filter-atom-parsing'
> branch, could you please squash the relevant parts of this patch into
> yours.
>
> Thanks!

Thanks, will squash this into the next version.

Regards,
Karthik Nayak
