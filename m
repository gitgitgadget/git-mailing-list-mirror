From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sun, 11 Nov 2012 19:02:30 +0700
Message-ID: <CACsJy8CDCgea+GVU6qVojEBqsZafZAk90hBMrMzo02T5fmd-tg@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
 <CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
 <CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com> <CAMXnza0xcH0M53BEaEyvEnShz5fGLjOtgxmTC9YMGtBsR8ratw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thiago Farina <tfransosi@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: suvayu ali <fatkasuvayu+linux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXWFw-0000Ta-N6
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab2KKMDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 07:03:03 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36617 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2KKMDB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 07:03:01 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5427036oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 04:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8ySNiOpalIYieFy3PdsILUakIAMKJv6oCl2Mb02js1Q=;
        b=DldQmhyAggkueZIoctcEwX5ubpWt5LXXZuDn9kMeFP4J5IqkQ1QfqKAOcKJPMrCn9l
         RiVfAus0VjHEXzxWAPUq0Um/CLmt1oVO/K7lKeTk90m2gplSy4813/R7NGhMzS5opUed
         Xoudn0tige6dJZSu831+ChteONlbkkXwTJ7A2NlJkNV9fx1+CF8fzRZ0f5JH1aDBlJIt
         boBdguD2qp//sR4B5WcUiFjlHSEcy6D5E85hnrKrlHFRAnhUJuapb9ZQZcAhR+yFaC8v
         BwGh7En6hyuv7u60uWn1HB1XdZxgRJFVdhzfhcrEK9gHwEypZAGV7/p3ayk2imOgShv/
         0Dcg==
Received: by 10.60.24.7 with SMTP id q7mr11898106oef.108.1352635380494; Sun,
 11 Nov 2012 04:03:00 -0800 (PST)
Received: by 10.182.0.196 with HTTP; Sun, 11 Nov 2012 04:02:30 -0800 (PST)
In-Reply-To: <CAMXnza0xcH0M53BEaEyvEnShz5fGLjOtgxmTC9YMGtBsR8ratw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209343>

On Sun, Nov 11, 2012 at 6:11 PM, suvayu ali <fatkasuvayu+linux@gmail.com> wrote:
> I'm just a user, I found this discussion intriguing and was wondering if
> any of you have heard of patchwork server[1].  It is a patch aggregator
> for mailing lists and provides a convenient bug tracker like web
> interface without getting in the way of the workflow of reviewing
> patches on the mailing list.  If you are interested the Org mode
> community (an Emacs library) uses it.  You can take a look here:
>
>   <http://patchwork.newartisans.com/project/org-mode/list/>
>
> I just thought this might be a nice middle ground for people.

It's been brought up several times [1] before. And Shawn wanted to do
something about this too [2]. I don't monitor gerrit so I don't know
if it has become true.

[1] http://search.gmane.org/search.php?group=gmane.comp.version-control.git&query=patchwork
[2] http://thread.gmane.org/gmane.comp.version-control.git/102887/focus=102901
-- 
Duy
