From: "Li Frank" <lznuaa@gmail.com>
Subject: Re: Announce: TortoiseGit 0.1 preview version
Date: Sun, 14 Dec 2008 21:48:12 +0800
Message-ID: <1976ea660812140548k940a73buf307cd331b775f31@mail.gmail.com>
References: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com>
	 <m3d4fuewe0.fsf@localhost.localdomain>
	 <bd6139dc0812140528w4591ee03h9723ba66a967051b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun Dec 14 14:49:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBrLr-0007iL-MT
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 14:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbYLNNsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 08:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYLNNsQ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 08:48:16 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:13889 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbYLNNsO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 08:48:14 -0500
Received: by yx-out-2324.google.com with SMTP id 8so969263yxm.1
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 05:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XK7pZ2CGkJPcgqftek/jDMHBQEHwKTkr4UITXsPAA/U=;
        b=HEm9WO8+aUOIjORlLK+wNDPOCgx4xUa52eVCKZznEtVvRe1LmZfiSbHESYRCUSBjmW
         9UyEZYd4KEGIeoRc/bUMW3jsARi7SV2ixjffmTXLXm2UU09cu50aOoShaiUPfTLJxky4
         i55SJEDpURxTw125xrxxKGkhe8HjH4cbHKZ+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tzLu5phr0jq/al0fchUgPQspKFjQ1fbr9m+tSUd2pqBb1r23bkR/TqveLLvkOvqAkx
         woBrutz6dXqwuZymg9UcsUshWr760ee1YziZ679EUm3ONVF0hInXCHNwU3nEeOUDS6ga
         R39gZ5i3cJVutT+AocycI6I733TGJJfMxNUpE=
Received: by 10.150.230.15 with SMTP id c15mr10514823ybh.164.1229262492867;
        Sun, 14 Dec 2008 05:48:12 -0800 (PST)
Received: by 10.151.134.2 with HTTP; Sun, 14 Dec 2008 05:48:12 -0800 (PST)
In-Reply-To: <bd6139dc0812140528w4591ee03h9723ba66a967051b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103083>

I really want to make cross platforms!

But there are difference at difference platform.

At linux enviroment, user has been used to command line. I was worked
at linux project before. I also like it.

At windows enviroment is difference. User like GUI. SVN is typical
example. Why it is used popular at windows enviroment, that is
tortoiseSVN.

We have to face the fact, there are differences at different platform.
 I like core server is cross platform. But we can have difference
fontends at difference platform according special platform features.

For example, windows user like Visual Studio plug-in. But Linux user
like eclipse plug-in more.

I think TortoiseGit can make git popular at windows enviroment.
Window user is waiting for the good UI.  Porting from TortoiseSVN is
fastest way.


2008/12/14 Sverre Rabbelier <alturin@gmail.com>:
> 2008/12/14 Jakub Narebski <jnareb@gmail.com>:
>> How it differs from GitCheetah project?
>
> I really think it's a shame if this does not get integrated with
> GitCheetah. We need a good client not just on Windows, but on all
> platforms, with shell integration of course.
>
> --
> Cheers,
>
> Sverre Rabbelier
>
