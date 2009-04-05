From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 7/7] user-manual: simplify the user configuration
Date: Sun, 5 Apr 2009 11:11:42 -0400
Message-ID: <76718490904050811n3a5d2bby466c7955e7435ee3@mail.gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-8-git-send-email-felipe.contreras@gmail.com>
	 <76718490904042036q26bebc13p91c8cffaf432c02c@mail.gmail.com>
	 <94a0d4530904050214y256cc0d3icc1843cfd148d69d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 17:13:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqU28-0000QL-La
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 17:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbZDEPLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 11:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbZDEPLp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 11:11:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:28471 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbZDEPLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 11:11:44 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1763361ywb.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q7gbd+Kbf7NwpywVnA3zpccQKRHobKOLLgdX8zpELHE=;
        b=EmuyerzZ/aRF8WoKRMsvoxsaDjY1vCwigU6Qn7UBGFo9YSOFr4br+O268wGFHhU5WA
         CmYtof1TY/KDek/7P+pjbwli9TCNj01KlcKez9qAbpNo5uF1X8EoacQFUflq1nSiZpqp
         3F3CDQiPwn3nrz2bi9XctzkwaWmIOCBs6jSMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SC8Q/kkACIvMkzMkOj6S/4QtylO+Pg2+fhJKrt5nTqP/eJ2RW37hOCjxTrZDBz9baF
         ncseUpJcxC8A46YqPnE3LwhM8gEEzuBJdBq89m4LaBmid8xeat1Cen9P0OGVdy+RPfWj
         7l/MfUcSxrljfUtGQPyYm4+lx221pzl8VxXWA=
Received: by 10.151.108.3 with SMTP id k3mr6474565ybm.103.1238944302096; Sun, 
	05 Apr 2009 08:11:42 -0700 (PDT)
In-Reply-To: <94a0d4530904050214y256cc0d3icc1843cfd148d69d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115671>

On Sun, Apr 5, 2009 at 5:14 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
=> Ok, I forgot to explain this again the commit message of this
> particular patch, but it's described in the patch series description.
>
> The previous patch adds a 'Getting Started' section that explains
> exactly that; you can edit ~/.gitconfig.
>
> So that concern is already addressed.

Doh, sorry. Thanks for the explanation.

j.
