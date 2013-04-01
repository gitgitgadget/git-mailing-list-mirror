From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] remote-helpers: trivial test fixes
Date: Mon, 1 Apr 2013 16:46:54 -0600
Message-ID: <CAMP44s0cUZDuzdzR9k_UBgmKn4=dy1he8o=XuPag=LhjWMWJoA@mail.gmail.com>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
	<CALWbr2wAJGemYziPsOkArJveK0F+4Pv80gdR1SGUxchb0ci-sg@mail.gmail.com>
	<CAMP44s2d-gZHsgibq2E8vZ25vciJRBh5Z0hYmx5pNa+CW5gvyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 00:47:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMnVd-0005jE-BK
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 00:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758739Ab3DAWq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 18:46:56 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:52278 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab3DAWq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 18:46:56 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so2401542lbi.14
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kCc3iN0jvlSEki5J9LkZtBJ6S+0WRz7wMZbAbT/j8k8=;
        b=LSwFhwG+CrfaTtJZrZqIxkJld9XwPzmXA8YhdIKQ6Q/mDGK3ZPp8opwiexIFqubZRl
         uLN0KGHY81+zXfQn+odhi1Sm8L+oTU7srgkS3cJzKLvjtNzvsCGD6CD0jFBWugsd0Ykc
         dncuE9UV2hOQwoh0Qe1PIP6Gb580yTyBZnhzJYye5RaEXYqaQzMqfSiKtdJVr9EdtGaQ
         UzTN7IloFqGHNENWKCrIsk0EusxXXBwbxMJDLFOiMyYVZydAJWYKxPVcqtcPkxkeRA+d
         EGRJ++LFoXrXwbm6qhdsZdAJfCKIrIG1KYq2Hx5GDlRBhKbSI1V2CtXaep3hbWTrmt39
         dVHA==
X-Received: by 10.112.130.201 with SMTP id og9mr6591817lbb.65.1364856414488;
 Mon, 01 Apr 2013 15:46:54 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 15:46:54 -0700 (PDT)
In-Reply-To: <CAMP44s2d-gZHsgibq2E8vZ25vciJRBh5Z0hYmx5pNa+CW5gvyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219721>

On Mon, Apr 1, 2013 at 3:56 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> You probably have a very old version of mercurial that has a bug, this
> should workaround the issue:
> http://thread.gmane.org/gmane.comp.version-control.git/209491

I meant:
http://article.gmane.org/gmane.comp.version-control.git/209581


--
Felipe Contreras
