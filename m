From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 3 Jun 2013 13:23:21 +0200
Message-ID: <CALWbr2z7zY6sm_6OTiZhgpjU4i3WwHdbc75V6-0O_0JVMx+svA@mail.gmail.com>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 13:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjSrV-0006Oj-8u
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 13:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab3FCLXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 07:23:24 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:53504 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab3FCLXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 07:23:22 -0400
Received: by mail-qc0-f181.google.com with SMTP id u11so2040274qcx.26
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RNkCAsJL+YEkqFIActo2Eg43l4GG0TQfiOaSIgEKZLw=;
        b=f36tZggWnHbrqB4gsdbfgnXKVac4Z9U2cIbaB14f78hyP7UiCWw6m0HikiFqpe/VuZ
         K009W846KT7Qq8NISlE4AEUKUt3lOFLS6CaceFKl+61IFMcBF7BGeUcUhqyBa8uVf/u1
         LA/1D3DpI22ZXG17xUwWoF8zWbBVuL8wZAG0enGtBEKDi7iaTN336Qvq+e965/RHu3uS
         iomSOJnODeh1LAxGidOgmkm2Bl6RSbIfM+6aPo3XVat+AltxhJw+6p+iasXrZa46K70U
         vQ7qsUFK7jkNd7lQ3fqjPFoh536SyIdRINHMHMwaiJuPkTpvRrQLhjrZ0u1mrBjf1cd9
         wYbg==
X-Received: by 10.49.35.132 with SMTP id h4mr21517027qej.29.1370258601559;
 Mon, 03 Jun 2013 04:23:21 -0700 (PDT)
Received: by 10.49.14.40 with HTTP; Mon, 3 Jun 2013 04:23:21 -0700 (PDT)
In-Reply-To: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226214>

On Mon, Jun 3, 2013 at 1:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * ap/wildmatch-foldcase (2013-06-02) 1 commit
>  - wildmatch: properly fold case everywhere

nit: I think this is "ar/" ;)
