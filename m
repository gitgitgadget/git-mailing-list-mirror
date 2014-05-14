From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 11:36:54 +0200
Message-ID: <CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com> <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com> <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com> <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com> <CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
 <87mweku2pt.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 14 11:37:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkVcy-00086o-5F
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 11:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbaENJh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 05:37:27 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:47259 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbaENJhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 05:37:25 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so1871398oag.32
        for <git@vger.kernel.org>; Wed, 14 May 2014 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+WmI7FtsAD8alGh2DLMiw4rK+MZyxLy0ViEBDfdQNuQ=;
        b=LlvYtTXNci+p68TtI/ca9rUMX/jS8dWewwEtbtLAajddcoqO8p6pV61F44n6Nh2MaO
         Zq0NNNHJVywPvnQHTRFtzb93K+9vxfioWlGzFRhlPpkAF9jsxfuMHEqWNjVwDCkS86tx
         B6hN6TbHsLb55LAhzaGrz5QtU4QDdV3TUfB89jvp6Two2U/NVHhSJ11KzPqveApcEQah
         vyCkK3M3DTJ5BJ0MfDlcAwMKvcVaynxiiFiH5z7iJstlOS8fEQxgarUAKBSN+yf+ysrd
         fkXho4/LTmekp6hc49SXzaHn3+ACoJa5NPNqHoPqSFAw/mW6XRZFOgAooqpG29FBFdj1
         h7kw==
X-Received: by 10.60.141.9 with SMTP id rk9mr2401755oeb.12.1400060244617; Wed,
 14 May 2014 02:37:24 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Wed, 14 May 2014 02:36:54 -0700 (PDT)
In-Reply-To: <87mweku2pt.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248904>

>> Thanks for the explanation. I think it underlines well the A)
>> technical issues (quality commits) and the B) social issues (ability
>> to communicate in a friendly way & respond constructively), which we
>> discovered are both *essential* for contributing to git.
>
> I'm not entirely convinced of that: there is something akin to drop-dead
> gorgeous code: code that is so well done that it would not matter with
> regard to its maintenance whether or not its author dropped dead because
> it's both done well as well as documented in a manner where the original
> author could not offer significant additional help.

I think this only means that you can get away with B issues if A's
quality is very very very high, which doens't happen very often. And I
doubt that you will be able to get away with it for long anyway, at
some point some mechanism will be put in place so the downsides of B
aren't visible to everyone... for example with the patches being sent
to one person only and this person relays it to the list while
filtering B's issues.

Philippe
