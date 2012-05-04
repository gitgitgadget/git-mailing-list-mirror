From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH] de.po: collection of fixes
Date: Fri, 4 May 2012 22:07:05 +0200
Message-ID: <CAN0XMOLNtD_ZTegeU0+ZBeSLJj3HesSEFKuZSDD7DF58R7pYWA@mail.gmail.com>
References: <1336075774-8447-1-git-send-email-ralf.thielow@googlemail.com>
	<87obq5vujo.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: jk@jk.gs, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 04 22:07:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOml-0006G8-KQ
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 22:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759583Ab2EDUHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 16:07:20 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34508 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab2EDUHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 16:07:06 -0400
Received: by yenm10 with SMTP id m10so2660701yen.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=463hVQKzSh8r7FQRNedkTig4YpolhAAfxInpt+Qd8MQ=;
        b=aed5Wjrql+7YSRitqXmJcYcSYaZk1ICyK8ReWD41Vz8FNsofyB8lMF7jk1es8TEEsj
         peLsaMj5d2Tnj2VHAuk5WydpXuWYtqit0stxidG+rcglNoRg/h7emSIGWnQFVZ6Tzsss
         RcJvcSqULxoiOPyfqu3i/hWii3Vv+CONaUaeMPuvtkkt7Y3YOvlJUIlLAUOmbF38bDGg
         0HTDHjja+UkHiZu1N+OdjQqDLn8ghc2px+txfWLoKqp/tHKJFGXozoMoQIliqHwS+Ky4
         iHJ3FLcgAHuzh5/WkTaTld+klZT61U9rHkL3yz1isVAdBRWND+jvVgFm6C/A+kB2yTid
         0cEw==
Received: by 10.236.108.199 with SMTP id q47mr9440053yhg.76.1336162025329;
 Fri, 04 May 2012 13:07:05 -0700 (PDT)
Received: by 10.146.203.1 with HTTP; Fri, 4 May 2012 13:07:05 -0700 (PDT)
In-Reply-To: <87obq5vujo.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197072>

I agree with you.

I've just sent a rework of this patch as part of a series with
other improvements.

Thanks
