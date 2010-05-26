From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 4
Date: Wed, 26 May 2010 18:33:42 +0800
Message-ID: <AANLkTims7CyMUwBb6kBUuheuZerKrlyx-e1zpeaTCvkx@mail.gmail.com>
References: <AANLkTimFqlbYz6BL02N7UiAsGDpspFJTrLwQYWOMi-vS@mail.gmail.com>
	<AANLkTimu5d2ofkjERW8zcgIGqsnbnGazsDaltL1r6n6H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 12:33:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHDvp-0005tU-0M
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 12:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933501Ab0EZKdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 06:33:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50303 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab0EZKdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 06:33:43 -0400
Received: by gyg13 with SMTP id 13so2711450gyg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=WdrreMN4DlkeEoxQdn/DbO6XDhdNgfpXXx0nhkziD+c=;
        b=sm2GGUCiWZOcJ/ETfP2LLPq+FBlV5dvOJxmrwqq9T8keSpoZIVuIYsrakP8CX4k+F4
         mFajNyLuTYK8hgIQQL15T8K+XKcOGizWldOlwfGt0VbbI+K69W9rIpv8kBRMtDJGlXsE
         vM+bSFtk6XmYmkAS2jxQZlPSRp2C4K8+XEhhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mrWAtZld5XtXxN7K31PqNHHOmGEWktKToLVyytRYsrJny9/C1UGFRaFWUG4fd3i4vX
         9iVICpxkEMdnNlY1kvVVmfLcWiaryUpES4kbnk/pwrgWfgW7+i8cJmukGAepy1JvqN4P
         w/PWIfpq+deoehYI1zsvEDWT2/1TGGOvVQ0Yg=
Received: by 10.91.51.29 with SMTP id d29mr4260575agk.16.1274870022125; Wed, 
	26 May 2010 03:33:42 -0700 (PDT)
Received: by 10.90.90.2 with HTTP; Wed, 26 May 2010 03:33:42 -0700 (PDT)
In-Reply-To: <AANLkTimu5d2ofkjERW8zcgIGqsnbnGazsDaltL1r6n6H@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147790>

On Wed, May 26, 2010 at 10:50 AM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> Would it be able to automatically convert an svn repo that started
> life without the trunk/branches/tags hierarchy, but was added
> after-the-fact?

Sorry for my ignorance, after googling around I think I've found what
I wanted (svn2git).

nazri.
