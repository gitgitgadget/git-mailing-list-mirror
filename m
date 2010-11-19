From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: Best newbie / advanced / expert reference texts for Git?
Date: Fri, 19 Nov 2010 06:18:36 -0500
Message-ID: <AANLkTik5ZYC66NicUvbDxJMiR_0iK3vPRAf9dGAQu+qW@mail.gmail.com>
References: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 12:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJOzj-0002H1-5e
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 12:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0KSLTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 06:19:01 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37343 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab0KSLTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 06:19:00 -0500
Received: by fxm13 with SMTP id 13so551234fxm.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 03:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=3EU4nu5gv/dOUnN0+6CoaN8i4+qThkL76RstVg1qJQk=;
        b=F1BupKhGxOZmK8c7EeuDjsH2yLOU64IuRjEupOUdZdF+jcBVuWd0YirzdMhyOySvYF
         FFi16OmJ5KlIcKtQhY4jSYgEZHdnYEq0Iabli7wMyo9t2U8Un7RPD8e1rJPywkAE8ps3
         Vcg5Dl3rZ5nzTsDthYpnpNiZFVTuWNIEFllXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GYfsVamaEgropD0u8XAuIoS13kNJ8fwOt3FMh3OEFtZjh/VvCuDqs7NCBET+0egGOq
         bLd0CGrIhV7fq9fYDfgGObbcjclQqH6AtEETTFuF9GB2FGps8qLmWP2qhtTGcVVXM6G9
         J8UmoZfpr108of0JDqmCuFNKRJRgaPnHaRKKE=
Received: by 10.223.72.198 with SMTP id n6mr1641281faj.125.1290165536311; Fri,
 19 Nov 2010 03:18:56 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Fri, 19 Nov 2010 03:18:36 -0800 (PST)
In-Reply-To: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161735>

On Fri, Nov 19, 2010 at 6:02 AM, Dun Peal <dunpealer@gmail.com> wrote:
> Hi there,
>
> What are the best texts for the following three levels of knowledge:
>
> 1. Newbie: someone who used a simple, centralized SCM (such as SVN)
> but never touched Git.
> 2. Intermediate: someone who uses Git's simpler features, and can do
> simple branching/merging, but would like to fully understand the
> underlying concepts such as the DAG, and master all common user-level
> operations such as branching, merging, and rebasing.
> 3. Advanced: someone who knows all the above, but would like to know
> everything there is to know about Git.
>
> The target audience in my particular case is smart, with strong CS
> background, especially those in the two latter categories.
>
> Being available online is a plus, but will not disqualify a good
> offline reference.
Check out http://progit.org/.  I am not affiliated with the author(s)
or the web site.  I just stumbled across it a couple of weeks ago when
I went to set up a git server for our group.  It seems to answer every
question I've ever had about git, and then some.

--wpd
