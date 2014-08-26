From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Improving the git remote command
Date: Tue, 26 Aug 2014 12:05:54 +0200
Message-ID: <CAGK7Mr6s3UFDUD-6_yi2aK7PRF08YK2Jq=NBR_CtN7YPzP_oPA@mail.gmail.com>
References: <53FC537C.4080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?R=C3=A9my_Hubscher?= <hubscher.remy@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 12:14:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMDlA-000345-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 12:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934635AbaHZKNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 06:13:47 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:43782 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbaHZKNq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 06:13:46 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so11607494oag.21
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yJCTl9fAz00l8MxwiHeU6A9667F0y3dYCzlJcKb+RK4=;
        b=YOeRWDMXhh8V2g6ZuPfetAOgVISE59pj3bbRqreO9jGq0sQR0AJsQhw7kMmlvvRPCo
         afiwqAGl0Cy1HkjUlRvkHnL1qF4u+TLduBH1gofBeQHof1xdEzFcBBd39jvzYYRWxFdl
         mS9glndAwtTW6S9cuKvAHWeSP6N07cQW5VS5ZH6rbw73Oq8CwamcS4QEnpW5dmkXkHJ8
         jIhe8DsNRlrWCAeaKIZRhtaqzAzZfbsO+QdutWci4eWUw1YH5iyJbc5RwPH9+kL55mKv
         HXj5Kc+rZz95G0H+jeMQFRa1PRGnWUNEjZui5DY/rIxyNnbLxBXYg+p7jHVQKOaBiAEX
         /jkA==
X-Received: by 10.60.58.65 with SMTP id o1mr27475403oeq.2.1409047584258; Tue,
 26 Aug 2014 03:06:24 -0700 (PDT)
Received: by 10.202.93.131 with HTTP; Tue, 26 Aug 2014 03:05:54 -0700 (PDT)
In-Reply-To: <53FC537C.4080206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255882>

> I often write `git remote list` before finaly using `git remote -v` but
> it isn't intuitive.
>
> I am proposing to add `git remote list` as a shortcut for `git remote -v`

I suffer from the same problem. I think your proposal is a logical and
nice idea.

Philippe
