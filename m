From: Mohit Aron <mohit.aron@gmail.com>
Subject: Re: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 09:43:56 -0700
Message-ID: <ee22b09e0910190943x51d48c09sdc50d941d643358d@mail.gmail.com>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
	 <2e24e5b90910190143j5579d9dfle15df8625eb20a00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 18:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzvKz-0003om-On
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 18:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbZJSQnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756901AbZJSQnw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 12:43:52 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:37685 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869AbZJSQnv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 12:43:51 -0400
Received: by pzk17 with SMTP id 17so22054pzk.33
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=teU02SE1SPLpRrbnet1vwwytgNb5U5k5i8h7VQlA4+c=;
        b=QJU9PZ7xHMcHpFIrsWjwtrFJaT5YdJWe+pkDaTCmRhPhieY1Yo5o5cry+KQDQ9KOh1
         7z5cf3YATQtphhyNfawbFj0tKcyGnBmRXxDqj/cUe8Lqh8MWWd/9QLbC8/tAI45ERBfL
         yMOYL+T/4ML+VJBwY/I+SAJmoZ0wvD4d2NJYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IabyTvu6NYpjWkOLcE3AxSs8TWNc5xmTSunRVyk7D6O+ZPQexCCg4Iv5mTr0quLoiD
         5Y4ct08EmzVJdXhgXnMY/dNzbexlNTpnAwqlJGLdNev+nF1I0qeaDGcy9H3SYYL2u3nO
         dhpkNDaCalWPdtKkYEE+sGh74NnBzMGuJVW08=
Received: by 10.115.66.10 with SMTP id t10mr6789623wak.20.1255970636048; Mon, 
	19 Oct 2009 09:43:56 -0700 (PDT)
In-Reply-To: <2e24e5b90910190143j5579d9dfle15df8625eb20a00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130717>

>
> That was the main reason I wrote gitolite
> (http://github.com/sitaramc/gitolite), though now it does a heck of a
> lot more than just that.
>

That's great. You might want to consider making it a deb package
that's available from one of the Ubuntu/Debian repositories. An apt
search on Ubuntu 9.10 doesn't reveal it. I usually shy away from
installing software on my machines that is not automatically managed.


- Mohit
