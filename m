From: Vicent Marti <vicent@github.com>
Subject: Re: libgit2 status
Date: Sat, 25 Aug 2012 13:46:50 -0700
Message-ID: <CAFFjANSDyREbNH1qRgYRPw1C87+D=Ft+ZirLvNihkj3UxF-=Eg@mail.gmail.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: greened@obbligato.org, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Aug 25 22:47:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5NGk-0006Fq-S6
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 22:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab2HYUrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 16:47:12 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53787 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab2HYUrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 16:47:11 -0400
Received: by qcro28 with SMTP id o28so1875590qcr.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=47Bbp5wr9VO9tv053QEsw8KJZZZQRJlKnbWzrZ9Ou7M=;
        b=qe85PilOO0QkiW2UUFqg4xJKvHb+RnL9hcM2pibiLS8/FOdxJqXTVJeTv+Ypsxkllx
         a0ohEEctbcG1Qz5OfB5w/UNYj/+048fy85b5Y3Odw2GoRuHN/RvLQj7s7+Qgk1dLer0S
         0/7K8fkB4bHFxg44TKRq99CXk0YCda1xNUxRpjITBs4kdEe4B25Ccrl2qAKrfaKWEkAx
         oHuzjHqujOA36KfTHctjFs25CK6x/bmB7KMkaHQlVP+czV4inB8H/mOV9dXv2zfBKVes
         8+8YfBOd8NgbcwlTEfK61iItcOeJCg/qGFreqNneVPBYhdC7jnCUhOyTB6mxTb44cmRc
         BUGg==
Received: by 10.224.214.138 with SMTP id ha10mr15586125qab.51.1345927630388;
 Sat, 25 Aug 2012 13:47:10 -0700 (PDT)
Received: by 10.49.71.84 with HTTP; Sat, 25 Aug 2012 13:46:50 -0700 (PDT)
In-Reply-To: <5038A148.4020003@op5.se>
X-Google-Sender-Auth: zb1a7yRi1XgSO64kH6jIdEyF5tk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204287>

On Sat, Aug 25, 2012 at 2:56 AM, Andreas Ericsson <ae@op5.se> wrote:
> Politically, I'm not sure how keen the git community is on handing
> over control to the core stuff of git to a commercial entity,

The development of libgit2 happens 100% in the open. I don't know what
"commercial entity" are you talking about, but there are several
companies and independent contributors working on the Library at the
moment.
