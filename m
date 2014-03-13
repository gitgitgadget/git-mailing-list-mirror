From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: Committing a change from one branch another branch
Date: Thu, 13 Mar 2014 10:36:06 -0500
Message-ID: <CANUGeEZc8BoV0MxUGRRGc8SK=-xB2YXoEkRkBTyGZ8FxSjnVTQ@mail.gmail.com>
References: <CAD6G_RRQVDxQj==-2vAT3WCiYMC=BmZhi__JWi4yy86Uaoa-og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 16:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO7gP-0005qW-FT
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 16:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbaCMPg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 11:36:29 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:36554 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbaCMPg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 11:36:27 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so1018252wes.12
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WiygzbYhI1kU8WJQGhypk78ghP6szDDhrvnAPUKk8R8=;
        b=x69DgPQqb09LDn+0YqQV/6W50JJRfU1zf9RAYVfLFqw3X7xWv91iHU/DV2qfpMEBHT
         SE00WfaSWIxdFMqQWDx3WARHdb++ecAAR9o2pxndf/M5QlZtsM1PrxJ8WSuKNEst6HiF
         Z5bIj5407nFRu+qMF5f3UO+DSzkvt+TacFAt02o9ySfqs/ORZv6A49xlJbrz7YLOPr+1
         H9CFAaI6QRXJ4KVldDUvbDKOJIdVlGQwfTbsH71GjOdDchMPqzVrUtYt6H2DOKgAnGJb
         /L4fUFSZc9URfra3kP86C9ubC27n807jQfS3sVF3EFz+GrA9jCBxc/rCqmzFa56VvbEp
         uleg==
X-Received: by 10.194.86.130 with SMTP id p2mr193160wjz.88.1394724986725; Thu,
 13 Mar 2014 08:36:26 -0700 (PDT)
Received: by 10.217.120.8 with HTTP; Thu, 13 Mar 2014 08:36:06 -0700 (PDT)
In-Reply-To: <CAD6G_RRQVDxQj==-2vAT3WCiYMC=BmZhi__JWi4yy86Uaoa-og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244033>

Jagan:

On Thu, Mar 13, 2014 at 4:56 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Hi,

Hello,

> I have two branches.
> - master-b1
> - master-b2
>
> Suppose I'm in master-b1 then did a change
> on master-b1
> $ git add test/init.c
> $ git commit -s -m "init.c Changed!"
> $ git log
> Author: Jagan Teki <jagannadh.teki@gmail.com>
> Date:   Thu Mar 13 00:48:44 2014 -0700
>
> init.c Changed!
>
> $ git checkout master-b2
> $ git log
> Author: Jagan Teki <jagannadh.teki@gmail.com>
> Date:   Thu Mar 13 00:48:44 2014 -0700
>
> init.c Changed!
>
> How can we do this, any idea?

What you're asking is ambiguous and vague. The example output that you
give doesn't even really make sense. You need to give more details
about what you have and what you want to do to get proper help.

Or join #git on irc.freenode.net for real-time help if you aren't sure
how to explain it.

Regards,


-- 
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bamccaig.com/>
perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
