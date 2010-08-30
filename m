From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 00/13] remote helper improvements
Date: Sun, 29 Aug 2010 21:01:10 -0500
Message-ID: <AANLkTinyPRHnkyH8j1QNw=b2VuJfG6iqvF6SBjHcFXaA@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com> <20100830015321.GG2305@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Optgl-0007dt-M5
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab0H3CBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 22:01:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63591 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0H3CBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 22:01:30 -0400
Received: by gwj17 with SMTP id 17so1821028gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=VvZwbNuRTh1plPoxlEZrQjS7gWryJ63Fov8jS8mqo0A=;
        b=hoDOIFeQql4fvALnCd4I9CEKDWy06z/bhUzNwHtUB4Xzmt6FAOJOW+7khuMuo275VB
         2CnOhwrn9QttvJbRIoLIaeHpxk4uFC3SyrL9Lst6/TgSgo8805INxSgJLERmR8Dzo2Vu
         8ToDwbQoDaTBr69TvM1QrOaOKWuUtIWZ3EhWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=A59n6S8rjA60WgTu5NdSWNR7/sCkfkP3kpCZnNEkrqyhHPQy4nzXr6DbldBbgZFLHA
         53bHf+xV24nKqOcWOoqJtcNlYpZuec/fs94J/3vLCYbmU9TQA1Hdu+2UvrH1JElxvEM8
         vKqHfT0vtI75S5uAKFdI5CvJTf8Mn28HtYKf8=
Received: by 10.151.133.6 with SMTP id k6mr4437191ybn.402.1283133690123; Sun,
 29 Aug 2010 19:01:30 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 19:01:10 -0700 (PDT)
In-Reply-To: <20100830015321.GG2305@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154746>

Heya,

On Sun, Aug 29, 2010 at 20:53, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Sign-off?

The next round probably, I wanted feedback first.

> Very good to hear. :)

Aye, it'll be nice to have mercurial Just Work :).

-- 
Cheers,

Sverre Rabbelier
