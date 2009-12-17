From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: how can I push a sub-tree
Date: Thu, 17 Dec 2009 18:14:00 +0800
Message-ID: <be6fef0d0912170214u433769e3ucf8180022aa72fb3@mail.gmail.com>
References: <2986b3940912170150o17118a07i8f91e785c08e2ac9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Zhi Li <lizhi1215@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 11:14:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLDN6-0001zJ-Fy
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 11:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764285AbZLQKOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 05:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761418AbZLQKOH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 05:14:07 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:37499 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZLQKOC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 05:14:02 -0500
Received: by iwn1 with SMTP id 1so1354154iwn.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 02:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=k/ZB4eVgFM4gi1gq3yS1bqKjsWH93NzjNqSxam5b6zg=;
        b=tz3oi9TKL3RBJ+SbhVuqySNpbf2MZ8LXFZKXoLcda/2NZU950Kz8joxCKf+okDpKUb
         euCX70VkeKxQMiI0kQwEfOb2gNyWShE1BMAXNDlS7haQ+I1WbhyLJQibosHNK6IxuttV
         Y2O3XsoRT9J9+MMFBZGYxKdZsVBGb1hv7n/vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jXZRFeTrf+NoM10FkCUJ5ywxcVmPk6qBaO0RkuDmCeG7iO9+D8i6VWYkXyYCv3UYka
         S32YVWLShQzouImg4PJRWkEB2Y+FyHy42/CpkfwLQ3bAk0CnxXE72Z0nL18tMk6/5Shs
         f5K8vtc+PP+BvnHx/fl1w5StQZYbRTKmg4Nqw=
Received: by 10.231.9.218 with SMTP id m26mr342711ibm.29.1261044840385; Thu, 
	17 Dec 2009 02:14:00 -0800 (PST)
In-Reply-To: <2986b3940912170150o17118a07i8f91e785c08e2ac9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135365>

Hi,

On Thu, Dec 17, 2009 at 5:50 PM, Zhi Li <lizhi1215@gmail.com> wrote:
> I tried to find a way to push a sub-tree. In section 6.7 of "Pro Git",
> there's a way for pulling a git sub-tree. But I have not found the
> opposite: push a git sub-tree. Can someone help me?

I've not read the book, but perhaps you mean submodules?

If so, refer to the part in the git submodule tutorial that describes
how to make changes within a submodule on the GitWiki at
http://git.or.cz/gitwiki/GitSubmoduleTutorial.

-- 
Cheers,
Ray Chuan
