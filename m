From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Feature request: Store comments on branches
Date: Wed, 21 Oct 2009 14:48:20 +0100
Message-ID: <26ae428a0910210648l11751185mbccbf53f3d467de2@mail.gmail.com>
References: <20091021133702.GA470@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Patrick Schoenfeld <schoenfeld@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 15:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0bYB-0005Nq-Nd
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 15:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbZJUNsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 09:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbZJUNsR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 09:48:17 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55103 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZJUNsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 09:48:17 -0400
Received: by ewy3 with SMTP id 3so6058678ewy.17
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=BXnT401pbQpaLdnLhxYUEEJyCQ3kFyx+LC8eEdlXnhU=;
        b=ge614B6JOUjlCRso0uSa4crtSABzybaZ+v2O0K6uZ1grTWp9OmjbuUslnWnWTvx8yB
         FPSlyFLepUaYaDhBbymhMZPmZ90qlp89BMnd8n/QvmaTRDqHQtoOZrWIONqrxkHNdL3a
         3xuRdjOp0XqhC6ouLqYUJBO9hVL0XIuWO4xJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=X12jqb4mbEXsPzCWIHz2sU6c/RtP78ulKf1qu5Pnv4AT28otiSoKWy3JgFq4lCXBvj
         CoL2lymnqWlnu++7rkrmviE93YDAo3YR/zHK0VNXJyTvO8oqF6CdMRPHdjmqboOnrXTy
         XBWmtwTaseZSN6/OIylW9LkSJj2CL8Cp3U930=
Received: by 10.216.90.209 with SMTP id e59mr2917265wef.193.1256132900446; 
	Wed, 21 Oct 2009 06:48:20 -0700 (PDT)
In-Reply-To: <20091021133702.GA470@lisa>
X-Google-Sender-Auth: f2557e9e2b585315
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130918>

2009/10/21 Patrick Schoenfeld <schoenfeld@debian.org>:
> Hi,
>
> I regulary work with various branches, that I call by the number
> of an associated bug tracking / support tracking number. That
> makes it clear to which ticket a given branch belongs.
> In this case I would find it very useful, if I could associate
> short comments with a branch, which would be shown when
> doing a 'git branch'. This way I could see what this branch
> about, without looking up the ticket information.
>
> Obvious the workaround is to name the branches different,
> but this is sometimes not convenient and may result in quiet
> long branch names.
>
> What do others think about this? Would this be useful
> for others, too?

Definitely +1.

Even on a much more simplistic level (and speaking as a relative
newbie) I feel it's an important feature missing. It's terribly easy
in the fog of working on several different projects to remember what
all the branches really are. It is just human nature that you think it
makes perfect sense at the time but in a couple of weeks time you
can't find the branch you want from three or four similar ones. A
comments field for branches would be very helpful.

Howard
