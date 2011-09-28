From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: emacs as mergetool
Date: Wed, 28 Sep 2011 09:33:31 +0530
Message-ID: <87d3elfh4c.fsf@gmail.com>
References: <201109261821.28382.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Wed Sep 28 06:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8lNB-0001Op-CS
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 06:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab1I1EDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 00:03:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61964 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab1I1EDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 00:03:43 -0400
Received: by yxl31 with SMTP id 31so6020467yxl.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iacddZOF5sni6qv0MmKwxNpD0KR/y2+c8MEspAnralk=;
        b=r9aSrAnY+bvGAND+SAy59EGWNrypfpTQJg7faq5d0DFAIpU65+pPfg/s1FXBSwknPM
         FlNC3BowHafbjTbwD9xNbU4znpIqhg2x22uo1H4iYuRdDCt9v+v19piqP3H3GJdpJI5N
         +FqeFX10CJ/toSSqUM0CBdaBVtynG+rFjJ9Bk=
Received: by 10.68.40.234 with SMTP id a10mr41598650pbl.120.1317182622493;
        Tue, 27 Sep 2011 21:03:42 -0700 (PDT)
Received: from BALROG ([59.92.45.86])
        by mx.google.com with ESMTPS id p9sm3365432pbq.12.2011.09.27.21.03.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 21:03:41 -0700 (PDT)
In-Reply-To: <201109261821.28382.thomas@koch.ro> (Thomas Koch's message of
	"Mon, 26 Sep 2011 18:21:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182288>

Thomas Koch <thomas@koch.ro> writes:

> Hi,
>
> would you be so kind and give an emacs newbie (and vim refugee) a hint about 
> using emacs as mergetool?
>
> - Which one? ediff vs. emerge (I don't bother learning, just give me the best)
> - I'd like to have a setup, where I can run mergetool with different options 
> to
>   - connect to a running emacs server
>   - run emacs in X
>   - or in the terminal (default)
> - Is it possible to resolve all conflicting files in one session instead of 
> having emacs called again for every file?
> - Do you know a tutorial on emacs as a mergetool?

http://www.emacswiki.org/emacs/EmergeDiff works for me.

> Thank you,
>
> Thomas Koch, http://www.koch.ro

-- 
Cheers
~vijay
