From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: Apply commits from one branch to another branch (tree structure
 is different)
Date: Tue, 18 Mar 2014 12:11:54 -0500
Message-ID: <CANUGeEbBi5OQAcwEK7mLxc+OvxTiRxgUwcqW9awVZcvCWo4eHA@mail.gmail.com>
References: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
 <CAD6G_RSPNob11jzqyXiBR4zRuu3T00+qQ7rhNx_E4q+2-3h6iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 18:12:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPxYv-0001XQ-JY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 18:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbaCRRMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 13:12:16 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:53580 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708AbaCRRMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 13:12:15 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so6033399wes.22
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Q8V2c/VjUlJkcpMmiVU27ZULeA7ZYLlKNmO60bRzfmI=;
        b=Vr8q4q3avGjZCaIH63IqDTU0mzDgfVpunikheavDHkQ7F84V2LTnAz6ttbpFe4dOVU
         H3/Llsb+vieOLoSvtPkfzIXgPmlSimalxo+/ue1+R5o/sOYdgQ115AJMrp9uoDamVMw6
         HsZE3TL7Mn90bAAolnpfBIDlBLQ69M83VQQmuePF4mk4R2tE74tUifkttMB/tNxZDy/0
         XwZB4rI2gAbiZI//oLI8+60AJGnSGBciEhIF3TX+K4UKEPgyrHxNHxIXMzNwDhP49WED
         fwL9rJNYTbXCg4valgIheyIkcpV9r8NtpPMgnSZxWO5ISCSNlH+z9ywLP40ewbQTSCBH
         fLlg==
X-Received: by 10.194.90.107 with SMTP id bv11mr24529656wjb.11.1395162734335;
 Tue, 18 Mar 2014 10:12:14 -0700 (PDT)
Received: by 10.217.120.8 with HTTP; Tue, 18 Mar 2014 10:11:54 -0700 (PDT)
In-Reply-To: <CAD6G_RSPNob11jzqyXiBR4zRuu3T00+qQ7rhNx_E4q+2-3h6iw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244361>

Jagan:

On Fri, Mar 14, 2014 at 1:11 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Don't know what happen, I'm unable to join #git channel
> [23:40] <Jagan> hi
> [23:40] == Cannot send to channel: #git

I'm not sure if this is the problem that you were having, but #git on
freenode is NickServ protected. You need to register with NickServ (a
bot on the network) and identify yourself with it in order to be
allowed to speak in #git. This cuts down on spam. You can `/msg
NickServ help' to learn how to use it (and also Google will be your
friend).

Alternatively, check the channel topic for an alternative solution.

Regards,


-- 
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bamccaig.com/>
perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
