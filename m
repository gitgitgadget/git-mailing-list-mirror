From: Yi EungJun <semtlenori@gmail.com>
Subject: Re: [PATCH] http-protocol.txt: Basic Auth is RFC 2617, not RFC 2616
Date: Sun, 15 Jun 2014 17:20:49 +0900
Message-ID: <539d5765.e9fb420a.5e43.3d3f@mx.google.com>
References: <539cafe8.c1a4420a.08dd.fffff66e@mx.google.com>
Content-Type: text/plain; charset=utf-8
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Jun 15 10:21:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww5gS-0004AO-Q8
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 10:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbaFOIU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 04:20:56 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34220 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaFOIUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 04:20:54 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so3442434pab.8
        for <git@vger.kernel.org>; Sun, 15 Jun 2014 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:references:in-reply-to:subject:content-type;
        bh=bjxCumCwKwdkNh93kNeO6su88yJ0UQLtwgl6yLYmOu4=;
        b=wvlf/RUE9lubWrS5joHeThEfRaMpd1Wpzn7oZ4Zhes94YD+KMCt8rbwFXbIcHjrUmP
         XK7WNTZBRhklgY1bqBTVpSb/PmEB8WSkgruU1K3P4w+huAgpggSz1NCjw6kRoOSIUkXk
         0UQmuZfu3vUhLastw+JzbNHBYnoucWWuXOv/m3iKm1Oe1Keblrrzwq4tE7gymIVDM2FX
         jWew11y5icqf32sfP4/JVTOo6f8QlDp8YGN7GLiWWsDnhR4EhCgxGmpOBvq1rnFGvt/K
         N9QkY2JRoIQg+OZbSSUywuFqoet9N2xCLzs1VKAyz/7JtztoYT4rh6xnsYrx/2girzkG
         bKQg==
X-Received: by 10.66.192.104 with SMTP id hf8mr15701497pac.13.1402820453567;
        Sun, 15 Jun 2014 01:20:53 -0700 (PDT)
Received: from nori-ThinkPad-X1-Carbon ([14.40.27.230])
        by mx.google.com with ESMTPSA id zn9sm49454065pac.31.2014.06.15.01.20.51
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 15 Jun 2014 01:20:53 -0700 (PDT)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
Received: by nori-ThinkPad-X1-Carbon (sSMTP sendmail emulation); Sun, 15 Jun 2014 17:20:49 +0900
In-Reply-To: <539cafe8.c1a4420a.08dd.fffff66e@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251672>

Could you change the author to "Yi EungJun <eungjun.yi@navercorp.com>"
if you apply this patch?
