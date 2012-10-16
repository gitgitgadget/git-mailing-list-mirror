From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 12/12] Add git-check-ignore sub-command
Date: Tue, 16 Oct 2012 22:07:23 +0700
Message-ID: <CACsJy8BewSctFSoth=pzYd+5fNZOUZ2AwUcrLd9VKA2OduJV+A@mail.gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com> <1350282486-4646-12-git-send-email-pclouds@gmail.com>
 <7vlif7v03r.fsf@alter.siamese.dyndns.org> <CACsJy8Du1G-=pBbHW841V-61L9_HGmNkOE7EB2W2f1RJe9WuXg@mail.gmail.com>
 <CAOkDyE_HCxNYpWVc0WCwhcAivEm+RLiFj-TwSsEbi+U5mZ3cww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:08:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO8kY-0001K0-OU
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 17:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab2JPPH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 11:07:56 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44846 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab2JPPHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 11:07:55 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so6287284oag.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LLXxKI5G/oBEy/czh659JAFneKjLfJQEtnQDg7Umtrc=;
        b=Go7u8iNENl2q32+ZE+ngHh204lYyzU6xqVrcy2bOPgswEwAPO6RuerD5VzMl+NYwwq
         AwAm6+enBR1j1LKp9NQ0WtULjd4Ujj0uhM9gRscYAK9cE6TU7XKRD43dpltmCLRXFUjk
         weGXvqk5jWgAX4rR/prJbOT+SJErcFim20eLXyR4WrLyEPPeTM3ituL5F1WOPQlTTx/f
         8i7P4vRtdzxnqjZyeklYkAUkfx8SZ30W5OgrzpwO+syvWkCoKSTXDrsKCux6K6f7Ks4X
         fR9g7W2i8parmQlW3ejHyiA2sn6iHPN8D/x6NAmGH9PUH0uz8c9+EcHi1ov+w251tSjv
         +Mbw==
Received: by 10.60.26.230 with SMTP id o6mr12366582oeg.109.1350400075231; Tue,
 16 Oct 2012 08:07:55 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Tue, 16 Oct 2012 08:07:23 -0700 (PDT)
In-Reply-To: <CAOkDyE_HCxNYpWVc0WCwhcAivEm+RLiFj-TwSsEbi+U5mZ3cww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207835>

On Tue, Oct 16, 2012 at 9:09 PM, Adam Spiers <git@adamspiers.org> wrote:
> I was *intending* to finish it off soon, but I have been really busy
> with work and other commitments recently, which has prevented this.  I
> don't currently have any unpublished changes which would conflict with
> your recent work, and I'm at a conference this week, so feel free to
> carry on polishing if you want.  However I will probably have some
> responses on the discussion about current issues, so it would be good
> if I was given a chance to catch up on this discussion before the
> series makes its way to master.

No hurry. And thanks for your contribution.
-- 
Duy
