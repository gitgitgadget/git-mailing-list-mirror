From: David Barr <davidbarr@google.com>
Subject: Re: translation
Date: Wed, 18 Apr 2012 13:00:51 +1000
Message-ID: <CAFfmPPM4VcQuN489J06wA97C6aNy8TZueJ9pL-U2VVVXwjwKOw@mail.gmail.com>
References: <CAKVccoUsiptV7eyD9qhoyrxs7OCot-d8WSH6C89C61EL+QLHww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: simple w8 <simplew8@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 05:00:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKL8c-0006MF-3D
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 05:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab2DRDAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 23:00:53 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42823 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab2DRDAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 23:00:52 -0400
Received: by gghe5 with SMTP id e5so3473967ggh.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 20:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=0ezDabrPxlmS+NS3Oydr/WTx68b03ooBfn6tJ1ybki8=;
        b=bO/z25/T4a8v4HMcJFejxzmhaqqAeRlzNc3Spz8K+vIj2G5R4D/bTNGNK7HsePHusi
         xYeONRXXInz32TN+v9OzXjs+J9HGw+SMfsJjIFs/JbcW4xENzDiNz8VYzdcsY2wAf6W6
         AVN0zzH56tnqs8km7znPPm/TqoUAjjMnNTwNLv7p9Uuvb+UCX3EC5Dq1B8tQNIJ6SeBm
         pleDsj2SfFBi2/vo+1X+DUwBOJEVxE9Hi1dT1/4UR5BYSZ49uM88hYNC1bfuYUPhqD6d
         Cki1B+WRkgNDCCgVfuq0+18ISLpcFWtZzR5Gkv0Tbzws+/YOvCXHi0q7I4o1VLmyCbv/
         7Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=0ezDabrPxlmS+NS3Oydr/WTx68b03ooBfn6tJ1ybki8=;
        b=elfOZVfuOweLYCBc5Fb7V0bAyKc4YP2XZT8YAtuL2kisd7P9onGFzq6GzYKEJ4oXZ8
         XT0UIZztpZJudOmo++wDM1439sJ8pqgBccDMnsTGeSMGB8wMlVTJvBSLGvQBK/hMgYZk
         vh2+rLw70R/r+n480hXuYQ9AweQzMu6wLR3uj0CarQOl3DsDJTh3YOmd+9i/33M0G/Mt
         tHjGX8FgeXr8+ybXXDHNzAjPcY4tMqPtimiRNevqpzh4ZXa4WVeBW6C8BeGuomV2r1MU
         hYb4Zl8/txTDBM9b1bT+n85KR8FADx9ITCZ3EzrqV2//QzrluIqiaZLprBnth6TkjxsJ
         jDIQ==
Received: by 10.236.73.99 with SMTP id u63mr467494yhd.102.1334718052227;
        Tue, 17 Apr 2012 20:00:52 -0700 (PDT)
Received: by 10.236.73.99 with SMTP id u63mr467483yhd.102.1334718052052; Tue,
 17 Apr 2012 20:00:52 -0700 (PDT)
Received: by 10.101.83.5 with HTTP; Tue, 17 Apr 2012 20:00:51 -0700 (PDT)
In-Reply-To: <CAKVccoUsiptV7eyD9qhoyrxs7OCot-d8WSH6C89C61EL+QLHww@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmav+7AyLizla+wMRPLzTSYJGFEhnQqV/apiQpZEn7jcO929k7quQUwSuLY7WClGZUrRpnAx5kxtFsANlTWzv/Xe9XdKIBwWT38M0g2zV23eHQbo8lPNbMKgwmElrHvpdwoyFdDzPRoRJgP/epjqtlZaE4gMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195836>

On Wed, Apr 18, 2012 at 12:30 PM, simple w8 <simplew8@gmail.com> wrote:
> Hi,
>
> I have runned last git version and saw that now there are some strings
> translated in my native lang, but they are badly translated, with
> spell errors, severall with untranslated string mixed with translated
> strings, seams the translation is not being done by someone that
> speaks native lang.

Which language? Although, I think only a handful have landed.

> Now i ask how is possible to fix this situation?

See "l10n: the maintaince(sic) of git-po repo" [1]

--
David Barr

[1] http://article.gmane.org/gmane.comp.version-control.git/191751
