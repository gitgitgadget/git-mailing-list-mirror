From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Makefile: Add help target
Date: Wed, 25 Aug 2010 16:39:49 -0500
Message-ID: <AANLkTimA5YWANGRE19psyuunYLiskSoEunQmsY1UNtyc@mail.gmail.com>
References: <1282729913-25114-1-git-send-email-bebarino@gmail.com>
 <AANLkTi=+f4Q6JJHfX75A57-gzBxqsdr+CrCf9Z9fqrEq@mail.gmail.com> <AANLkTimSP=4bMwN_DAuDoaG5mGACYJYp2TTyDKSFY5BF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 23:40:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNhg-000202-2P
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab0HYVkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 17:40:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52405 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab0HYVkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 17:40:09 -0400
Received: by yxg6 with SMTP id 6so391847yxg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=8bL+55Ndjdu70IRf9MT543SoybGIDI74CfdEa96ZVxA=;
        b=Cddk8fvWCgX/mrr+wlN/+HrZX5slTAY7MnIGGo0BzWw7rasQa/NV7iwJwPYTw0knRQ
         VzkqqVPJvM66DW9Zp+VI3HYiqHPpoiM0BIsUjPqpIbBzHCB+GWYEfW+50RgK0keDA+9t
         sK845wxWZAToVdAkzMRqPnCQKJZVluUkwvp4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PrVObHooTMSVtDnNFfogJhueUINxBJMy7iepQXHwZq2cnQcUZKp4SFTDzK6ATeJtmP
         oxkU3M/H5+lClnNVVU4625tKVGxUk8zUbQV4tBrkgOnC7nttp4/HasJ4WpBSBGcowmMH
         gSqQyapTuq6GrA1XNh+PM57ubSAzVgWB81qp4=
Received: by 10.151.7.3 with SMTP id k3mr9258992ybi.386.1282772409192; Wed, 25
 Aug 2010 14:40:09 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Wed, 25 Aug 2010 14:39:49 -0700 (PDT)
In-Reply-To: <AANLkTimSP=4bMwN_DAuDoaG5mGACYJYp2TTyDKSFY5BF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154479>

Heya,

On Wed, Aug 25, 2010 at 16:36, Stephen Boyd <bebarino@gmail.com> wrote:
> "Yes please" means you like it?

Indeed.

> I'll keep an eye on the list for any interesting Makefile targets, but
> no promises ;-)

That's all we can ask for right :).

-- 
Cheers,

Sverre Rabbelier
