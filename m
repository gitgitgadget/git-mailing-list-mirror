From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tig show <commit> not working anymore?
Date: Thu, 16 Sep 2010 09:47:58 -0400
Message-ID: <AANLkTimug6MC6iZvOu5b3g6rG=GeJiL5Fvnj4AD0ppWp@mail.gmail.com>
References: <20100916125337.GG5785@bowser.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Thu Sep 16 15:48:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwEpA-0008Cp-4l
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 15:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab0IPNsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 09:48:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33453 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab0IPNsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 09:48:21 -0400
Received: by gwj17 with SMTP id 17so399850gwj.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=IAsYonHtmLVqzSo3IbAw198OxWPPvpxnwul+OACh/fI=;
        b=PNu2QtxJc2QfS37gRCMLZewr86gAh+e37Qxt4CcPJqKy5MzJLyT72wAFfqnoraMNlW
         qLLEDy/ulxeU8AfJCPQ/rCRWdionZqJ3qSjV7c7To2oeWDglvBRd+N6Aey7kL4g3RCw2
         bEWTkNmFkHZE2Qjm6hfzdTsxrRd9uVpZLv3f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=b/3B8xqQjhZKBa1mRY5CNAtImmQFoZfa4Cl3g1ubB0eziAxEWP0Z2+zDxTgh9h3Z7f
         gLyN3+6m5/ru8bMYaSbAsqgD2h/JVYDva3SCgvH2eHOlB0CVO6BR+oLxgH5gu+COmQw3
         j0amvzsI6Xul06pjMl7Y3xuEONk0bTSQQkz/c=
Received: by 10.151.100.7 with SMTP id c7mr3880038ybm.74.1284644900441; Thu,
 16 Sep 2010 06:48:20 -0700 (PDT)
Received: by 10.231.39.138 with HTTP; Thu, 16 Sep 2010 06:47:58 -0700 (PDT)
In-Reply-To: <20100916125337.GG5785@bowser.ece.utexas.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156329>

On Thu, Sep 16, 2010 at 08:53, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> Hi!

Hello,

> I observed that, since commit
> 53c089443cd9885fa677becee4bf7ffd56c3c357, tig show <commit> doesn't
> seem to work the same way as I had expected it to. The documentation
> update doesn't seem to indicate that this was to be expected (or I
> didn't understand it properly). Could someone please confirm that
> tig show <commit> should actually do something similar to git show <commit> | tig ?

What is the expected behavoir that is not working anymore?

-- 
Jonas Fonseca
