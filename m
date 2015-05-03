From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 4/7] t5520: test work tree fast-forward when fetch updates head
Date: Sun, 3 May 2015 10:47:53 +0800
Message-ID: <CACRoPnQx9g-VOP88=H19S5TqF6EkKcCFAQfTJ_6vvk2Qwsn5nA@mail.gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<1430581035-29464-5-git-send-email-pyokagan@gmail.com>
	<CAPig+cTBm9iN8bFEZx3rHzYhwapSk4wYcAQXiqtu_BzxNd9VSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 03 04:48:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yojwv-00089A-9F
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbbECCr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 22:47:57 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35726 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbECCrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 22:47:55 -0400
Received: by labbd9 with SMTP id bd9so84939196lab.2
        for <git@vger.kernel.org>; Sat, 02 May 2015 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5rFHeQuTmLOIVMLzNJW34xDe9FRf94S4psY69xfEaL4=;
        b=xFOKNKgOqzGiAbLZlQraJc47lUwxUCaTAQUrWNiA8ghBCVqY5cPPcuW4ImGJz5jJba
         17TwwR2IrIsVPIfdVZ+X0CGOCWv8O2kzRF2MroL+uZC696Fna3UNuiHVxGF5Uazj6yrZ
         pCgjrHnCjRf3yJnfzM4bzmzLoPfHUjWaO3zZH2idzE0HpS0E4BOJSLRWrg05bxAK9nr7
         XFLH3wyqk2keCiUtwEGcMprdcN4Qiy7VsmLZR8I0F4NiBDxwSkOukvlfHqMCmIEBHhzs
         FgXkOgDbzq0eM6Q3PYVtSBhRKfEL7GhcDGI9pXxYO3cGDHsJow4jJIFWX49w3NjXt4zl
         WwaA==
X-Received: by 10.112.167.166 with SMTP id zp6mr14371938lbb.80.1430621273723;
 Sat, 02 May 2015 19:47:53 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sat, 2 May 2015 19:47:53 -0700 (PDT)
In-Reply-To: <CAPig+cTBm9iN8bFEZx3rHzYhwapSk4wYcAQXiqtu_BzxNd9VSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268254>

On Sun, May 3, 2015 at 10:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Missing sign-off.

Right, whoops.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
