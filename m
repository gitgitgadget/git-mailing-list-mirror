From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Wed, 29 Sep 2010 09:56:20 +0200
Message-ID: <AANLkTimes-ds-C1+_tdTW2vCdBR9gC7hTNhsyMoCu+rS@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk> <4CA1899F.2020509@cadifra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rico Secada <coolzone@it.dk>, git@vger.kernel.org
To: Adrian Buehlmann <adrian@cadifra.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 09:57:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0rXR-0008BL-MM
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 09:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab0I2H5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 03:57:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50921 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab0I2H5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 03:57:08 -0400
Received: by iwn5 with SMTP id 5so706947iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=jc9avm5yFKncuuPQ43eFXQh5uBNAsDNvdy424z029jw=;
        b=Q+6ah6r2L5UcoQz8KR/lZjtWZQiCSMJQmYscr1ULFXVMqmOQ/29MzBmZbDI/r1MjZB
         1EVqxxLuV8ioabQDUPpe7/2Z2XeMJS1RIdJPjO7h2sQcW0qWo4cRXDv52uqnJPexlu9a
         qpb+QiLl56v+TwzchazCl6YYfrqz8oqHmwsJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vOoGdRMNKbcQ3RzUcshU40a8mbKcZtUq5CdmyKjLAgsA762aCZf3qs/paTRSFsqzxz
         zoR77E80V/kEXu9N0wV5A3GFG8hVl/WaelTcLb6chkC/C+hphwxEWtKgdRIq9hr1IqIi
         LBZCU9GmYaga3UNier9NszUYzkCMZGKwWgpzU=
Received: by 10.231.172.75 with SMTP id k11mr1411506ibz.4.1285747027035; Wed,
 29 Sep 2010 00:57:07 -0700 (PDT)
Received: by 10.231.197.143 with HTTP; Wed, 29 Sep 2010 00:56:20 -0700 (PDT)
In-Reply-To: <4CA1899F.2020509@cadifra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157542>

On Tue, Sep 28, 2010 at 08:22, Adrian Buehlmann <adrian@cadifra.com> wrote:
> I think this would definitely be an improvement for git users. At least
> splitting up into dev and user, like Mercurial does it too (which I am
> used to). Not sure about announce though.

So, what is the decision? Split or not split?

-- 
Sebastien Douche <sdouche@gmail.com>
Twitter: http://bit.ly/afkrK (agile, lean, python, open source)
