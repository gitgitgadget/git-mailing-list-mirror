From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2007
Date: Mon, 30 Jul 2007 23:35:39 +0200
Message-ID: <200707302335.39688.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com> <200707271320.06313.jnareb@gmail.com> <fcaeb9bf0707301425y58b423f6x6141949845483e01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFcuO-0004Hx-9r
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966935AbXG3Vfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966865AbXG3Vfr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:35:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:20459 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965999AbXG3Vfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:35:45 -0400
Received: by nf-out-0910.google.com with SMTP id g13so172106nfb
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 14:35:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=k5bkS//MJiGvZB1kQRLYIx8HNgRRB/JrjfdPKmujes2+0r7yxajNVG38H77888sQd1T3RyggqmmMSr23dm92L2GCH4J1FHQQQZDAv07jVgx2IW8WJPG1T/mt9hThQ7m+hFqLL9ro5XZE7wt9J212lKl4q3g7iZnpWVbt+Zl8x2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e9rSywxdndXN9/YPpa1tLjXv0xcfeaKo7R+ZmQ8RHba29BD7MjhbULUnzhftgPYxD/yzn7v9zcByxhMROkaU5ZT5gwLrAqt3/U2JTkmYRnUkYUgpmuQsZmcEJjY69fQQPTvtqQwIgLiUKI3qj+okSLbvE9pGCnIuTsPw8EcXTOc=
Received: by 10.86.79.19 with SMTP id c19mr4214299fgb.1185831344356;
        Mon, 30 Jul 2007 14:35:44 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id k29sm1371524fkk.2007.07.30.14.35.42
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2007 14:35:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0707301425y58b423f6x6141949845483e01@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54277>

On Mon, 30 July 2007, Nguyen Thai Ngoc Duy wrote:
> On 7/27/07, Jakub Narebski <jnareb@gmail.com> wrote:

>> It's been more than a year since last Git User's Survey. It would be
>> interesting to find what changed since then. Therefore the idea to
>> have another survey.
> 
> I am probably going a little far here. I think we should include
> briefly in the survey announcement what git has achieved since the
> last survey. We want to know what changed from users. Maybe users also
> want to know what changed from git since then. Also it would be good
> advertisement if it gets posted on online magazines and popular sites.

Well, there are in the survey questions about changes in GIT:
----
Changes in GIT (since year ago, or since you started using it)

    0. Did you participate in previous Git User's Survey?
    -  yes/no
    1. What improvements you wanted got implemented?
    2. What improvements you wanted didn't get implemented?
    3. How do you compare current version iwth version from year ago?
    -  current version is: better/worse/no changes
    4. Which of the new features do you use?
       (zero or more: multiple choice)
    -  git-gui, bundle, eol conversion, gitattributes,
       submodules, worktree, release notes, user's manual,
       reflog, stash, shallow clone, detached HEAD, fast-import,
       mergetool, other (not mentioned here)
    5. If you selected "other", what are those features?
----

Regarding announcement of what git has achieved since last survey:
I'm not sure what is the full list. RelNotes are fairly recent,
unfortunately...

-- 
Jakub Narebski
Poland
