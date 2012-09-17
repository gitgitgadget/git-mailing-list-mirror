From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: status of git interop with other VCS
Date: Mon, 17 Sep 2012 22:21:38 +0530
Message-ID: <CALkWK0knJKGK=jD=_dBUn+idVSEs+KxwvQJWc7oS_BvzPR9jJw@mail.gmail.com>
References: <1347795904.22408.20.camel@chianamo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Paul Wise <pabs3@bonedaddy.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:52:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDeYL-0006Vr-HT
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 18:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648Ab2IQQwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 12:52:00 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64303 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2IQQv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 12:51:59 -0400
Received: by qcro28 with SMTP id o28so4638933qcr.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QeFjp2zat7mIqO+UCBH9VFt11B+L7z2EKGgWQdn0Guk=;
        b=qvg420M/5YmhlVVclazrByd3Yq9u6Wp1qNq0jPf3f3wYBp54bpeokV/9OEohQkz6ct
         25ygnYlDUD/zijInNyN8cOdso4KTKWlZAPT252nvBer/aict/cKvsKZpFULqir658bj/
         CKOS9rJfMO8ap/S8BmKfCMOFUfKfdG/0AaOi15D8XH3esrqf+3PI92dKuE8q5k/B9bqp
         cj1YyOCRTn87lpumdOAE9BTld+F73OtGrEysR8Yd6XKY5VQuycHDufb+HJoSVRhHJNBo
         7ho2HRaWTjJVuszRQ1HXeXhltWPJ4Sgls2vGO/sFnwF/LdEEH2uhme8O4cJvqEmYQ10U
         9cBg==
Received: by 10.224.31.210 with SMTP id z18mr28677271qac.95.1347900719199;
 Mon, 17 Sep 2012 09:51:59 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 09:51:38 -0700 (PDT)
In-Reply-To: <1347795904.22408.20.camel@chianamo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205708>

Hi Paul,

Paul Wise wrote:
> svn: there was a gsoc project for this but it was never merged:
>
> http://git.wiki.kernel.org/index.php/SoC2011Projects#Remote_helper_for_Subversion_and_git-svn

I wouldn't give up on that yet. What is the status of fa/remote-helper?

Ram
