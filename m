From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Change "remote tracking" to "remote-tracking"
Date: Wed, 3 Jul 2013 12:02:30 +0200
Message-ID: <CALKQrge-ioMp_YxcEng+h3OcVMtQXFBFbZu=Z8+rwoiEDi7qmA@mail.gmail.com>
References: <1372842754-13366-1-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:02:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJtY-0003OX-M6
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab3GCKCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:02:36 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:57629 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab3GCKCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 06:02:35 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UuJtS-0006LZ-LC
	for git@vger.kernel.org; Wed, 03 Jul 2013 12:02:34 +0200
Received: from mail-ob0-f182.google.com ([209.85.214.182])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UuIcv-0004Ia-5U
	for git@vger.kernel.org; Wed, 03 Jul 2013 10:41:25 +0200
Received: by mail-ob0-f182.google.com with SMTP id va7so6879979obc.27
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 03:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z1uQpvJ5W1oZ0DQR25eGxUqNw4+GdaBdjbtWk7xsUqc=;
        b=l5MBzneSATV87TU8d0s+uKlrUZepDXVxdG9hA+vC63mCGnH5Wbx4kaOetFGwNlAPhL
         gkMigQuxgxE2lv+U54v0AbQvO6dNV/oDO41JVu+FIkLEHrz99m3dUJlHHCObaiUKed23
         DvrIBgW9fTQPRnyfyBGw+1gW1KW5JjTP/dseN/73/ASWHidg7mTbbP7rxcYCIeKGbN2r
         S7yu2KnR6U+5AlOWacRZD5VHgc1ZyEOMrvKKFXCnHMGgdc3vbeM5ajC0IFQ41dLAX5Xi
         uonaamwan/KEzaMbSRUz+JSg/qTKxi5p97h4WRyZjtCswcD54dokPncdof/Ar9bf2byy
         hQBQ==
X-Received: by 10.182.66.77 with SMTP id d13mr109615obt.32.1372845750867; Wed,
 03 Jul 2013 03:02:30 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Wed, 3 Jul 2013 03:02:30 -0700 (PDT)
In-Reply-To: <1372842754-13366-1-git-send-email-mschub@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229481>

On Wed, Jul 3, 2013 at 11:12 AM, Michael Schubert <mschub@elegosoft.com> wrote:
> Fix a typo ("remote remote-tracking") going back to the big cleanup
> in 2010 (8b3f3f84 etc). Also, remove some more occurrences of
> "tracking" and "remote tracking" in favor of "remote-tracking".
>
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>

Reviewed-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
