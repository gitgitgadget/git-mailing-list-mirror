From: John Szakmeister <john@szakmeister.net>
Subject: Re: Can't connect to git-scm.com
Date: Thu, 28 Nov 2013 09:05:58 -0500
Message-ID: <CAEBDL5WodmZnC4Sde0axgw5tMhgot3s-oOrkAMp5d6uhY4+coA@mail.gmail.com>
References: <CALWbr2xdmh3DfgaJr=MEWwpwpoR0x=Go1oyUm9_ri31mvDyCEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 15:06:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm2EK-0005Ee-V1
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 15:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411Ab3K1OGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 09:06:03 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58473 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3K1OGA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 09:06:00 -0500
Received: by mail-wi0-f178.google.com with SMTP id ca18so888675wib.11
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gepD7eQqkMB1/baWRjJlpMpJIVkBssnFYBm92qGIxTo=;
        b=k1B2srseU7O/IxUaWDsCB6aqo0NnU2YJ7s4/HRH60iqPJ1xIQNGewYtL3s4kcmmcTa
         HDDyDNRlNixnbmED28dHMk5xXkWh7VQou6dJ0j8iSJNMCFeclY6hrl2tzu+ZTZblZ5A/
         74QYH/CnuJmYpapApta9nRfFeCget4Vf3ZeTvxRvbQxFVSn4FQGFctzWiW3fyI/kWvG3
         tK9kMm4xx//aql7z6IlbS1WCetg14DWfslWoIq5fEw6UF6IFAuDNx+otnVr2BC7ZRaSK
         luCBdK+KeE+qe1TNF/03C+iAE8PkNeeWWs4Afz8JveS+LX1LvcxxBanf4yd97q2Cx7Gd
         5GYg==
X-Received: by 10.180.73.111 with SMTP id k15mr2598803wiv.39.1385647558718;
 Thu, 28 Nov 2013 06:05:58 -0800 (PST)
Received: by 10.180.99.169 with HTTP; Thu, 28 Nov 2013 06:05:58 -0800 (PST)
In-Reply-To: <CALWbr2xdmh3DfgaJr=MEWwpwpoR0x=Go1oyUm9_ri31mvDyCEQ@mail.gmail.com>
X-Google-Sender-Auth: aoG2WDW6qsSMTXnftl-2fCFvWos
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238495>

On Thu, Nov 28, 2013 at 8:47 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> Hello,
>
> Should we be worried by this behavior ?
>
> git-scm.com is returning 301 to www.git-scm.com (I don't remember that
> it was happening before)
> And www.git-scm.com is returning 200: Sorry, no Host found.

I'm not sure what happened, but it seems to be working now.

-John
