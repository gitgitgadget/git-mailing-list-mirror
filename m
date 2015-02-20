From: Matthew Brett <matthew.brett@gmail.com>
Subject: Re: git mac 10.7.x
Date: Fri, 20 Feb 2015 08:35:39 -0800
Message-ID: <CAH6Pt5rm2jrGst3Lm3a5xdum_1sxh3G+xLD0TVhCSLi4jh5fvw@mail.gmail.com>
References: <24CFF4AD-D1EE-40EA-A5F1-9109F29800BE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: sojourner <sojournerh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:36:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOqYz-0003GC-Nn
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 17:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbbBTQgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 11:36:21 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:41215 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbbBTQgU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 11:36:20 -0500
Received: by mail-yk0-f171.google.com with SMTP id q200so7716575ykb.2
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7WpdgxwLjbNpU+nVdTn7mcFjscok21a1azSBSsCtSu4=;
        b=mAkRcIl9W5+aa5etcYfAqfydo1FoK7EukAOIJWVxDWv/vejr12JYPDguMQy+kw3Y8X
         EmcnyLjZFvVpKlTio+ov2rMk2rYuy4V4hymkI/DUUTH9nGHq5odUDbI8Quwv57zL8WMy
         qfKm7WzNzgcUT3rkUBZdFflJvozORLRY+3GhhsD+00thms4VJsA1qpLbJPtfz59i0PmW
         rI9/ht35MDMNUfJjhZL/+WZHG7MpGiPzzyhu65SCUeSPTgWwh9L9gUuxMLg5DlA36DKh
         cG+PrrrOejLC+ghynBSdqO8cvnLMz55JWy1Bk3zMXEObciIsJmTStMZjedBLl2g1vjYa
         P/0A==
X-Received: by 10.236.198.236 with SMTP id v72mr7294979yhn.114.1424450180170;
 Fri, 20 Feb 2015 08:36:20 -0800 (PST)
Received: by 10.170.217.69 with HTTP; Fri, 20 Feb 2015 08:35:39 -0800 (PST)
In-Reply-To: <24CFF4AD-D1EE-40EA-A5F1-9109F29800BE@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264171>

Hi,

On Fri, Feb 20, 2015 at 2:38 AM, sojourner <sojournerh@gmail.com> wrote:
> Installed Git via installer. Updated path in .bash_profile. Get error Illegal instruction: 4 when trying to run Git.

I've seen the installer problem - suggestions here:
http://practical-neuroimaging.github.io/installation.html#if-you-are-on-osx-10-8-mountain-lion-or-below

> Built Git from source. Searches for the compiled source unsuccessful. Which is nice: there's nothing to uninstall.

I'm not sure what happened there :)

Best,

Matthew
