From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] More readable 'Not a git repository' messages
Date: Mon, 9 Aug 2010 21:49:14 -0500
Message-ID: <AANLkTinJ80FT5HMDg6r1Vz+J+oX_35xoWrygE42UAzkA@mail.gmail.com>
References: <i3pdkj$hut$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ralf Ebert <info@ralfebert.de>
X-From: git-owner@vger.kernel.org Tue Aug 10 04:49:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OieuK-0005QY-3N
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 04:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab0HJCtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 22:49:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47292 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab0HJCte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 22:49:34 -0400
Received: by gyg10 with SMTP id 10so3624314gyg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 19:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=N2abJHwfg7vtZspBGTUVKNGKbP4/4APY3mjBiaesD1o=;
        b=dYG2Q+ONczZrvLE/QbYcMNKjWYRY1NSYLLiEvR5FW4hYtRGRUIhQcYMS/idNLpI5Z/
         XZgfADwqqpmNkubM6oydmqrxJaijO/OgDO7ZJrso86GToUBhrKhT9F/7Jy2ZgepkZJaO
         jtUT7i/pTE4N+P/XsFwNCoPC5gUXfsIgjmEfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=h/SqG7WvCWsG/bdV+q2ZO+pt83BZcGPypwpfzmIyLBO1QjLmGHZAU9KJQulX8qNPxe
         ITkdz284Ujg3hu/xglBnTr2ccgkHRHSVpQM26O2C1yQUdw3oOWZdicgpP1E9DYjZnAyH
         SCM/U2yXEMeNljN+AvZKAL3f8MWIOdTEGhm3c=
Received: by 10.151.99.19 with SMTP id b19mr11120886ybm.445.1281408574118; 
	Mon, 09 Aug 2010 19:49:34 -0700 (PDT)
Received: by 10.151.6.12 with HTTP; Mon, 9 Aug 2010 19:49:14 -0700 (PDT)
In-Reply-To: <i3pdkj$hut$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153071>

Heya,

On Mon, Aug 9, 2010 at 12:24, Ralf Ebert <info@ralfebert.de> wrote:
> Stating the folder concerned with the operation and wording the
> messages differently make them slightly more readable.

FWIW I like these improvements, nice work.

-- 
Cheers,

Sverre Rabbelier
