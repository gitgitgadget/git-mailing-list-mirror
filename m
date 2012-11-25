From: Leon KUKOVEC <leon.kukovec@gmail.com>
Subject: Re: [PATCH] gitk tag delete/rename support
Date: Sun, 25 Nov 2012 17:02:40 +0100
Message-ID: <CAOrOd9woDs16as+t-EReQ8NtXfYm9mpd0XaFFs-XL=pg+JK1Lw@mail.gmail.com>
References: <1353649899-15641-1-git-send-email-leon.kukovec@gmail.com>
	<1353688894-2526-1-git-send-email-leon.kukovec@gmail.com>
	<7vzk26xkou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 17:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tceh6-0000fG-5F
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 17:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab2KYQCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 11:02:42 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41547 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab2KYQCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 11:02:41 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so5208490iea.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 08:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hb5gn/pja3XUvpUWI+dkO66Toeo5nM09PT+RuwS5Aeo=;
        b=dHwAzyq/zRI/sCUJATeVdadMr+orl645/JiIBqDskwr5g44e1athKdL8zuYw4fmmaa
         qApRnUIskLJUYrgeTJ6BuXaIAA1TWYylhYbIcu7iSNoLJk1PQ0gqL04421GZgw40leii
         oetfBrvc9tQ3fD0SjXO6GmOSBUJBIqk7ps3MBGTGW2MBt3JOy536buLpc6y9S2lDKqWY
         yeCkpeVDX2otn6Y7Zrsp5edz9CeRaQrGhta0WB0Z8kR8x++vXKpRkROzG7L71CJJqXr3
         4XWEuWYf8Gemy4dJ3rTFa1fXMQbVEodeYAIluMtSibPyymaLl560+t7ru6leXC+OoXzH
         qc1g==
Received: by 10.50.140.38 with SMTP id rd6mr8531277igb.35.1353859360946; Sun,
 25 Nov 2012 08:02:40 -0800 (PST)
Received: by 10.64.27.2 with HTTP; Sun, 25 Nov 2012 08:02:40 -0800 (PST)
In-Reply-To: <7vzk26xkou.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210372>

Hi,

On Sun, Nov 25, 2012 at 7:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Thanks, but I prefer not to take patches to gitk-git/ directly;
> could you prepare a patch against Paul's tree at
>
>
>     git://ozlabs.org/~paulus/gitk
>
> and send it in that direction (paulus@) instead?

No problem. Will do that.

--
Best Regards,
        Leon
