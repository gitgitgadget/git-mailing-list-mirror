From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Git for Windows 1.9.0 (fwd)
Date: Tue, 18 Feb 2014 10:04:54 +0100
Message-ID: <CABPQNSb8LQZPMiepRNi=yw_quDrdUDV4K_ReB99bCiQ8mS6s9w@mail.gmail.com>
References: <alpine.DEB.1.00.1402180049570.14982@s15462909.onlinehome-server.info>
 <20140218023319.GA10300@glandium.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 10:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFgcn-00089c-BW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 10:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbaBRJFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 04:05:46 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:46504 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaBRJFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 04:05:35 -0500
Received: by mail-ob0-f178.google.com with SMTP id wn1so18431564obc.9
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tJ8ArcgCDw1rb+0E2ZsuSSbW431U3UuvqhVoWcYd/LM=;
        b=DwA9+tyauvYce35zNGBQAK1z9k6DKyP3uoxTx30KyNZ9nwpNUX5yqEMSubS3hZKgsT
         +RtOMkXWMHaz+hrFlPghpMCtj+itniQzO+0pDu6LcncQ95JL+pk7hoXM6a9GOgzqBtwA
         LbCpZWFUQlrZQfk8mC6luiZoqHf5kXWK6bpk+cx/cpLPnzBBAgYFraztMOgAXP/Vd1yg
         tuOfdToKZZItJ1hlitCyb+FYd4TPkkT40D8Gx16SLXGtrro2GKD5KIQ9BqOMqV/5VRTl
         qkIw0aC93GC84oIrOGJqJN9o4FWX3yqjat+JReYabm4G2+XOv4YsHEOkewx2+diSNz3v
         11tQ==
X-Received: by 10.182.33.35 with SMTP id o3mr25119372obi.15.1392714334284;
 Tue, 18 Feb 2014 01:05:34 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Tue, 18 Feb 2014 01:04:54 -0800 (PST)
In-Reply-To: <20140218023319.GA10300@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242285>

On Tue, Feb 18, 2014 at 3:33 AM, Mike Hommey <mh@glandium.org> wrote:
> On Tue, Feb 18, 2014 at 12:52:28AM +0100, Johannes Schindelin wrote:
>> Hopefully the Postfix Greylisting Policy Server will not try again to
>> greylist me, as it might however do without violating the RFC.
>>
>> ---------- Forwarded message ----------
>> Date: Tue, 18 Feb 2014 00:38:54 +0100 (CET)
>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> To: msysgit@googlegroups.com
>> Cc: git@vger.kernel.org
>> Subject: [msysGit] Git for Windows 1.9.0
>>
>> Dear Git fanbois,
>>
>> this announcement informs you that the small team of volunteers who keep
>> the Git ship afloat for the most prevalent desktop operating system
>> managed to release yet another version of Git for Windows:
>>
>> Git Release Notes (Git-1.9.0-preview20140217)
>> Last update: 17 February 2013
>>
>> Changes since Git-1.8.5.2-preview20131230
>>
>> New Features
>> - Comes with Git 1.9.0 plus Windows-specific patches.
>> - Better work-arounds for Windows-specific path length limitations (pull
>>   request #122)
>> - Uses optimized TortoiseGitPLink when detected (msysGit pull request
>>   #154)
>> - Allow Windows users to use Linux Git on their files, using Vagrant
>>   http://www.vagrantup.com/ (msysGit pull request #159)
>
> I was curious about this, so i went to github and... couldn't find any
> pull request above #126.
>

It's right here: https://github.com/msysgit/msysgit/pull/159

You probably looked in our git repo rather than our msysGit repo.
