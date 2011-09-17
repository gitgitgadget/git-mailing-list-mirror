From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: zealous git convert determined to set up git server
Date: Sat, 17 Sep 2011 08:10:38 +0530
Message-ID: <CAMK1S_jVXssMF_9Y1gKygRvyUZW0Wd9mdY2SG5hsPP=mAoRFxw@mail.gmail.com>
References: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
	<CAMK1S_jK2w8v4ushsZztQ0QY-eZq8axso-DpmCCvA=Gp7iXkBg@mail.gmail.com>
	<20110916204032.GA13922@inner.h.iocl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 17 04:40:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4kpi-0006YC-Uz
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 04:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab1IQCkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 22:40:40 -0400
Received: from mail-vw0-f42.google.com ([209.85.212.42]:54395 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab1IQCkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 22:40:39 -0400
Received: by vwl1 with SMTP id 1so7999650vwl.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lJSmvQlsUvhVOkLi9JNV6cjaWHThHsy46q/wwjn7uSw=;
        b=npqUpEGN11sHQ5OXHW1eS8s9vvi+5Q+CdHFWBHc9hajUarCS4cTP+QfA+Qa6/e0GJI
         u/NSN2rqAaxev3axhLTnbx2dhLftnX9/f9X3KJytbGjdGGQd8cZm2KwAD3r+6J78NAhP
         egDpzX4oVxpum+pIGgUa6ImRZNrHNY42KSYw4=
Received: by 10.52.97.72 with SMTP id dy8mr86363vdb.272.1316227238851; Fri, 16
 Sep 2011 19:40:38 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Fri, 16 Sep 2011 19:40:38 -0700 (PDT)
In-Reply-To: <20110916204032.GA13922@inner.h.iocl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181570>

On Sat, Sep 17, 2011 at 2:10 AM, Andreas Krey <a.krey@gmx.de> wrote:
> On Fri, 16 Sep 2011 22:30:35 +0000, Sitaram Chamarty wrote:
> ...
>> Well it *is* pretty darn powerful (I'm the author; allow me some
>> preening!) but I believe the real reason is that it is the most
>> *transparent* solution.
>
> It well looks so, but I have a question: It seems that it assumes a
> flat set of *.git repos. Unfortunately my current setup has the repos

No.  Perhaps I should state that explicitly somewhere though...
