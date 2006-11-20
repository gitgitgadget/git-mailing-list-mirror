X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Mon, 20 Nov 2006 18:37:41 -0500
Message-ID: <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 23:38:02 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eqDETl3iFNaSLXFJXca+DIa0tkhfgmpVgWKjaRvJDOOmfFKkrJI1mQZAqOPgp6nAfeKAe6ayr7q2DmE6U3OSByTW61dkoD9NsqEC8ZHx9s+42818+LhTWyLL+rv1H3GdigYgM4faQN/tMSEa6jZJQZWNExfcoFhDvvixKUm/0Go=
In-Reply-To: <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31959>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmIi6-0004FE-6c for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965823AbWKTXhz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966877AbWKTXhy
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:37:54 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:29305 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S965823AbWKTXhy
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:37:54 -0500
Received: by py-out-1112.google.com with SMTP id a29so1032916pyi for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 15:37:50 -0800 (PST)
Received: by 10.35.121.9 with SMTP id y9mr300472pym.1164065862157; Mon, 20
 Nov 2006 15:37:42 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 20 Nov 2006 15:37:41 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/20/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 11/21/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I have tried all of the available CVS importers. None of them are
> > without problems. If anyone is interested in writing one for git here
> > are some ideas on how to structure it.
>
> Hi Jon,
>
> I gather this means that the cvs2svn track hasn't been as productive
> as expected. Any remaining/unsolvable issues with it? I have been
> chronically busy on my e-learning projects, but don't discard coming
> back to this when I have some time.

Look in this thread
[Fwd: Re: What's in git.git]

There is a message in there that explains a problem that the cvs2svn
people aren't going to fix and it kills git.


>
> cheers,
>
>
>
> martin
>


-- 
Jon Smirl
