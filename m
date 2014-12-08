From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] checkout: add --ignore-other-wortrees
Date: Mon, 8 Dec 2014 20:58:17 +0700
Message-ID: <CACsJy8Aifd_Ly=G=fHXaAMq8p9mdVZWEUpDD=dQeizd1B142wQ@mail.gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com> <1418047507-22892-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 14:58:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxypv-0006co-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbaLHN6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 08:58:48 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:42591 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaLHN6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:58:47 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so4523245ieb.9
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sUU5YIOClEoW/PbacXDddRn0XTgAMPb3BjkSIKn3Iy0=;
        b=WQAITQgpzbi5XxUClTgqgG7NCC2JKybTdFTtJxqK3ZqRkUd5hMjqPI7Y7AsoA/aahC
         ETvg5GrzC4+X0v9nGzT2Bm4+hNZcqoJ1C8NJF8/L4ZT+8ajfO88Sk9Nyk2Q68h/J/mRU
         22DGUxgYV5zITpECCDLC/E9gPHQ+N8Og0KkaDOwajTEHq3ExIvSHiuYAlqNw5ha3WN+A
         ua5XELxU/cjg+QVyi6VgOgdBSMgutXnSI5RDQvihrauatsAKSIFkVVOnWMi68VRj/Qtc
         t/9gfEBWU8XsKpWTecU6zHxyPmrc10z7fiTsi5eIMy5V1U5Pa9H/VgmhikJF4dkhO1Gx
         rzBA==
X-Received: by 10.107.163.211 with SMTP id m202mr10708781ioe.86.1418047127149;
 Mon, 08 Dec 2014 05:58:47 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Mon, 8 Dec 2014 05:58:17 -0800 (PST)
In-Reply-To: <1418047507-22892-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261042>

Oops. This one does not belong to the series. I cleaned up `pwd`, then
jumped to another one for testing and forgot to clean up patches again
:(
-- 
Duy
