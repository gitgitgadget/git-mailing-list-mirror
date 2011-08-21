From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 21 Aug 2011 13:25:38 -0700
Message-ID: <CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
	<7vvctvdf5r.fsf@alter.siamese.dyndns.org>
	<CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
	<CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 22:25:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvEaW-0004Kt-KY
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 22:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab1HUUZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 16:25:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49766 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab1HUUZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 16:25:39 -0400
Received: by gwaa12 with SMTP id a12so2613049gwa.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m3Ryq+xWP8pIi3PSlvCbVKy+7dRwgttlTcEzjOB7lxM=;
        b=pLmlUOs69e1F9TYzRkVnwk4FIqjzBbhg4H7dbu3kpveNnszqjr2r0L5FvVp3fHcM9l
         1ID8DYrAw+yqqJiNoM3nm1MFZqMV6X50hIg92X4Qm8bAlbG3WErSW5bFY7/nuoQQQspA
         9y/AlhlhZOCsA3fTxqmq+3brdcVpX4piatMQo=
Received: by 10.236.136.135 with SMTP id w7mr9830381yhi.51.1313958338438; Sun,
 21 Aug 2011 13:25:38 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Sun, 21 Aug 2011 13:25:38 -0700 (PDT)
In-Reply-To: <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179810>

On 17 August 2011 22:52, Michael Witten <mfwitten@gmail.com> wrote:
> On Wed, Aug 17, 2011 at 21:23, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>> It would be really nice, though, if Git could somehow
>> "stash" such files when checking out a different branch. In general, I
>> would prefer if uncommitted changes and untracked and/or ignored files
>> stuck to the branch where they were created.
>
> As an aside, the problem here is likely a manifestation of the fact
> that nobody understands what a branch is; the word 'branch' is
> TERRIBLE, as everyone has a different idea for what that should mean.
> In my opinion, `git branch' should become `git ref' or the like.

Are you saying that Git's branches are different from branches in
other SCMs? How does my understanding of "branch" hinder me in the
above scenario? Am I doing something wrong?

Isn't a branch simply a way to track changes separately?
