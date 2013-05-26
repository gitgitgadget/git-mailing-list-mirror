From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: fix french translation
Date: Sun, 26 May 2013 19:43:25 +0200
Message-ID: <CALWbr2w+ooM04nc79XKyVy48c_eH1AES5XgVDwwk+tFpmitLTw@mail.gmail.com>
References: <CAHtLG6ToiRT-EQMFhrR976=gat+8p0GFFyz+9qpqaq36=gVyGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 26 19:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugeyp-00053L-5v
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 19:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab3EZRn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 May 2013 13:43:27 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:45659 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab3EZRn0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 May 2013 13:43:26 -0400
Received: by mail-qa0-f51.google.com with SMTP id ii15so663572qab.17
        for <git@vger.kernel.org>; Sun, 26 May 2013 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=09usiKiNqJohji4ejuFGXSQkEf2UMZg9aQ3DauSDVXA=;
        b=B8it4i+pg8ml1tHK6c6EYAmJtFi3omkvBDLwB6I9Q4hQ0R9FOZcgSBLqeiY7H1UKv3
         csR6pZ5MeveqWMqwn1/5qz4Ehqwajn0+VBHMsQjRIBk2vJ0a6Je9AS3bFB3tEPSOTKgT
         mMRxOfw03nK1rg5KjZo0Bvg8vEaiMbB/BuFD1+3ow1BmWmuryvrS6W3CMJQXxpzv+NRN
         0qpeM5qS0pGeutQN8/HGVdcIAXEpfZ3SN2dx/nVs77shZQ6GJMMScjM/6OD5gJfO1vBa
         AQ3VJzkrNlyB8g1mOpylEHJiCMTRKwEH+vqr6tmRANybh/xv0k/UdyRkVkJFYJv1PJWX
         xMlA==
X-Received: by 10.224.68.10 with SMTP id t10mr15092706qai.24.1369590206055;
 Sun, 26 May 2013 10:43:26 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Sun, 26 May 2013 10:43:25 -0700 (PDT)
In-Reply-To: <CAHtLG6ToiRT-EQMFhrR976=gat+8p0GFFyz+9qpqaq36=gVyGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225555>

Hi,
Patch should be inlined, please have a look at
`Documentation/SubmittingPatches`.

Also, how is "copy" (an english word) better than "copie" (the literal
french translation) ?

On Sun, May 26, 2013 at 5:27 PM, =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@=
gmail.com> wrote:
> see patch
