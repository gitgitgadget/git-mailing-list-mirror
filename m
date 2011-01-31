From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Mon, 31 Jan 2011 11:25:30 +0000
Message-ID: <AANLkTinCL6+oTAbh4WpsWHx8cZ8cxZvQxSO9EX_xsHh0@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
 <1290648419-6107-1-git-send-email-vitor.hda@gmail.com> <AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
 <AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
 <AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
 <AANLkTi=PPN69uuJmUBDHKtmn59DzUbdk=Qu4Ug-kok89@mail.gmail.com> <AANLkTi=kmcWn9WWbhA4bMZ5bEo1imacEugT0BcOU9jry@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 12:26:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjrtY-0006MJ-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 12:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab1AaL0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 06:26:02 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33117 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab1AaL0B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 06:26:01 -0500
Received: by qwa26 with SMTP id 26so5341893qwa.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=duNRGhxBjL5ChOdhVlRV8TuKi85krniiyYr76qHQaiE=;
        b=EVFnHUJsxylXdwYYb4FabiOD1WVbQTb81JZaYDLLn3NT8e4f+3RqHdt5v4QpG9pbpq
         /muXlr6R5DDdim50/e0MeC7FjnQmx3WOyoq4/qGAkmwZp15fBxPbyKdyVO79YXDKX/xk
         TNpZp80t9uCs8zsRoh/0kmACJXnDwJFQAaJmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=d/eiDAWQ9Tsz10F7Tvk8/prEyJ2MpoSk1VDOj76tVLwofHfnCE+X9kKMF13dpjQvSi
         uWkDLl/f4Ayu+Zrgjyo1BDkkl3d3cVAUoaVv262aW/nfUwuXxQedQycK+iER8mJqV0q+
         xMI+6bdvrxXHg3d6o7jrN/+6jqUFEGSdK0UIE=
Received: by 10.224.6.149 with SMTP id 21mr6233898qaz.321.1296473160611; Mon,
 31 Jan 2011 03:26:00 -0800 (PST)
Received: by 10.220.192.8 with HTTP; Mon, 31 Jan 2011 03:25:30 -0800 (PST)
In-Reply-To: <AANLkTi=kmcWn9WWbhA4bMZ5bEo1imacEugT0BcOU9jry@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165725>

Hi Thomas,

On Sun, Jan 30, 2011 at 11:34 PM, Thomas Berg <merlin66b@gmail.com> wrote:
> By the way, on this mailing list please don't top post. I think the
> preferred style is interleaved posting:
> http://en.wikipedia.org/wiki/Posting_style#Interleaved_style

Thanks for introducing me to these "rules" that are being used within
the git community :)

>> I also have some branch detection related patch prepared. Do you use
>> this feature often?
>
> No, the Perforce repo I work with is so non-standard that the only
> solution has been to import all the branches separately and graft the
> history together. This covers all my needs at the moment.

Maybe I'm not seeing some obvious limitation, but I can't imagine a
branching structure that can't be imported into git. Could please you
give me an example?

Thanks,

-- 
Vitor Antunes
