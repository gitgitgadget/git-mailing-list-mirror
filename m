From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] column doc: rewrite documentation for column.ui
Date: Wed, 26 Jun 2013 12:07:17 +0530
Message-ID: <CALkWK0mkdsJpLPpXLdNwdtFS39Vwfer50LpFU3_eegSPHHsUog@mail.gmail.com>
References: <1372175676-5423-1-git-send-email-artagnon@gmail.com> <7vobatzvfg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 08:38:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrjMf-0005p4-RG
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 08:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab3FZGh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 02:37:58 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:50716 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab3FZGh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 02:37:57 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so30450392iec.27
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+UEJWRDaPKTxGkTBQ+1Xm+Nd8yXk+Ait1eSAZuWZp/g=;
        b=YPLPjKGuG9gF1bou90drGL+hPijh3nWstVY3fqV+9U3mb1IW51AsPp0y76x5sj3pLF
         HximYaTUw7nEazCie3VABb6UBh/FM1Q5vpSnUIoXapItesY4MLAcCBrpTis3IAxay+XZ
         46N82j7Biep1hcMEz6VHwyrzsAzKJBrfcJx9Kmtk9zpaIHjiO4MDioPxjRlKhRyvaG35
         JeDu/snz3ybD9Uu32rgGMV1y7C36bjDw2y7xvFGtgm+OqmREc++uSiHdJMS0LdtMe24T
         EkrdFJhO4yDKzBHCUWM8wW4fMaPe2taTddtp4+ucMn+EZeeLhp214ERYY4+Y0JfnKU6U
         Z/4g==
X-Received: by 10.43.88.3 with SMTP id ay3mr1216751icc.61.1372228677470; Tue,
 25 Jun 2013 23:37:57 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 25 Jun 2013 23:37:17 -0700 (PDT)
In-Reply-To: <7vobatzvfg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229031>

Junio C Hamano wrote:
> One micronit (read: if you think the suggested change is a good
> idea, I could just locally amend it) is that it would read better
> and also easier to maintain to say
>
>         These options control
>
> without "three".  Both 'man' and 'html' output looked good.

Sure, amend it.
