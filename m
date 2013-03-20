From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t3200 (branch): modernize style
Date: Wed, 20 Mar 2013 15:50:43 -0400
Message-ID: <CAPig+cSAzCM893kunUO=FM5Qh0-+5YON1KfbG4rUiDjZ8CvV4w@mail.gmail.com>
References: <1363782612-19260-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIP2X-0002s8-2B
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757782Ab3CTTuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:50:46 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:44298 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3CTTup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:50:45 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so3635059lab.24
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Ra213UC09SWkRAauL/mHRLHs9p2Lom1HzQ6OdmFoeV8=;
        b=KCAi0cfuJt+DrszOgLXS781jjPAmuVQatEnjiOKivx9QNYxODIDLcb99HFqCmJBv1u
         Wf+nsDmE4DjFVSgQqdYD/sjymQWV6b4Z/+5N95zM+Ay3U6BY+7TAvft9qSxNb6RSs2X/
         b0bDWxxkIMcEcwXh3zK2jnBmxxMaNPUDgLh0NEJaqZLqrWeNw7YaNfHsZh8Zxb8frWTo
         7H+RciqnrbSVvFmuo5uwTZ/Ct6qVtQpjNk3YeSnDuFJO7hTHfPHNVZ4vlk6DAvoAs3ne
         oUovbE/AioZ7suenBwrplvCZyDJ0YG43Q8Tr9AXh8liCEDtJHr1CujDr8SOURPBQ/lDz
         aNXA==
X-Received: by 10.112.88.35 with SMTP id bd3mr10325048lbb.56.1363809044066;
 Wed, 20 Mar 2013 12:50:44 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Wed, 20 Mar 2013 12:50:43 -0700 (PDT)
In-Reply-To: <1363782612-19260-1-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: RqnesVbt2Ze0hMf30dpxnzoavKY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218668>

On Wed, Mar 20, 2013 at 8:30 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Style is inconsistent throughout the file.  Make the following
> changes:
>
> 1. Indent everything with tabs.
>
> 2. Put the opening quote (') for the test in the same line as
>    test_expect_succcess, and the closing quote on a line by itself.

s/succcess/success/
