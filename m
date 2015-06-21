From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/11] add options to for-each-ref
Date: Mon, 22 Jun 2015 02:21:48 +0530
Message-ID: <CAOLa=ZRLzTm1nW+JMUTqGgZ_H25A53NyHNVnH-Fd7GuBgrH+vA@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 22:52:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mE3-0007IF-Gx
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbbFUUwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:52:20 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34178 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbFUUwS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:52:18 -0400
Received: by obbkm3 with SMTP id km3so9301124obb.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MBzPA66Q5Evh2MdiSbFQ1jXv1TwESI+K0DfUz1XhAXw=;
        b=cEegqREdk0BchqviEuLHWAkEzKzGMJD6Nb+1pGDx3Ak095U+lDeWkpnBmzISX9TK0c
         i0XnFL4Fu+iuAiqlhJSVH4q3nqfug7FUxUhtRrdzDwlLLhZDtj2t4CYz+NmZWiKIVivS
         PtQ5Ustd7ooy5zNXZNPYFyALv0NCmULWIo7Zhu9NGQdy92MTRnuR3ovERSmJb0dlIyg7
         ynUpJk0DvjsE4i9Yf9qU8mnwPHLOoZFtoGYs/NucDZitrp3gLfQPRb9MJtacwdxWX6jq
         Cm5P/pSTrOu9Tf9dozboa1z/QsF/24PWYYAtohE/EbGXLCWQM6kJmCWZGA0guUhgxWK2
         8siw==
X-Received: by 10.202.92.68 with SMTP id q65mr9493598oib.11.1434919937994;
 Sun, 21 Jun 2015 13:52:17 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Sun, 21 Jun 2015 13:51:48 -0700 (PDT)
In-Reply-To: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272298>

On Mon, Jun 22, 2015 at 2:15 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> The previous version of the patch series can be found here :
> thread.gmane.org/gmane.comp.version-control.git/271754
>
> Changes in this version :
> *   01/11: Remove unnecessary tests and add signed tag.
> *   04/11: Grammatical change.
> *   06/11: Introduce a comment to explain code.
> *   11/11: Grammatical change.
>
> Thanks to Matthieu for suggestions on the previous version
>

The patches end at No 11. Even though they show XY/19.
I have more uncooked patches on my branch, which I'll eventually send
to the list.

-- 
Regards,
Karthik Nayak
