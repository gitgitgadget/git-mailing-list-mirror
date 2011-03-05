From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] CGIT 0.8.3.5
Date: Sat, 5 Mar 2011 15:20:26 +0100
Message-ID: <AANLkTi=nADwttD4UHK-vsq3RAr3U8hd=GHkfF6PCz+Uj@mail.gmail.com>
References: <AANLkTi=QjgcYRqJ_dY1zjUfz1TQCQz9Eo5Wi2fEJJfWC@mail.gmail.com>
	<AANLkTinoEw30_FZyUDc_80spbYEv5HV=3DH+tMGOVyPi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 15:20:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvsLQ-0005yf-M8
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 15:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab1CEOU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 09:20:28 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43692 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab1CEOU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 09:20:27 -0500
Received: by vws12 with SMTP id 12so2725812vws.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 06:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9bNEU9s2nOQYKdBr21hLSp4a5g/HmWdt4xlM82+G/98=;
        b=Sf6qS2q5DgcGv8o0UcKOHzRufxbp673RTsgggDD/iEcd6AdS41fxQX44CyLyIggKaI
         sfYL/y/wQXgfnLvLs+WA9NQX6eQ1YmG70MYFCx+zY3ILG9TTYQoTyKOsoUIkshJqatG7
         egZvlenAMgHNwU0jeTly7w9Dx7TyU06NgDclM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HGr4S6TVa+Ky+CD5kg8ndHNo1ILfnPnJqYEt2+o8lZhKrwfJhqAJHHoAlnTt+b+vh3
         F03d4AE6nA+sIw59FCgwypEj4jfDqw5hWCobHT1umBVT8pz2JK5AkkiP67G3ZpFTf+XJ
         oBcZOniBYf1A05g33wNQmdKOfByr8wyNxYnVo=
Received: by 10.52.69.208 with SMTP id g16mr2678447vdu.112.1299334826820; Sat,
 05 Mar 2011 06:20:26 -0800 (PST)
Received: by 10.52.160.130 with HTTP; Sat, 5 Mar 2011 06:20:26 -0800 (PST)
In-Reply-To: <AANLkTinoEw30_FZyUDc_80spbYEv5HV=3DH+tMGOVyPi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168497>

On Sat, Mar 5, 2011 at 14:56, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Does cgit have plan to migrate to libgit2 some time?

That would probably be the right thing to do, but I have no specific
plans about migrating.

-- 
larsh
