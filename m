From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sat, 10 Nov 2012 23:13:35 -0200
Message-ID: <CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
	<CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 02:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXMBe-00031L-Qb
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 02:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab2KKBNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 20:13:37 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:39279 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab2KKBNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 20:13:36 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so3806074lag.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 17:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TiZCjvF5uzWL3ZkrUFRRJ4qI1/vVI8itJSVYzZMDsEU=;
        b=KJJGQu3+wrm9AqXmQFEPe3w4GXXS+7QrWM44CWsFMZ4+kHPNCGyUPDtyxdO7Ax+puE
         CGKoyHkCTD9jIUNDeCS+luqBFeLxwJ0eCuNuYS/RK57EO1EmCT6gviwTtu+nMoIbFEq6
         2dVgkG32gSSEfumbXda67J+lhQZCWBNNnKGUi5HjUD9tWSz5VjI7niXR8NSrbqI6xtBZ
         A1epYWssHkJ9UcXGtC6K/VeqNMjsKRxTIrPPH5O8GKkPDzTtjs4eCqGm9cZIBERymLra
         +2ZmrFZH+W8v6H3rik53+vPSsabt2Xw3hPbDGnwJqpFvNS8A2FQshcqMvlaReicJypf4
         vSFQ==
Received: by 10.112.38.163 with SMTP id h3mr6171488lbk.134.1352596415340; Sat,
 10 Nov 2012 17:13:35 -0800 (PST)
Received: by 10.112.138.104 with HTTP; Sat, 10 Nov 2012 17:13:35 -0800 (PST)
In-Reply-To: <CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209319>

On Sat, Nov 10, 2012 at 9:40 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Nov 11, 2012 at 12:19 AM, Deniz T=C3=BCrkoglu <deniz@spotify.=
com> wrote:
>
>> This is my first mail to the git mailing list. I have been following
>> the list for some time now and I would like to suggest moving the
>> reviews out of the mailing list, for example to a gerrit instance, I
>> believe it would improve the commits and the mailing list. I have a
>> filter on 'PATCH', but I feel I miss some of the discussion, and
>> things that I would be interested in.
>>
>> I have spoken to Shawn Pearce (gerrit project lead, google) and he
>> said he is OK with hosting the gerrit instance.
>>
>> I would like to hear your thoughts on this.
>
> Personally I think reviews on the mailing list is far superior than
> any other review methods. I've even blogged about it and all the
> reasons[1]. Gerrit is better than bugzilla, but it still requires a
> web browser, and logging in.
>
Requiring a web browser is a huge requirement, ham?? How come that can
be an impediment to move forward way of this awkward way of reviewing
patches through email? Switching to Gerrit would mean everyone would
be using the same tool instead of anyone using its own email client
(gmail, mutt, thunderbird, whatever...) and having to figure out git
format-patch, git send-email (--reply-to where?).

There are a lot of issues of having to use email for reviewing patches
that I think Gerrit is a superior alternative.

And many people are arguing for it!

Let's move on...
