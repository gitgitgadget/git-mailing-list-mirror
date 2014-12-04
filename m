From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Enhancement Request: "locale" git option
Date: Thu, 4 Dec 2014 20:02:21 +0100
Message-ID: <CAN0XMOL5ZZgEJ3zaXOAcxyX47iTM-DQv=+PNsdVrjD4aWwx2iw@mail.gmail.com>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:02:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwbfX-0000P3-90
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbaLDTCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 14:02:23 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:64848 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbaLDTCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:02:22 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so23197501wgh.24
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WG6WOSlnL4HE+/UPFOuqE1NSyjtcsbe4Sorm0pOL+1M=;
        b=GoukmYmTYLQrif3urm/ZBYdYu1LyzCOL9Hh8vzpqM4kcfZZZrfyswxkRAK++x4IJrq
         sm05gRv/k5ut1N8cS6J+j3GtNc7VAM2h5OUK48R60r1cNDpo0fJNJQuoZq660IAy/zaa
         4uVCnudtN/F0nw0O0Kalcc2ozd2J+3ZRZ8zbH3UgW4MK1doO8u2SVWIjGSiV+Wsa983k
         abvAbsimB9Ym7RvskomBfwDFf/zYDdYLhaZ5yV0sP9zTd6a4pIqjQPUyZZ9J/bZL08w2
         J3AC2sWlD3eA3dv2Z5/52ZdIuorkNCd8JnJfTt9cg+zfXIlYZuOIhopv+JDDPZ39RzQo
         IOqQ==
X-Received: by 10.194.156.138 with SMTP id we10mr18900851wjb.72.1417719741195;
 Thu, 04 Dec 2014 11:02:21 -0800 (PST)
Received: by 10.194.235.167 with HTTP; Thu, 4 Dec 2014 11:02:21 -0800 (PST)
In-Reply-To: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260781>

Hi Ulrich,

2014-12-04 8:32 GMT+01:00 Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>:
> Hi!
>
> I'm native German, but German git messages confuse me (yopu'll have to correlate them with the man pages). At the moment git uses the

What in particular makes the German git messages confusing you? What
`git version` do you use?
Maybe we can find something to improve in the translation.

Thanks,
Ralf
