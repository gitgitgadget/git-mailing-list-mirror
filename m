From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Tue, 13 Nov 2012 20:38:49 +0700
Message-ID: <CACsJy8Dh6h8gXDjYuBELOOj5HcYfEuW8pCFuhwsuovpU9u3puA@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
 <CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
 <CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com>
 <CAMP44s2P-nhAGgj9nuJ3cKqb6+enAthwiUNS8QTZn8MP1poJ2g@mail.gmail.com>
 <CACnwZYfP4=Fvt8T0GOEzjTOaEyYF_Ao6e_f02eqO_5_DyzM0Zw@mail.gmail.com>
 <20121111171451.GA26695@shrek.podlesie.net> <alpine.DEB.2.02.1211111313140.19687@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Thiago Farina <tfransosi@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Tue Nov 13 14:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYGic-0006TH-NH
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 14:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab2KMNjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 08:39:35 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61754 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020Ab2KMNjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 08:39:20 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7372103oag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 05:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XYiJzpBndGTVoimPupPOZJBU6YBMTriCZ+EkoNqZBG4=;
        b=iTAa+8N3HcWcX82nISO5Q0/PDdzkD7A/q5s8F/4IbTsYWF3otsTapY7PaT1A8J2yIy
         tzQSA9HvtdWm5z6EAirhtEB8+mBB18LnQiE1G7z8qgIRrMqhAtcOIwfMWvKNQzMKXpx0
         T3oZn/3OgRggsDkXr1E/7lPGs56nEmxyALd4RS2xLWQEnosu2spyotlqQg6S9rjq4aNd
         YOE1oSawLp4NP691N+m3+NTYFJ4gT1fhREKWn9kDGK09W+p804jHTuQyY+byXXpbhKaB
         ObJh/8urv/ihUiF0CrFUGw3ZCS3iGouQthT84Z9j5sTl3S8jhlHtDWpGxsW+uuFNvCLV
         AMTA==
Received: by 10.60.170.200 with SMTP id ao8mr17149667oec.104.1352813960284;
 Tue, 13 Nov 2012 05:39:20 -0800 (PST)
Received: by 10.182.0.196 with HTTP; Tue, 13 Nov 2012 05:38:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1211111313140.19687@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209601>

On Mon, Nov 12, 2012 at 4:15 AM, David Lang <david@lang.hm> wrote:
> Using a web browser requires connectivity at the time you are doing the
> review.
>
> Mailing list based reviews can be done at times when you don't have
> connectivity.

I am not against email-based reviews but I'd like to point out that
with Google Gears (and HTML5 Storage?) Gerrit can be made work offline
too. I don't know how much work required though.
-- 
Duy
