From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Wed, 14 May 2014 14:51:09 +0200
Message-ID: <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
 <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
 <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com> <536d4e7ba8ea_585ea5308a9@nysa.notmuch>
 <CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
 <xmqqsiodo7o6.fsf@gitster.dls.corp.google.com> <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com> <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 14:51:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkYev-0004DY-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 14:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbaENMvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 08:51:41 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:57481 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbaENMvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 08:51:40 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so2069411oah.21
        for <git@vger.kernel.org>; Wed, 14 May 2014 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=enGY3Rn0vBUymOI0o98g8rfX0P/QhBAWb05On/IOyhY=;
        b=jnBuCyxBA1oGfbah7tegp7etRSizsIQKqRrIhKgPmCB6qrGH/7qQbXN0XY/MA1RNjv
         xXA8NIcOzREdy0v+ZbnB3YZ73++ia4FYz/0cAoTCnaGkpmyjbPxMgsOuB7xGTfJZ/Nhm
         PtN5eGUJDvvQ7gSUgqurW0Fx7JkexO1BZCEWNjcUDRcPun9PCfDrknUgMQSRPjZXR4R9
         tIL913qSY5zm6WfntZb1v/5PKAyParh+I8jGmMNIh0+dEt0xL6kOnB+YAIKQpsdB7vx5
         dstfiwe8iC6mtaxERtbr5FsrmYaWQd6Pg/9vFYTigE0+Yc0sVEYfCRUqUnMXOaJswy4r
         RW4g==
X-Received: by 10.60.65.99 with SMTP id w3mr3313387oes.7.1400071899791; Wed,
 14 May 2014 05:51:39 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Wed, 14 May 2014 05:51:09 -0700 (PDT)
In-Reply-To: <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248912>

>> I have had patches and contributions rejected in the past, sometimes
>> rudely. Same has happened to many others, if you contribute long
>> enough, it is pretty much guaranteed that it will happen to you.
>> Maintainer is wrong, or you are wrong, or someone is just having a bad
>> day.
>
> This is not about a couple of patches I worked in a weekend being
> rejected. This is about the work I've been doing since the past two
> years almost like a full-time job dropped to the floor with no
> explanation at all. I started with the expectation that they were going
> to move to the core, because Junio said so, then he changed his mind and
> didn't want to explain his reasoning.
>
> It's not just a bad day.

Here are two posts where Junio and Michael Haggerty explain the
reasoning to you:

- http://article.gmane.org/gmane.comp.version-control.git/248727
- http://article.gmane.org/gmane.comp.version-control.git/248693

Basically, in your case it boils down to your social manners. Despite
the (good) work you did, many people think the community and git as a
whole as more to loose by having to deal with your theatrics,
especially since you try to take everyone hostage of your situations.
No amount of "arguing" (calling it "ad hominem" etc) will change
anything at this point, you have to accept that your social actions
have a big part of responsibility in this.

IMHO, you should change your behavior into a more respectful one and
give people some time to discover you changed, otherwise it is
innevitable that you'll just get banned/ignored by mostly everyone.

We spent way too much energy dealing with these silly issues, please
find a way to deal with it that doesn't annoy everyone and doens't
affect the friendlyness of the mailing list.

Philippe
