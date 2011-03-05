From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] CGIT 0.8.3.5
Date: Sat, 5 Mar 2011 20:56:37 +0700
Message-ID: <AANLkTinoEw30_FZyUDc_80spbYEv5HV=3DH+tMGOVyPi@mail.gmail.com>
References: <AANLkTi=QjgcYRqJ_dY1zjUfz1TQCQz9Eo5Wi2fEJJfWC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 14:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvrys-0003MG-FX
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 14:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337Ab1CEN5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 08:57:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65220 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1CEN5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 08:57:08 -0500
Received: by wwb22 with SMTP id 22so3623272wwb.1
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 05:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=weKSyWu6mT7RETa+HVTA4eedYZOiB5meW+hyMv72xX8=;
        b=pIew0K1dUiWQMHoSG9TgEKOzV3azHstdZIwGDtyEMG1TylQzScbBvHhIdiPyfNHE8/
         UXP3/w7i/HLy63k77zIYXSeMMS8OfG7laWWzFjtqwkxesqEbvER5sPngJ2hGP6RWc+ZC
         7mi8VFzRc6uYuy2QB3RHLgM2T8areShKir1Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rv8nOmoQ1NnRRzyLZvXADfy31le7RjXwHjrTmJ2hCR1xdQSRMbF3KbX4bHKaZ84Moj
         3IFgOnWlpn5S2pm0Hx07T5zFSIbJs9kmESW7m9YHMrWPRxnxMH0idIO7LpuW9cDREVNw
         DaSrMZmYArRXZsMF0mGD+3wwJkgk9Zz32cy/E=
Received: by 10.216.123.69 with SMTP id u47mr1554543weh.16.1299333427209; Sat,
 05 Mar 2011 05:57:07 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Sat, 5 Mar 2011 05:56:37 -0800 (PST)
In-Reply-To: <AANLkTi=QjgcYRqJ_dY1zjUfz1TQCQz9Eo5Wi2fEJJfWC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168495>

Hi,

Does cgit have plan to migrate to libgit2 some time?
-- 
Duy
