From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Pair Programming Workflow Suggestions
Date: Tue, 15 Sep 2009 11:20:15 -0700 (PDT)
Message-ID: <m3zl8w2hpf.fsf@localhost.localdomain>
References: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 20:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnceW-00077Q-Bx
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 20:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbZIOSUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 14:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbZIOSUS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 14:20:18 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40937 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbZIOSUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 14:20:16 -0400
Received: by mail-fx0-f217.google.com with SMTP id 17so1772214fxm.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=K3kMC7YMfF3/x3RAIdyUn6kj28Bu3JhA3CF+wc0arKI=;
        b=XpgG6jmdRc1LQxLWrUWsdT1dX5nnCUOK2hqB3/d0jh1K8QH6nWK5otv2pVTqvmUr7X
         sNcd3u81r96K8V/QKLQg1wbAHOuHwD4iYVNZBj6FTQLPXtnZqcucVR7WIjzA1LLS8Ktf
         iAkkq7ouOLzTooXaTN+W5l8J+Y7aO6QWiXbBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hzMJECgeEuA4LFwKerqzG+MpwagUTArMkbgHqtqKekh1EkXQOR+U065ZAF5bDGBcu0
         J/hzIzmVK10BK6fpcaJHFRxwHE4vDXhzrcYsazcCYFH1xSgBp4VOzHwJchIBRUOWOQU9
         ogLqhIOr8bipAS5HUJPQM5gI4/dl1dHzaL4oE=
Received: by 10.204.143.151 with SMTP id v23mr6606524bku.169.1253038818783;
        Tue, 15 Sep 2009 11:20:18 -0700 (PDT)
Received: from localhost.localdomain (abwd220.neoplus.adsl.tpnet.pl [83.8.227.220])
        by mx.google.com with ESMTPS id p9sm333790fkb.7.2009.09.15.11.20.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 11:20:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8FIKDJq025003;
	Tue, 15 Sep 2009 20:20:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8FIKDmc025000;
	Tue, 15 Sep 2009 20:20:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128577>

Tim Visher <tim.visher@gmail.com> writes:

> I'm interested in hearing how people use Git for pair programming.
> Specifically, how do you document that you are programming in pairs.

[...]

> I did find Brian Helmkamp's script
> http://www.brynary.com/2008/9/1/setting-the-git-commit-author-to-pair-programmers-names
> but that's not really what I'm looking for. [...]

I'm not sure if this would help you, but take a look at "Pair
Programming & git & github & Gravatar & You & You" blog post by Jon
"Lark" Larkowski from May 30, 2009:

  http://blog.l4rk.com/2009/05/pair-programming-git-github-gravatar.html

-- 
Jakub Narebski
Poland
ShadeHawk on #git
