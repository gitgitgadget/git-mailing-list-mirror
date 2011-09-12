From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 01:15:56 +0200
Message-ID: <CAGdFq_jSjDsEZnUWUBUDxvLk1jZUb_c2Rh8ybK13x4TZHyOQRA@mail.gmail.com>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7vd3f52wd5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fk1-00015z-Cr
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab1ILXQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:16:37 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:65450 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611Ab1ILXQg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:16:36 -0400
Received: by pzk37 with SMTP id 37so7478446pzk.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dIP0Z+Spb+9s/auv/4KoIVXn1DsFJpPjiLXXoFjzHh8=;
        b=FJDQ7qNpx5WJMeckDqGbncdfeYyRorNV1cbQkFyD8tlBp+pHVbTQMJ0zDvMdPwQWT7
         71juD3yjzKdKQLp7GyRsnRbpDLbCEdq6k/VjXf2wfFWPJstsqcZlNgHUeT7M2UKQH2C5
         4DE+8TLZiSBXO3PBhf0rrUGJXrYmKaE940nlI=
Received: by 10.68.26.133 with SMTP id l5mr516840pbg.299.1315869396072; Mon,
 12 Sep 2011 16:16:36 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Mon, 12 Sep 2011 16:15:56 -0700 (PDT)
In-Reply-To: <7vd3f52wd5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181254>

Heya,

On Tue, Sep 13, 2011 at 00:02, Junio C Hamano <gitster@pobox.com> wrote:
> I vaguely recall that one of my unrelated topics fixed the issue you were
> trying to work around with this topic, or something? Can we see a re-roll
> after 1.7.7 ships?

Correct, one of your topics added a framework that would fix part of
what I was trying to fix, IIRC. I'm not sure if I'm quite up to the
task of doing that reroll, but I'll give it a shot at least :).

-- 
Cheers,

Sverre Rabbelier
