From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Compiling on Windows
Date: Tue, 18 Oct 2011 16:02:27 +0200
Message-ID: <CABPQNSZhWOa5wken4vh6Hcza8EM4VnekE3VUFJNmaEJvWME=ew@mail.gmail.com>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
 <op.v3i8rauz0aolir@keputer.lokaal> <CAH5451=VPzkFZyyUUdj+=dXDCHKQbWTTob_=JJFBCwaDsp1n7Q@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 16:03:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGAGB-00064G-87
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 16:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab1JRODJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 10:03:09 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:65342 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab1JRODI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 10:03:08 -0400
Received: by pzk36 with SMTP id 36so1604406pzk.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=a/6OaiWjudvWZPuVnMJF8Uv46SrRZzaDF0w9xWjHCl4=;
        b=E78YgNEhWaM2RgZauNwP7+XsqJnSXSmQI5a55bPUmteQJAtNI2sOm4evcErEzg+j5q
         lGwhpCiJYj6Z09MBrJ9TGiEmeAbwWnm0H1DZbByyGj6FpyjYhsmmgrNfGyBTyMCotQQG
         BEu99cL/EHF2nBhYsapBxPiLgXg2jVdiJ8Wls=
Received: by 10.68.34.137 with SMTP id z9mr5060017pbi.76.1318946588047; Tue,
 18 Oct 2011 07:03:08 -0700 (PDT)
Received: by 10.68.63.166 with HTTP; Tue, 18 Oct 2011 07:02:27 -0700 (PDT)
In-Reply-To: <CAH5451=VPzkFZyyUUdj+=dXDCHKQbWTTob_=JJFBCwaDsp1n7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183882>

On Tue, Oct 18, 2011 at 8:17 AM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> Thanks for the replies all - I think my main issue was that the wiki
> is down and msysgit has very little use-able documentation otherwise.
> I had cloned the msysgit project, but was lost on what to do from
> there. Foolishly, I had glossed over the msysgit installers on the
> project home (I think I thought they were Git for Windows installers).
>

Yeah, the installer sets up a fully self-contained MSYS-based
development environment to hack on Git for Windows.

> I have now installed everything, and am ready to hack. Perhaps the
> first port of call is adding a README to msysgit :D

Not at all a bad idea!

It'd be awesome if it even worked with the GitHub markup-stuff as
well, since we moved the project there :)
