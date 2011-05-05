From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/1] status: display "doing what" information in git status
Date: Fri, 6 May 2011 01:06:45 +0200
Message-ID: <BANLkTi=teRP8cMJeDC+khUtYD61SmeSdLA@mail.gmail.com>
References: <1304632126-16733-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 01:07:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI7dr-000458-5B
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 01:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab1EEXH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 19:07:26 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60597 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1EEXHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 19:07:25 -0400
Received: by qwk3 with SMTP id 3so1859588qwk.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=GwQZSwok/gUJ4y1bYRbYIHQxp2QLEzCNPPvzsVGS3bY=;
        b=OlotXbH6JCMie9THJt8H9CA3FEBDoCpWXewIGQUF9/xhCkBuCB9rALOBoIuf2ge/Ky
         u6MYmDioFqqtLGKWDkulOsfgKcOG9EZ7dwcvAjNQFSj5tSsz9f9VeFHwZ1ccRSK8rj1k
         q1242zmY3zHG62EECRFIpZJ+h1/HEanYx1lzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XCqgkPlVxXeGeom/e96v0L7mLYOiv6nOA89aIJv9j4yMtECstjc6CyR+o48KJQClOU
         rDbaRTBOqcr09vosSQX2O8mIkIzytWVL9Vpjh1AhHIhUDTV5VBfn1X5qsJ4NysJlxbrp
         oKdshgj/rG277Sg2+RJuIYS38Fdcf35vfDqwc=
Received: by 10.224.33.132 with SMTP id h4mr3019092qad.284.1304636845148; Thu,
 05 May 2011 16:07:25 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Thu, 5 May 2011 16:06:45 -0700 (PDT)
In-Reply-To: <1304632126-16733-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172922>

Heya,

On Thu, May 5, 2011 at 23:48, Pierre Habouzit <madcoder@debian.org> wrote:
> This provides the same information as the git bash prompt about the
> current operation that is going on: rebase, merge, am, cherry-pick or
> bisect.

Can you show how this will look like?

-- 
Cheers,

Sverre Rabbelier
