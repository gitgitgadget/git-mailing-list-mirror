From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: tig show <commit> not working anymore?
Date: Sat, 18 Sep 2010 10:47:42 -0400
Message-ID: <AANLkTimw3F8x5CqkFQ+owR1RHBJndquXE1KamrKeMV0g@mail.gmail.com>
References: <20100916125337.GG5785@bowser.ece.utexas.edu> <4C922112.404@drmicha.warpmail.net>
 <20100918050122.GA24656@bluemoon.alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Sep 18 16:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owyi9-00005X-6L
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 16:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579Ab0IROsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 10:48:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38684 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab0IROsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 10:48:05 -0400
Received: by iwn5 with SMTP id 5so2819488iwn.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=RsErbUdl9lsO+X3MEc6/pJfwLYSLPurdsGMUDuQSgM8=;
        b=BauL4XCdWML0S7fS50niVu6eXBjNZgfC+Lh7OqWHHYvw1q6o9wTNKCZ8ZEj0l1NzlQ
         BX8txyg5ZwsdaS7G0w1iMEojlmO4CEdIyyo90D23woBMoTQVDf/02j2cc+mc1yKGduN/
         9jpsM4iwS6K97j59ULnPgIE6ovdbCRIJpRtwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        b=fxTGdrRjJzjV9Dvg+eDoP3vTke07goRWerMwixd2gPCmmq0korPY4dqU/MJk/5aJr1
         PKlu+VFteSHnncaDpyXVognkDMFOfZMhJtHCjG6+CfnfsJ71ndHUVr85pj2kT1Jzcwrk
         L4Gzz8YyHLiB5wnCs6q7dSBLKM58fuaZ7YA/c=
Received: by 10.231.32.130 with SMTP id c2mr2701961ibd.28.1284821284027; Sat,
 18 Sep 2010 07:48:04 -0700 (PDT)
Received: by 10.231.39.138 with HTTP; Sat, 18 Sep 2010 07:47:42 -0700 (PDT)
In-Reply-To: <20100918050122.GA24656@bluemoon.alumni.iitm.ac.in>
X-Google-Sender-Auth: sPRV1Nvpi34gVJShswEqj21gsZU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156460>

On Sat, Sep 18, 2010 at 01:01, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> I'll continue to try getting at a fix, unless someone comes to it
> before me.

I will take a look sometime today and hopefully release a new version.

-- 
Jonas Fonseca
