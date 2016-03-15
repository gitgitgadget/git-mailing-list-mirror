From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: Gsoc 16
Date: Wed, 16 Mar 2016 02:53:14 +0530
Message-ID: <CAFZEwPMKi5QVxNXV_nchK29OMmXpRbwvfuvfKQk52YjsKk-Q_w@mail.gmail.com>
References: <loom.20160315T215800-306@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Saurabh Jain <saurabhsuniljain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:23:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwQy-0001PS-6I
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbcCOVXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:23:17 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:32867 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcCOVXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:23:15 -0400
Received: by mail-yw0-f179.google.com with SMTP id m126so14153475ywd.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=oLKGraFzOo+pglBHGTiItglMxn4O+GkaywlySoHa35E=;
        b=i3eHdjfljPtqiub4SNdFais9F9+d9QdYcZsCDIElW2ncNZ/GWcOOcWZlDpzHwOwU86
         elx4GCmhauFemKHfqPgDbf2fPfQqyx2Nr2XfxaOZPRWdLYxIzYUUJq8ABWcjNp6HgRq/
         6DXVCt0379kpUd6ld5ptJz8FDV3ooiJlw7IcvN9e/fFu788doGnym82Goib5ciF+rMvd
         aMmApgtCeIMqQ4ibRbVXOefiHQU99RLqlsGtWjR3DsGc4U1+401Q87bNJDultNcMnl6j
         X956zxrtvKGx7vxJh49k94t/S3aFGM7RJuEdTsBGJWDw+pwKIOMoaLE/CQN/kL3jBNOd
         oW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oLKGraFzOo+pglBHGTiItglMxn4O+GkaywlySoHa35E=;
        b=nC/ztBQqpK5FT9GDQdtwAP357Ix8jFKQORnub7+7L0E58SwD9Upc8Ab72vgnnrf87r
         b54BnaWxaW7lG+lpY/yB4bBBw+xTVxmaQjKvX0Cjxok0ju2Gffg/1Rol2oidvuya8M3a
         EwDNJ+GD2uVGa+2xRHOE+TMaSOsSaqDRttdUViv6S5yKrcBqH90QEoBfJV2cDIfSXKXY
         j/hWrLP9ep/WjqlU4fghgSIx1K4vySnNtiHyE4Zem1+5aUrbAHw7JOokwUwjjvogyyBj
         Lw6i1iYiPRnQY5ZzLm+hl/WqpdVmOIoycFySM35AkoS+VMBN6TsesBxpa826Ai8l6RV7
         URRQ==
X-Gm-Message-State: AD7BkJLKWhEUVpwZ5ZQjHwA6Kt6qhrwpxontFHbWUa7hbvi/EzUUEiQLmfwllF55OxIvDqcMymys+3zCjWePaw==
X-Received: by 10.129.45.194 with SMTP id t185mr88394ywt.243.1458076994416;
 Tue, 15 Mar 2016 14:23:14 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 15 Mar 2016 14:23:14 -0700 (PDT)
In-Reply-To: <loom.20160315T215800-306@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288915>

Hey,

Open Source projects run because of people who contribute in their
free time (mainly). It might not be possible for someone to be active
all times Sometimes it may take around 2-3 days. Give it a little more
time.

On Wed, Mar 16, 2016 at 2:30 AM, Saurabh Jain
<saurabhsuniljain@gmail.com> wrote:
> hi,
>
> I am Saurabh Jain, 3rd year Computer Science and Engineering student
> studying at Indian Institute of Technology, Roorkee. I am quite fluent with
> C programming.
>
> I would like to apply for GSoC 2016 under Git in libgit2. I read the list of
> possible projects and microprojects to be done.
> I tried to fix this, "Fix the examples/diff.c implementation of the -B"
> given in Starter Projects, I made some changes to the code and created a
> Issue on the libgit2's Github repository. But no one seems to reply to that,
> also the IRC channel for libgit2 seems to be inactive. Please someone
> concerned have a look.
>
> <https://github.com/libgit2/libgit2/issues/3686>
>
> I would also like to know who will be going to mentor GSoC 2016, libgit2
> projects so that I would be able to discuss my ideas with them.
>
> All the concerned Mentors you can drop me a mail at saurabhsuniljain@gmail.com
>
> Hoping for a positive response from your side.
>
> Have a nice day !
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
