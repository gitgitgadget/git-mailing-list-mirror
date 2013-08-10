From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] whatchanged: document its historical nature
Date: Sat, 10 Aug 2013 12:34:32 +0530
Message-ID: <CALkWK0k61F042_5uZ_1QXAzyZ6u-XppB+TLHwkCDsuj7u=B-WQ@mail.gmail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
 <52027B17.7040602@googlemail.com> <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
 <CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
 <vpqfvukdy39.fsf@anie.imag.fr> <CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
 <vpqvc3gcijh.fsf@anie.imag.fr> <7vwqnw9jv6.fsf@alter.siamese.dyndns.org> <7v38qi63bn.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 09:05:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V83Em-0005p7-BN
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 09:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955Ab3HJHFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 03:05:14 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34343 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756755Ab3HJHFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 03:05:13 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so747790ied.30
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=izojwo83DeEWtYjq4UqRoaAx91CG9vjNOnLlQLPvFbc=;
        b=j/XHhgQ+Q6pgYOtnCJQlk0XZn9QH0/PM3ouj6tCQ64yh7HDqwWldHb9BSw9dCr9lZw
         49Eryh7eCmPhuw7jqeMEjaFyM1e1Haqgd8VUqH40TtoW8nvIhOkGIAHNdsNilYds2Hsy
         6KWM7kLIubcmbEKUn13hBvR1EQe5iXZ15q+n6fbUkAljiOX+4vaaIb69rsP3J2t81Qb5
         oaGlkU+6AOfGT8VAcEgtsmmv1LzJVBrPNLzsOkBy6Wd4pgHFA3G9TZTTg2A3vME7Lo4z
         MI10jxTFUX5HebONUwnemzFLqjkpaP9sB1JRWvqWf53678j0cRpr3GvwidA3/LUwSk3G
         iMXA==
X-Received: by 10.50.114.105 with SMTP id jf9mr4131910igb.12.1376118312284;
 Sat, 10 Aug 2013 00:05:12 -0700 (PDT)
Received: by 10.50.119.34 with HTTP; Sat, 10 Aug 2013 00:04:32 -0700 (PDT)
In-Reply-To: <7v38qi63bn.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232072>

Junio C Hamano wrote:
>  Documentation/git-whatchanged.txt | 41 ++++++++-------------------------------
>  1 file changed, 8 insertions(+), 33 deletions(-)

Looks good. Thanks for doing this.
