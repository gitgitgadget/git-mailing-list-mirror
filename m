From: "Mr.SpOOn" <mr.spoon21@gmail.com>
Subject: Re: Git for collaborative web development
Date: Thu, 26 Mar 2009 20:41:32 +0100
Message-ID: <8f67b6f80903261241s7bbb179bwf5e9fa64f657ca1d@mail.gmail.com>
References: <loom.20090326T184207-345@post.gmane.org>
	 <fabb9a1e0903261218y329562f6uf18613f3f9e15836@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 20:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmvUR-0005Qh-EL
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 20:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbZCZTlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 15:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758564AbZCZTlg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 15:41:36 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:34822 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661AbZCZTlf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 15:41:35 -0400
Received: by ewy9 with SMTP id 9so754714ewy.37
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mK1IZn9oiSYSE9XWhKrpQWBpRMae6Ap33xw3PJpBiNg=;
        b=KZpVNs4lGdcvNqE1u5Rw8gxw9GFDHRQkTT7VkPweDpk67lQuLgdW7SAaUdc8kTYRSZ
         nD2qNKnreP1MuQgv11jQ0uzZZ/wjMV3BndavhGUIzug+GuPKugZK1QggCvBUp4GpzAyJ
         K4yj14N3LD4NkHpnGUOdq/ZJ9HRNlB22+4tnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=alUtkPoyEDeqyzaxuossuFcRX/kaxL4KVRYMSQyG1AlEICQM2xQZfJlo1s171yhuxA
         GX//NEhFUp6PQeGj9JrZv6OULQHPp+jECesmwvpRjzJK6m4ku0HrC6jK4V2iSOjZPrLe
         EkhXkZA9b+2EUFxJhbTN00Qa2mvpgEANPUQmg=
Received: by 10.216.13.74 with SMTP id a52mr536396wea.145.1238096492365; Thu, 
	26 Mar 2009 12:41:32 -0700 (PDT)
In-Reply-To: <fabb9a1e0903261218y329562f6uf18613f3f9e15836@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114811>

2009/3/26 Sverre Rabbelier <srabbelier@gmail.com>:
> $ git config alias.tryout "!git branch -f tryout && git checkout
> tryout && git add . && git commit -m TryOut && git push shared_repo
> tryout"

That seems cool. I'll take a look to some documentation to understand it :D
Thanks.
