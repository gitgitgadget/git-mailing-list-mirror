From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Documentation: clearly specify what refs are honored by core.logAllRefUpdates
Date: Tue, 12 Jul 2011 19:03:14 +0200
Message-ID: <CAKPyHN1VgG0A9+NpPS=d5hcBahr49f7oM1JonNEohyQx3=0AHg@mail.gmail.com>
References: <c63583df97ff8dd596d16d4471041d6ebedb67e8.1310375571.git.bert.wesarg@googlemail.com>
	<4E1BCFF8.9030000@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QggMj-0003qu-9S
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab1GLRDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:03:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40528 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab1GLRDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:03:15 -0400
Received: by vws1 with SMTP id 1so3601012vws.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=73VF0e/EogJYtS+ZyGInivI79rTv/snL88cILmxFS+A=;
        b=UUR1tkX6KfzH4GlIMZtpPc9/VwG21XhT/jWtxEH7md8sFwUYyNEL5SA2HUKI5XcvYS
         +q3NOAag4I2CjPKp44j5Z1vH7mpbvof5X3emija4rSbof94YE/YU7DksuPz73ee4IFBm
         /WJyfAoeGORu+Fdo2ezoAFBNkTpVAlHBBUOqM=
Received: by 10.52.23.69 with SMTP id k5mr181086vdf.396.1310490194899; Tue, 12
 Jul 2011 10:03:14 -0700 (PDT)
Received: by 10.52.185.105 with HTTP; Tue, 12 Jul 2011 10:03:14 -0700 (PDT)
In-Reply-To: <4E1BCFF8.9030000@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176953>

On Tue, Jul 12, 2011 at 06:39, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Minor typo; see below.
>> +     refs/heads/), remote reafs (i.e. under refs/remotes/),
>
> s/reafs/refs/

Thanks.

Junio, you applied this already to pu, do you need a patch?

Bert
