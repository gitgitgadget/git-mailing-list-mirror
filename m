From: David Aguilar <davvid@gmail.com>
Subject: Re: Add a bugzilla website
Date: Wed, 8 Jan 2014 01:24:38 -0800
Message-ID: <CAJDDKr4kKOz68SESDqhrPB+hUO15i76uUJA=6HF=8AUxLD==DQ@mail.gmail.com>
References: <20131115135132.431d3e344dadee64e2be5127@domain007.com>
	<361384464.315129845.1384511657291.JavaMail.root@zimbra35-e6.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: ycollette.nospam@free.fr
X-From: git-owner@vger.kernel.org Wed Jan 08 10:24:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0pNV-00009o-RB
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 10:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbaAHJYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 04:24:41 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:56291 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbaAHJYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 04:24:39 -0500
Received: by mail-qc0-f178.google.com with SMTP id i17so1204204qcy.23
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 01:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ADaBJB2yUrVR/tyxmyoxm4aIABqSGuWsrHIjVZJUNco=;
        b=uGAz4F4wg1TGOKifUcIGlprcVN13TSzz1yrn6Pm7XxZBRbazS1o3viOOpdv5HTZ4EY
         hKCN9BnqMHUuQI2zE+5P64WFbqpe6a2keKnquRKCp22qewV6XkmByQQ0JEpzyDtEi+qE
         PeNUdhw7q0H2bWRkvF6/V6iFSaGvSNIWeNLn2NWyPnKI5kbEsYfE8Zm1CUAdkB6a3Ucv
         O2e30phbi2AhkhxpKeVUfDK0wu0tnryp8289F1W4g47oaOe8Z8HUU4RK8zFKDrS8Iv1M
         OXLBCetw2iyy2rVj4Lk0Jq60MzHDs5sIAbIrRj/SMSr4if4xOtC7VbVM/B0MNxeiNH7X
         QJYQ==
X-Received: by 10.49.76.66 with SMTP id i2mr210310175qew.35.1389173078465;
 Wed, 08 Jan 2014 01:24:38 -0800 (PST)
Received: by 10.229.67.65 with HTTP; Wed, 8 Jan 2014 01:24:38 -0800 (PST)
In-Reply-To: <361384464.315129845.1384511657291.JavaMail.root@zimbra35-e6.priv.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240197>

On Fri, Nov 15, 2013 at 2:34 AM,  <ycollette.nospam@free.fr> wrote:
> OK, thanks for these informations.
> From a user perspective, having this volume of devel mails flooding all the bugs mail is very annoying.
> And following the status of a bug and the history of this bug is very hard too.
> The bugzilla approach is really useful for the user who is reporting bugs: all the bugs are tracked, you can see if a bug has been already filled and put some additional informations if necessary.
>
> I will have a look at the JIRA thing.

FWIW Debian and Fedora (and possibly others) have "git" components in
their bugtrackers.

http://bugs.debian.org/cgi-bin/pkgreport.cgi?dist=unstable;package=git

https://bugzilla.redhat.com/buglist.cgi?component=git&product=Fedora

It might be worth working along with one of the distros to avoid
duplicating effort.

cheers,
-- 
David
