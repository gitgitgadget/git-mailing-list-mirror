From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Ensimag students projects, version 2013
Date: Wed, 17 Apr 2013 02:11:51 +0530
Message-ID: <CALkWK0n0w9gB-1=SA4gVBA+coYrXThQrTE28uWpMD=yeB1ph4A@mail.gmail.com>
References: <vpqobdg515m.fsf@grenoble-inp.fr> <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
 <vpqzjwzkb4e.fsf@grenoble-inp.fr> <CALkWK0m=ZFK_+Za=_JabO4fiGTQ4K-Bxpr1hiZTrL_T4XuZKog@mail.gmail.com>
 <7v4nf6mjcw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:42:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USCiK-0001U9-6Y
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965347Ab3DPUmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 16:42:33 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35972 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965099Ab3DPUmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 16:42:32 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so1081695iea.38
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/71ImM2RYiM2mVo8x+SGOpPlRJx2xeMKzzHZVmposCM=;
        b=BorzJ2KFtmFkzm4InGv1cKXhucgpydq3qZ5RVBeC1EAdpx5+7FtsRk3nby2vZA4RwH
         a9VW8dGUww1znA+CVu2GlpBn2Z6DeK1a2RqheMzBbdIHzTcdITc8LApcrDzXXMVwqx2Y
         XLOGbg5BCLqxbGfhXFn/yHcIw2SPcgHtE4yHvzWFJgYerl+OZKGyoF6lSipSByh+Gdup
         4n4jrpppDl9UtWnIu/+7w9WKRlzkXUCg9CG98/3vDodvnESMyG/l5svN3MCh9F/IWBRo
         78PO7GSarmbgqAcqH0M+WtBISqpwA1D/mFi0PxCErQw7lv2gGwi1p2U5JBndibhtTNV2
         Mwgg==
X-Received: by 10.50.108.235 with SMTP id hn11mr2305733igb.107.1366144951394;
 Tue, 16 Apr 2013 13:42:31 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 13:41:51 -0700 (PDT)
In-Reply-To: <7v4nf6mjcw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221467>

Junio C Hamano wrote:
> Who said anything about a customer?
>
> A newcomer to a community (i.e. Matthieu's student) needs not just
> to show technical excellence with patches, but needs to make a good
> argument on a larger design decision; old timers already tried to
> achieve a concensus on it, and did not manage to do so the last time
> we tried.

And sorry about the huge misunderstanding.  I thought Matthieu was
saying that the proposed configuration variable would be harmful to
newcomers, and we should therefore not add it.

I feel very silly about having written such a long response to
something I misunderstood.
