From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] Typo in RelNotes.
Date: Wed, 11 Jun 2008 20:59:37 -0700
Message-ID: <905315640806112059r713bf807l20a1bc1e14ce4e27@mail.gmail.com>
References: <alpine.LNX.1.00.0806120434290.5838@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 06:01:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6dzi-0006yo-6s
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 06:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYFLD7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 23:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbYFLD7k
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 23:59:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:17892 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYFLD7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 23:59:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2344724fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 20:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=AyNz/OabQLBeADA9nhdmJstoOOqOy/CA5J1+3TN6X9c=;
        b=R5dRLcsf2alYUx/RU3MzXLzQqHl2d4W6JlJ0R0iOkAh9i67HRQDw9rAtk/80wwO0On
         JBId/Cy8OO1nH6+1qR6zKZrqX2pnMslX4rLW7pnGLO+XSf4fUVpqNHkMl2ZZeAhhICjU
         /S5IXeyaRGWPEkfFj+B+Vsc/uxLE8/mbjpdFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=HwEPqW0YC/Y4ZJfMKTIehcMhwjTOqhVJ/vnOKFo55UcOdBzN38356dW7jJdQT8SOdl
         qSRkMDTnd4pHCKVirhXi47/GbYybjk166QKd+BtA7da0Fh3ppN7b9byfP7WsUJ8QMSUJ
         H42inRmu3wuUAt0kOLW6e3R3npFFSz2exkO4E=
Received: by 10.82.151.14 with SMTP id y14mr43706bud.83.1213243177602;
        Wed, 11 Jun 2008 20:59:37 -0700 (PDT)
Received: by 10.82.157.18 with HTTP; Wed, 11 Jun 2008 20:59:37 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0806120434290.5838@localhost>
Content-Disposition: inline
X-Google-Sender-Auth: 4bb990c9d7cb57f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84695>

On Wed, Jun 11, 2008 at 7:38 PM, Mikael Magnusson <mikachu@gmail.com> wrote:
>  * "git init --bare" is a synonym for "git --bare init" now.
>
> -* "git gc --auto" honors a new pre-aut-gc hook to temporarily disable it.
> +* "git gc --auto" honors a new pre-auto-gc hook to temporarily disable it.
>
>  * "git log --pretty=tformat:<custom format>" gives a LF after each entry,
>   instead of giving a LF between each pair of entries which is how

Any interest in fixing the typo on the next line while you're at it?

-Tarmigan
