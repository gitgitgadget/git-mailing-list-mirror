From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: SSH version on Git 1.8.1.2 for Windows is outdated.
Date: Sat, 16 Mar 2013 21:54:21 +0100
Message-ID: <CAHGBnuMZj4LPywPxfOqcDSCAMg0hwNA_9NnZUQm6Znwz1-oU4A@mail.gmail.com>
References: <CAJ5Q6vXTyaegQq2uMoK7QQVYiYS9GcJhCefkQs9tXxqU=M10Vg@mail.gmail.com>
	<20130315210325.7b0a3505ffa4d46e7e716324@domain007.com>
	<51438058.7080204@workspacewhiz.com>
	<51447052.1020407@gmail.com>
	<5144DAD7.50203@mail.pgornicz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Kristof Mattei <kristof@kristofmattei.be>, git@vger.kernel.org
To: Patrik Gornicz <patrik-git@mail.pgornicz.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 21:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGy85-000761-RB
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 21:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab3CPUy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 16:54:26 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:38437 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3CPUyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 16:54:25 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so4892992lab.35
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=2SQRZHep6xfyvniJYYDTvLsviVqjiRWNWBIEGvDXM40=;
        b=VryvMuiWWpnqeRT2GSnSt/xGeJPDG5mNW145Eb0RHaUEkQjSZnahWEbjNxFtCvGOkL
         MHRQla+XBn9B7J1gYabm5+ovKYRMrZ8hIUTo1prwD77sxABc6/QYw3qGsdm8alzvPaXm
         XvMPXedV1mldz6kslweyvx3xxkyF0/yQRtRGItQbUdTvrPpFKIgOVxDaGB1we4R3Ru7I
         vrkxLbAQv2A3LM8ZY0EG0air1af868vYb+B9OY7t0RM21y1YisWqU+pz8TdT6vb23Gz8
         P7miSvjHdxA6nHzZ2BT5o1jRpk3ofw1E4hhKjPGoQ0nN2wX9BqVzo1DfaSveLr47jMFN
         LkLg==
X-Received: by 10.112.103.196 with SMTP id fy4mr4291184lbb.125.1363467261366;
 Sat, 16 Mar 2013 13:54:21 -0700 (PDT)
Received: by 10.114.84.33 with HTTP; Sat, 16 Mar 2013 13:54:21 -0700 (PDT)
In-Reply-To: <5144DAD7.50203@mail.pgornicz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218317>

On Sat, Mar 16, 2013 at 9:49 PM, Patrik Gornicz
<patrik-git@mail.pgornicz.com> wrote:

> Any idea as to when this mingwGitDevEnv project will be mature enough to use
> as a replacement for msysgit? One of the reasons I gave up trying to tweak

Due to a lack of contributors this is taking longer than I
anticipated. But I realize I need to make contributing easier, and
also find the time to merge some outstanding pull requests. I hope to
be able to make some significant improvements at the end of March.

-- 
Sebastian Schuberth
