From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sun, 11 Nov 2012 11:09:36 -0200
Message-ID: <CACnwZYfP4=Fvt8T0GOEzjTOaEyYF_Ao6e_f02eqO_5_DyzM0Zw@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
	<CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
	<CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com>
	<CAMP44s2P-nhAGgj9nuJ3cKqb6+enAthwiUNS8QTZn8MP1poJ2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 14:09:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXXIN-0001eF-BN
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 14:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab2KKNJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 08:09:38 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:39142 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2KKNJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 08:09:37 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so3963613lag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 05:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FSvobfxGvkQr+K8UntsV59KXuqUrDhnCb5bcB+PQbmU=;
        b=ORYU9CgkqU2vFwRuFFwOcZJIuiEbsfR63wgWTAto3NgoQNAvcyVFY29i5f/HSIXGSR
         t7qAL1lTbRaD6lPdqqR1b1o7zo8w47H3C7e62hAPzphHckcWnN+f9mFOKcfWEEV+cOYx
         CvnvdtlIDzUSVXqtuMIarwnb4j+tvATfHbHhFC1KX6VrMa7jd+Z1pYSDzMHDBZBg0UfE
         A+JRJcqAyjSiJ65XPH2w55JP9IvIAfMl2473JiBtaSfIQVbgbSoMLyWmYV9EWUjn6Dbg
         ehbArmjHPwtTFecO373S+8C4MhoJDNmCL96fvK3mCs5I2fQKNiY5I77blWdLO1K2eM6k
         MZbg==
Received: by 10.112.30.65 with SMTP id q1mr6195697lbh.83.1352639376286; Sun,
 11 Nov 2012 05:09:36 -0800 (PST)
Received: by 10.112.138.104 with HTTP; Sun, 11 Nov 2012 05:09:36 -0800 (PST)
In-Reply-To: <CAMP44s2P-nhAGgj9nuJ3cKqb6+enAthwiUNS8QTZn8MP1poJ2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209352>

On Sun, Nov 11, 2012 at 10:14 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Requiring everyone to use a web browser would limit the amount of ways
> people can review patches.
I don't see that as a limitation as I think everyone has access to a
web browser these days, don't have?

>> How come that can
>> be an impediment to move forward way of this awkward way of reviewing
>> patches through email?
>
> It's not awkward, it's the most sensible way.
>
The most harder way I think?

Look at this:
https://gerrit.chromium.org/gerrit/#/q/status:open+project:chromiumos/platform/power_manager,n,z

There I can go and see many informations that through this mailing
list I can't or have to do much more work in order to archive this.

If you open one of the 'patches' you can see some relevant information:
- Who is the owner/author
- Was it verified?
- Is it ready for landing?
- If I click on Side-by-side I get a nice diff view interface that
plan text email does NOT give me.
- Was it reviewed/approved (+1, +2)?
- It can be merged by one click.
- The interface also provide the command line to download/apply the
patch for me.
- Isn't there a reason (implicit there) for Google being using tools
like Gerrit/CodeReview(rietveld)/Mondrian for handling his code
reviews rather than solely by 'email'?

> You just replied to my mail the same way I would reply to a patch.
>
I replied through a web browser by the Gmail interface. ;)

>> There are a lot of issues of having to use email for reviewing patches
>> that I think Gerrit is a superior alternative.
>
> There are no issues. It works for Linux, qemu, libav, ffmpeg, git, and
> many other projects.
>
>> And many people are arguing for it!
>
> Nope, they are not.
>
If they weren't then nobody would be suggesting to use Gerrit for
handling the review of git patches.

But I think the big resistance comes from the fact that the core
developers handle/review the git patches through Gnus/Emacs, so that
is enough for them and they don't want to make the switch because of
that?
