From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Fri, 19 Feb 2016 23:09:26 +0530
Message-ID: <CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:39:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWp1g-00012f-G2
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947621AbcBSRj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 12:39:28 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34823 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030504AbcBSRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 12:39:27 -0500
Received: by mail-qk0-f172.google.com with SMTP id o6so33604607qkc.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 09:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rd2yCKgxxvvyZJngIEUJWOd1z5adVihL3LfeOMXq8b4=;
        b=bXr/P+kztSV6c8Ojpn4bEXBaLUc8YcyFIff12fUuHR0ehnM2T1d2t5rbzOT1mfCDEo
         ovF0B48m9GMe/umcIVvCXYB1K7f7hV7Wo4yGvospIfAH55ofXlWSUA7C2JEsyjncItJ9
         WlizELKGgvBMvUa890l3MIECofZ+tcpi0dDJ0MAyEF/1iLxKtpltNCJq6GT2xRxQKG29
         d0Lel/mngZcfKypwqIjJ+Yd2f+ypbGg+lHWB//4BxBAsuF0toMipvRVPiIQkavrMHMIC
         xupQQcYzqMcCx8+4F9gTRBXENZLB3h8+QsnQMqT8tU0NX3k8IDETEhv0ScTM2KG5S8lw
         wNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rd2yCKgxxvvyZJngIEUJWOd1z5adVihL3LfeOMXq8b4=;
        b=ifmx+VZRfHgRrMRJxvkwIqc2O3Q3qwldP6Q3wFYw5Zm5GRuBjR+SErvL0+goX15RvJ
         08Nbo8jk5KkC8maktvu0kz1spzC8M0vyZhwlVm1209bYSVyEuFHvJpBom/pxKjFTiJXv
         aquynBk0Fwu8sJR5KLi+DUW3WR9UALdQ6v1j15DODQmbRMbtMg9ftYR+oQeoHy2R/BLt
         nzo8s+OPqmfyrOYHbROM6gN7CAnF9YEH/pKlMQenbE9mCADW4Q1hf3hxNujrIHJ7AKyT
         SDgSjZnyXt+69oir6OTfbXGLHJv6NP+y24FTxT9T1p1NkMueB+X1L8lZZTVMs9ZtykTI
         cQBw==
X-Gm-Message-State: AG10YOT5guAvurbC4yCqmrlBkJ+YJRHZ7Qln/QnAkR2rIFAGekRejf8k+UtcLhYfxvep7MLUrp8XKLs4fpMq0Q==
X-Received: by 10.55.209.148 with SMTP id o20mr128626qkl.5.1455903566520; Fri,
 19 Feb 2016 09:39:26 -0800 (PST)
Received: by 10.55.166.10 with HTTP; Fri, 19 Feb 2016 09:39:26 -0800 (PST)
In-Reply-To: <vpq37so26oz.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286724>

On Fri, Feb 19, 2016 at 6:33 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> This is a double-post. You've posted almost the same message under the
> title "GSoC 2016". Nothing serious, but attention to details is
> important if you want to give a good image of yourself.

I'm sorry of this kind of behavior. It was due to a misunderstanding by my side.

> I don't have all the code in mind, but I think it is. In this situation,
> you always end up with a variable telling Git what to do (I guess,
> autostash here), and this variable is set according to the configuration
> and the command-line.
>
> You should be careful about the precedence: command-line should override
> the configuration. And the default behavior should be used if neither
> the command-line nor the configuration specified otherwise.

Thanks for the suggestion.
I've started the work on patch and did the change in the code which
were necessary for Microproject. I have run the test by using "make",
and there was no failure of any test.
I've a doubt regarding tests. Here as "git pull" will now understand
the argument that  "--[no-]autostash" means "rebase.autostash" should
be set false for current execution of command "git pull --rebase". So
do I have to write a test for this new option?

Mehul Jain
