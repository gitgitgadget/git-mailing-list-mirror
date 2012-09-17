From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 08:25:19 -0700
Message-ID: <CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
 <vpqy5k8raig.fsf@grenoble-inp.fr> <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
 <vpqd31kr7v4.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDdCu-0000EU-2D
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 17:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155Ab2IQPZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 11:25:43 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:51309 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab2IQPZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 11:25:41 -0400
Received: by qaas11 with SMTP id s11so1662031qaa.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bnnjpLJGsnzcdE6Af1RcFwvpT7iR7O+D1jxzt57cp7Q=;
        b=W0QcdJMAT8zkmJUh4YY6pEgEc5R28uTV3kPRilE0yTvfiCwB+RwrGhhQV7COCZMUYV
         9ZqJ+nbRuuTZY9fIonnQJMPuOhnBZeUG522PioZ4vgd23/4GzIlsCF1x0koq7QgRGlmi
         Akr7+cYZIi4LGvJVJk11uj25TgWz+2tJMd5k3CxgxX1sfv3we5DeqZ65i40cH8+oaeeZ
         nIL9lHs6ZbzlGJXmJNCTAS7sSJWZvCmpPM+ZT3yGyFpwYO/hHzPLwzN/wSP29LkGYdY8
         2OD8gUDs7BYYve60LIkAdjNIwmJ3sKEob/CXtjvqQL9kBc6Dx5k506x9mtjwGHSTn1Zq
         mO5w==
Received: by 10.229.135.193 with SMTP id o1mr7646582qct.100.1347895540216;
 Mon, 17 Sep 2012 08:25:40 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 08:25:19 -0700 (PDT)
In-Reply-To: <vpqd31kr7v4.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205700>

Hi again,

Matthieu Moy wrote:
> Does this user have the same UID as your usual user
> (id kseygold; id $LOGNAME)?

Yes.  What do you propose we do about the test?

Ram
