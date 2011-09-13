From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Status of git-remote-hg
Date: Tue, 13 Sep 2011 09:40:33 +0200
Message-ID: <CAGdFq_iYQF5dD5y54Yd4BtbwVva4qNj=e_HoVXT+joeH+fu4cw@mail.gmail.com>
References: <CAH5451=aYft1QoTdKA=iiLxw+OLqE8bGvd5j_UoP0Jmufc49eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 09:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3NkR-0005tD-6K
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 09:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986Ab1IMHtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 03:49:31 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:44800 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab1IMHta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 03:49:30 -0400
Received: by yie30 with SMTP id 30so219570yie.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xj0A2W/YOZUVY98iklMYd4l/hOo5sqYT1ABwebhVm5Y=;
        b=ZwMH11+bFB3+blq1kRFWWkVnrZfA5qg1ADfu7o1kgEuWauKwAETXdmtJd4/DytVxBX
         2f+ZQwKP7ZeHILLnHThSgRcvU7/FgV0p7cWc0GwLRfDZ28Tu+kq/xVoZ34JxmDQ172+n
         5heAwdHHQEbgPsXBzXhODTW+CXzppRP67BwqA=
Received: by 10.68.14.163 with SMTP id q3mr2932145pbc.98.1315899675980; Tue,
 13 Sep 2011 00:41:15 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Tue, 13 Sep 2011 00:40:33 -0700 (PDT)
In-Reply-To: <CAH5451=aYft1QoTdKA=iiLxw+OLqE8bGvd5j_UoP0Jmufc49eA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181271>

Heya,

On Tue, Sep 13, 2011 at 09:35, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> Hi there, I can't seem to find many references to git-remote-hg lying
> around. There were some commits by Sverre Rabbelier
> (http://thread.gmane.org/gmane.comp.version-control.git/154669)
> preparing for it, but I couldn't find much else.

You can try my git-remote-hg branch on github [0]. It's currently a
bit buggy (in particular, I don't think it works with the latest
version of hg without a few patches), and won't be included in git.git
until I reroll the fe-fixes series, which I haven't had time for.

[0] https://github.com/SRabbelier/git/tree/remote-hg

-- 
Cheers,

Sverre Rabbelier
