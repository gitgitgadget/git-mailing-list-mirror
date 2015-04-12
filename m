From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Draft of Git Rev News edition 2
Date: Sun, 12 Apr 2015 22:51:47 +0200
Message-ID: <CAEcj5uUjCqfGgVxNncuHEeqLNfse9d0gM9gbwWOX_oD5LNOKcQ@mail.gmail.com>
References: <CAP8UFD00=Qc_WdUHWPt9OD2EjY_ufsOiA5CL3rWEpBCkjZYADw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Rick Olson <technoweenie@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	John Garcia <jgarcia@atlassian.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Tim Pettersen <tim@atlassian.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 22:52:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhOrH-0003Ze-C2
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 22:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbbDLUvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 16:51:50 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35811 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbbDLUvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 16:51:49 -0400
Received: by lbbuc2 with SMTP id uc2so45470663lbb.2
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I7iMg0icJ5cHbVtV4+RcwIn0e2G/48QoXdU/CW+Wrf4=;
        b=xtWTj7N7MxGM0hkJGMFVNSwdtnCEtlFkKbqfD2a5BiYUqSaaH256aVpxrftdjGRM7t
         pP2Q2+s0WF5gLyLsWg3y3r6+FGbQdiyj/cJ9H65SqLT3WaoDUATtrI2IfOEXvnf60oU9
         ECJdreFvZS1PpXIDizhGaUBowPyJgkJaRZ86npjWmj9xv23GNlMB3FpDM7hYBwIyQ4Q9
         WR6eJUgzsDc7jwRKDYb8BZYEOYUhZxMBvpFIPHiPeMM/bDBu0EiOuK8ASIsriOMeWIqp
         wZgJd+/kuzxkBlOubxQ+LdY4fZ8GWSOAQscR0q5BAtd7KipOiasZDTNs+dKzzZM5thcJ
         Dpmw==
X-Received: by 10.112.51.114 with SMTP id j18mr10153023lbo.97.1428871907408;
 Sun, 12 Apr 2015 13:51:47 -0700 (PDT)
Received: by 10.25.159.10 with HTTP; Sun, 12 Apr 2015 13:51:47 -0700 (PDT)
In-Reply-To: <CAP8UFD00=Qc_WdUHWPt9OD2EjY_ufsOiA5CL3rWEpBCkjZYADw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267055>

On Sun, Apr 12, 2015 at 9:03 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> A draft of Git Rev News edition 2 is available here:
>
> https://github.com/git/git.github.io/blob/master/rev_news/draft/edition-2.md

There's also a "secret" live preview here now:

http://git.github.io/rev_news/draft/edition-2

Btw, I've just added a bunch of Git-related releases, including the
Git for Windows RC and the Git 2.4 RC.
