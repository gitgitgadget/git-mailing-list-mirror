From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: Feedback outside of the user survey
Date: Thu, 16 Oct 2008 13:08:06 +0200
Message-ID: <2d460de70810160408x784a657fte418d41dd6a06d7f@mail.gmail.com>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com>
	 <20081016102835.GC20762@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 13:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqQjN-0005im-Er
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 13:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbYJPLIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 07:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYJPLII
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 07:08:08 -0400
Received: from rn-out-0910.google.com ([64.233.170.185]:64738 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYJPLIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 07:08:07 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1430754rnd.17
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xqPuvt7gUe8fMcfkils2Qh6OeMVc2K2Vs2ygO6u6W54=;
        b=XeV83lhUm6y3AKAwCS2yfZJFSBiA1X7rcJjjUbJBHDiAUWOQoAQEF3aBzf69ksEWeW
         HDV+hY6i+da3tMC2yzlGCUf97keDJg8Rsy5DXUoujWEDg1lcjwOnyfnkOwh6jFBsw4pJ
         giTurxRieBZEw4O/+ZFAmNz8+DsH6Lahg1tuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JXA13iUa/eiTeC8NbZ4EfBoh8BCb2ew8aYoesQsWs2EKbsNXrPjEx+/Vtvc3H6HNpd
         9qBoOhmAk63AJ3i3a3gxv386ZgTWQowRDWKezLRuIqNoq/Yh4qXcDcv7r8m+jpqS2zh8
         m30G15rony4kcKO4G+OBczsSTN29nMjM0h4W4=
Received: by 10.100.227.6 with SMTP id z6mr3147711ang.34.1224155286123;
        Thu, 16 Oct 2008 04:08:06 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Thu, 16 Oct 2008 04:08:06 -0700 (PDT)
In-Reply-To: <20081016102835.GC20762@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98365>

On Thu, Oct 16, 2008 at 12:28, Jeff King <peff@peff.net> wrote:

> Is there something about these that doesn't meet your criteria? Or did
> you not know about them (in which case, maybe we need to be more
> prominently pointing to them)?

In best slapstick fashion, I found the pages you mentioned in 1) and 3)
after sending off my email. Maybe they did not exist back when I last
looked, maybe they are easier to find now, maybe I was too stupid to
look, back then.
In any case, those two fit my needs nicely. In fact, I would have said
as much on this list if I had not become stuck in reading said docs :)

As to the resource you mention in 2), it is nice, but it does not fit
exactly to what I had in mind. You have a lot of snippets and single
steps, which is fine. What I was imagining was more like a use case
& workflow-driven layout.
A basic or complex task could give a short overview of steps, all of
which would be hyperlinked to detailed explanations. As a lot (more)
documentation seems to exist since I last gave git a serious try,
this is probably mainly a work of coming up with workflows and
linking to the correct places, not so much of writing any actual new
text.


And yes, I think the fact that these newbie-friendly docs exist these
days should be pushed more agressively. As you can see from the
links in my initial mail, a _lot_ of people have the same
misinformation I used to have. That will mainly be due to old
knowledge, but the situation exists. Worse, those people will warn
others about the lack of starter-level docs, making more people
shun git for all the wrong reasons.

An easy step in this direction might be to _prominently_ display
direct links to the newbie docs on the entry points, for most users.
I.e. the main site [1] and the wiki [2] along with the FAQ. I would
edit the wiki myself, but I could not find
MoinMaster:MoinPagesEditorGroup nor MoinMaster anywhere
in said wiki, thus decided to heed the warning & not edit at all.


Richard

[1] http://git.or.cz/
[2] http://git.or.cz/gitwiki
