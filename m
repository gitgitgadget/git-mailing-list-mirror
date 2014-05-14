From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 14:11:37 +0200
Message-ID: <CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com> <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com> <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com> <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com> <CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
 <87mweku2pt.fsf@fencepost.gnu.org> <CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
 <87iop8u1km.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 14 14:12:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkY2g-0004EL-50
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 14:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbaENMMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 08:12:09 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37207 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbaENMMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 08:12:08 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so1991751obc.6
        for <git@vger.kernel.org>; Wed, 14 May 2014 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N/753Vt6AVl2IPMyw80nk3fx7AYZFMd0rc+hw7Vfd/4=;
        b=hm9Dr5yIsxgJXEkTeZr/D89zkX1eQObYlE/2xAmxGGYxDWsq9yOktYBUnUrye1Sq70
         SVPhMQ+Z+nfpoK3x0oTdnAAK/cwUGm1UMlTUqyjGiJuhZogWhf0EP/OqF3xYwp0CsNao
         zUA5323EfSb6y80meWN4xPa0k0zZrYz7vRjXAdgz0HmZsWXzl+gQQg56xYPgPm05BFUC
         ihumoS9jR3Pzn0vRr0wqy3KKRZaRsDWdAiigOuOQjmFyYpXYYRkZLQuo6sntUmZHDrMF
         6q+6hgoJE8iog4OFmzJ6wB/sqdfoI0umbXBc5B4lU0pgFZ+XMjpTyyx2yeMkFYGyQxx+
         BafA==
X-Received: by 10.182.249.18 with SMTP id yq18mr2973983obc.37.1400069527582;
 Wed, 14 May 2014 05:12:07 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Wed, 14 May 2014 05:11:37 -0700 (PDT)
In-Reply-To: <87iop8u1km.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248910>

> Basically you have to write in a manner "if a seedy stranger gave me
> that code on a street corner, I would have no problem checking it in".
> In practice, the shortcuts offering themselves through civil behavior
> and mutual trust get a lot more work done.

My point was more that it's very hard to produce high quality commits
without social interaction with others explaining what you missed,
stuffs you overlooked, etc. And there B issues quickly isolate you.


> You have to admit that it seems pretty unlikely by now that Felipe is
> trying to sneak in some NSA-written code without arousing people's
> suspicions.

Not sure where I implied otherwise... and the earlier metaphore about
country borders doesn't make much sense to me.

Anyway, I think we are speaking about different things. All I'm saying
is that humans are social creatures and that thinking you can
contribute to projects ran by humans without according a high
importance to social behaviors (like Felipe thinks) is not possible.
Threads like this are proof that while technical quality might be
important for the short term, social behaviors is impossible to ignore
in the long term.

Both are very important to be an appreciated contributor, or to
contribute at all in the long term.

Philippe
