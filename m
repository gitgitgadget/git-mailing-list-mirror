From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] contrib/subtree: Use tabs consitently for indentation
 in tests
Date: Mon, 22 Jun 2015 18:42:34 -0400
Message-ID: <CAPig+cQ6o9r6_d5q_os9T=WarKoChosTO7Xm0x=KWoHV87yq7A@mail.gmail.com>
References: <1434981210-13036-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7AQO-0004xq-VL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbbFVWmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:42:40 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35695 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbFVWmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 18:42:35 -0400
Received: by ykdy1 with SMTP id y1so31264472ykd.2
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DpXc3YYuH1EL6mIAh9NKCecBNUUtl2BdFT9v1E0jFwI=;
        b=rbfWmfGATsObgPKQE7M2lvY7JGVJGSnV/DPYXsKD+mczPbQsCph2zwYyVvobPQ7vT0
         L9QMqlkM/2iWyaQBQwhiy+CKHBS40W5vOyqrB91f/fVUhvPIIbADgPX08j52u9vb5nso
         /v8fZIyHsyio5FMETq80s1ub3ChR+/NXjKioZA7rp7l5kSidSrE4fkA4VW+Hq36klZwk
         FgFo2GYtiPbRXbRiZIZbjajSIcFLgoRkte9ertzAP0+OJ9rNL0R+Ve5oDRN0+/a/4Yus
         C0rgLA+z3ZAjOMbQIFzINsRmE4h1bN012bUyUpcCt2ZjF9eUU+GG6dC05RrITTOV/C1t
         zumA==
X-Received: by 10.13.205.71 with SMTP id p68mr19922211ywd.48.1435012954462;
 Mon, 22 Jun 2015 15:42:34 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Mon, 22 Jun 2015 15:42:34 -0700 (PDT)
In-Reply-To: <1434981210-13036-1-git-send-email-charles@hashpling.org>
X-Google-Sender-Auth: 1tI6uOeMtiTSSgyxWHWAcww1gSY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272432>

On Mon, Jun 22, 2015 at 9:53 AM, Charles Bailey <charles@hashpling.org> wrote:
> contrib/subtree: Use tabs consitently for indentation in tests

s/consitently/consistently/

> Although subtrees tests uses more spaces for indentation than tabs,
> there are still quite a lot of lines indented with tabs. As tabs conform
> with Git coding guidelines resolve the inconsistency in favour of tabs.
>
> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
