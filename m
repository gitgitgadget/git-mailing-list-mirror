From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] for-each-ref: introduce color format
Date: Fri, 17 May 2013 22:53:53 +0530
Message-ID: <CALkWK0=8nwU5d17=ci0yAYYzMiihQbHBqscfD2nUGgwPPirLkw@mail.gmail.com>
References: <1368802552-16024-1-git-send-email-artagnon@gmail.com> <7vsj1lzfo8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:24:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOOU-0008Jb-Gf
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430Ab3EQRYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:24:34 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:45666 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab3EQRYe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:24:34 -0400
Received: by mail-ia0-f170.google.com with SMTP id l29so5206457iag.1
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2g5JzOrHkAJOoTWd4IgT3zk2FXQMJkHgfxgE8ptmwuQ=;
        b=HRpnJbe+Wk232OXZoyI88GvP8/bF9rybjgn/qysYv3eU5u95IttL3UOkSliludrT9U
         m4yonRoU+BYfb6QFQal40l8CUR+LrO+rTyVntX0VjGXOmstPVlvkhZ7stec92OnwCEA0
         PDpqKKTQJh3IsZ9oExAzvm5d7crRM979AeT62hTytWK/ciOTdCktlHjkUUEKRR688dlN
         J6HVfMliPpbmzW5PFjeepGD+t0u92YEruMyEYiajjfiGHZ2cwW6syvrIOhUrePMONHKx
         Ana0SC0Q1CetCDzjscVogJgn38sZgLMm6GjtgvV/Xsu/EO35XnZb+kU3pBuyJNYcIsAY
         7rPA==
X-Received: by 10.50.3.38 with SMTP id 6mr13658790igz.44.1368811473605; Fri,
 17 May 2013 10:24:33 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 17 May 2013 10:23:53 -0700 (PDT)
In-Reply-To: <7vsj1lzfo8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224716>

Junio C Hamano wrote:
> Doesn't Duy's more recent work on the pretty-format front introduce
> alignment operators?

Oh, awesome.  I know where to steal that from now ;)
