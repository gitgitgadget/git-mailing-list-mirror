From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 0/3] git over TLS (gits://) support
Date: Mon, 3 May 2010 13:58:05 -0400
Message-ID: <s2h32541b131005031058o4d2df47ei7fcd5205db89eeb7@mail.gmail.com>
References: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<j2tbe6fef0d1005030557l1f746349zfce18213add19efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 19:58:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8zub-0003XV-Be
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 19:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab0ECR60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 13:58:26 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:39302 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab0ECR60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 13:58:26 -0400
Received: by yxe1 with SMTP id 1so434272yxe.33
        for <git@vger.kernel.org>; Mon, 03 May 2010 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=RfoEDfPvrbkPfqS/f6qAiRIgiB3xSin4snI5Wuis92M=;
        b=pYRmnLapT1C6m88bc8NomxbfHJQ9CXSgyKdS7QklgTV5LrK/Yq8puWukVNFZJQ1GcI
         MVQ8GIJ/r3gV1dXLQ7/7+tYNbxtdN6hNQPESVNeG7CFA6cy/9MRLVhm+wR+ywB7H53Jm
         t8BOa+56ffSqnR+kD+u7Ox8J91/5KsQ6OLChk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=C0tIwSMNKqSnUO4gG7K5l4qFklFBBgIKZtcf2kdaRjAfsEwqEuaSLWOdj/TJmiA5Yh
         PNND6Yf/J/WsLULvLgv8S41/t19z89tf/vKq7aOCmMHGHspr1U9W12jgKIFlT91W5BQx
         xR/wL2cGg35xKDti0H1Z09rfejI3wYWx3rtn4=
Received: by 10.151.89.35 with SMTP id r35mr9936873ybl.52.1272909505235; Mon, 
	03 May 2010 10:58:25 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Mon, 3 May 2010 10:58:05 -0700 (PDT)
In-Reply-To: <j2tbe6fef0d1005030557l1f746349zfce18213add19efe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146245>

On Mon, May 3, 2010 at 8:57 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> From the discussion, Avery (Cc'ed) had some strong objections; the
> point that I remembered the most clearly was "why not just use SSH".
> There didn't seem to be any headway.
>
> I hope that we can continue where we left off and resolve the various
> objections without too much duplication of shot-down arguments.

After more consideration, I withdraw my objection since the fact that
I don't need it, nor does anybody I know need it, isn't actually a
good argument against including it.  I assume the Powers That Be would
still like to see some people who *do* need it before including such a
huge chunk of code.

Have fun,

Avery
