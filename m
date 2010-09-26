From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Sun, 26 Sep 2010 18:02:43 +0200
Message-ID: <AANLkTikXSfO0uGP1b20jkF09=Mfq0s0+4d4_ANeprXF_@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Rico Secada <coolzone@it.dk>
X-From: git-owner@vger.kernel.org Sun Sep 26 18:03:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzthL-0002rg-B2
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 18:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108Ab0IZQDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 12:03:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43585 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab0IZQDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 12:03:25 -0400
Received: by iwn5 with SMTP id 5so3980069iwn.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=HDvW7aceJcaScmNkCYCUK5mEAW53vZGx0d0DCqN+aV8=;
        b=caF1YdQKI/LEpN9hz50ntC70TowfrHXdfrcElxsgAVF3T1qX5XDyZGJqKrjaT0czVe
         iE9nwCpHw5r7iVXCef/hrfC+7x/kiaXFCzM3VsFtxGFZ77uCYNxXVJ0ITXgO28XKZkC5
         +7wuS8oyHh9KdLU7VaCxpNoOvo3fq4qbrPwpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gnMj+IMELYvTwcmBuJaQiGN6M6KhKE38X5Qjw5v7irQIeYWJNdlt+DX3OPRs03h+zC
         appQPaKBwAv/Z0hZuiLeDUYk8D4ksUV11x17yJQGB26PPbT7GQUWh8mol6pVLO65Qg4z
         Y68zNrMzCKMZEr1uCRUXIVzxcvyyTcRmorY28=
Received: by 10.231.31.129 with SMTP id y1mr7499783ibc.45.1285517004380; Sun,
 26 Sep 2010 09:03:24 -0700 (PDT)
Received: by 10.231.197.143 with HTTP; Sun, 26 Sep 2010 09:02:43 -0700 (PDT)
In-Reply-To: <20100925230022.6e2fd389.coolzone@it.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157235>

On Sat, Sep 25, 2010 at 23:00, Rico Secada <coolzone@it.dk> wrote:
> Would it be a bad idea to split the Git mailing list up in several
> sub-categories?
>
> Example:
>
> announce@
> dev@
> user@

Why not, but the simple way is to create another ml for patchs.
Without patchs, the traffic seems relatively low.


-- 
Sebastien Douche <sdouche@gmail.com>
Twitter: http://bit.ly/afkrK (agile, lean, python, open source)
