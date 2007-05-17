From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Change base font size to "small"
Date: Thu, 17 May 2007 10:31:27 +0200
Message-ID: <200705171031.28875.jnareb@gmail.com>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com> <200705161251.38729.jnareb@gmail.com> <20070517021723.GK4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jan Hudec <bulb@ucw.cz>,
	David =?iso-8859-1?q?K=E5gedal?= <davidk@lysator.liu.se>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 10:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HobXP-0002pl-3w
	for gcvg-git@gmane.org; Thu, 17 May 2007 10:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbXEQIkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbXEQIkT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 04:40:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:9976 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbXEQIkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 04:40:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so287222uga
        for <git@vger.kernel.org>; Thu, 17 May 2007 01:40:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iO4zXV1FxSFC2lyV6nmhZTbmEGbbjIXPu8kOrHMiLh7LSfTVeZQX+Ns8BlxDQR8Ngp9BZcvXExgriZSR4eXML5n6KovCGaoJvxq2X1WrTnKdQHFtu+V/IDMr9L3oz+q/iuEErcGwA/JZpS6bB0wU9WDAsqucjPvdwUFsRsKuTvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=riNdXQa06b35PFxSduJ+FpSnsbhP/H4sVDdpcMkNA5VkjF18N5XVvbeqb/v7rxnKUQHxdCrlMvqmeMpjmSNwAYTdgi8uOMZuqZnHVQ4tGITT0t0zu1clninNxh2pEcwnupyUZjjjMr2U40zpmjo7lCVlrU4Jk/JRa+0XbzlNBpU=
Received: by 10.82.176.3 with SMTP id y3mr142330bue.1179391215642;
        Thu, 17 May 2007 01:40:15 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm43961muf.2007.05.17.01.39.53;
        Thu, 17 May 2007 01:40:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070517021723.GK4489@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47507>

On Thu, 17 May 2007, Petr Baudis wrote:
> On Wed, May 16, 2007 at 12:51:38PM CEST, Jakub Narebski wrote:

>> Proposed-by: Jan Hudec <bulb@ucw.cz>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> Acked-by: Petr Baudis <pasky@suse.cz>
> 
> just for the record, since it seems to be already applied anyway. By the
> way, I think this commit message is more optimal than what ended up for
> some reason (Jakub wasn't fast enough? ;-) as
> b211c320eb5d753a7a44a03eccb9a15cfbcc563b - especially the subject of
> that commit is really weird.

Second 'gitweb: Do not use absolute font sizes' commit in git.git repo
is from (authordate) Wed May 16 01:59:55 2007 +0200, while this one:
'gitweb: Change base font size to "small"' commit in my repo is from
Wed May 16 12:16:02 2007 +0200

So it looks like my patch without commit message in
  Message-ID: <200705160159.55590.jnareb@gmail.com>
was taken, and commit message was added by Junio, and not ready commit
from this subthread (in message you have replied to, and which you Ack)
  Message-ID: <200705161251.38729.jnareb@gmail.com>

Gah, either I shouldn't have send bare patch, or I have should send
reply that I'm working on commit message for this change.


I have tagged my commit message in git/jnareb-git.git repo as 
gitweb/change-base-font-size:

  http://repo.or.cz/w/git/jnareb-git.git?a=tag;h=gitweb/change-base-font-size

to protect it against rebase + prune.
-- 
Jakub Narebski
Poland
