From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Library?
Date: Mon, 28 Apr 2008 14:08:16 -0700 (PDT)
Message-ID: <m3y76xofgm.fsf@localhost.localdomain>
References: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Altman <paltman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:09:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqabE-00033t-FY
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbYD1VIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935400AbYD1VIU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:08:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:7927 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934898AbYD1VIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:08:19 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1997846nfb.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=ltkkMCji8qaBtuUULoSQRpz/oVcjvZ1THfGHqXomdvc=;
        b=gOJXBRX4FAUBLpzgfA49REozRua6ss5gE8XKGiwqq6zk/R5hkK+3Q3yGK7iXw+AulCG1jFTllS0kb3AnXdba2bz8W/GrMzZ2s8sIRm3U04K/UjC5EVkjCCn5J0hQf0ncbIC/XPJVyvA+L3HGpzmYxi85g2UiHU3R2iltf897yvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=g8iRIlGBlSPJNzT/VkbWEuQMHGZYAubWaJ0xuDOuRzwWWmeeDeeZEWQlok/3CDbzh1/Nw8rXOeBh0O33s4lDB2EuL/o2o11uVVqXEhDA1xn0k18+GEF7qEIl92eNhPMwECYFJTROdiePAeq7FOIX49+HN/dH5o3nNdg+f+UpeOU=
Received: by 10.210.22.10 with SMTP id 10mr6297913ebv.37.1209416897223;
        Mon, 28 Apr 2008 14:08:17 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.217.96])
        by mx.google.com with ESMTPS id c25sm10371536ika.9.2008.04.28.14.08.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 14:08:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3SL8KBs026030;
	Mon, 28 Apr 2008 23:08:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3SL89jp026026;
	Mon, 28 Apr 2008 23:08:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80612>

Patrick Altman <paltman@gmail.com> writes:

> I want to write a Mac OSX UI for git.

Something like GitNub?
 
> Is there a documented/undocumented API for interacting with git in
> process?  Or would I be better off "shelling out" to the git command
> line?

Take a look how other GUIs does it.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
