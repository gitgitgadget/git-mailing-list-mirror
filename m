From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Before svn2git you want to run: svneverever
Date: Tue, 30 Mar 2010 02:15:03 -0700 (PDT)
Message-ID: <m3r5n2i32q.fsf@localhost.localdomain>
References: <4BB155B0.9020502@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 11:16:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwXYH-0006PN-BY
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 11:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab0C3JPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 05:15:11 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:39928 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab0C3JPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 05:15:07 -0400
Received: by bwz1 with SMTP id 1so4188834bwz.21
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=q5uqPyE7Tj8HSA3fHpmOzu9LQidzc1bczzpMN6a+u3A=;
        b=DZtEqdTqwqlSKkRmKk4SoYMHTkrc6vQ5akfDKbCCsuXjGXGU5DYazzyOVFHJKk+0Ep
         JEKUqkxYjeZyMlhAc9jvNlKkqsi76yJaKfXP5TIteu+GkNwN5ZdqovOYBzPdiR/yUxOx
         YHuxb+suIeTx8e2zL5jECtL9K2JK6Ilm2SkfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=j6ROu5t6JZvSpdxHEWYp3HfvWDwBpOEgsrfCG1+1vUdUUoytgWtJnB/B4K+9f/X1C0
         krUG1Mop0jobqkKJjxw+ZCnabBJg6BYjPIm0JQv27bktaDHOo9PkQYm4Be/IFfNCMXE+
         hZFn3PglKJMDhg73pjvMlFjzQKQMXnUoIXh9g=
Received: by 10.204.6.70 with SMTP id 6mr930613bky.6.1269940504689;
        Tue, 30 Mar 2010 02:15:04 -0700 (PDT)
Received: from localhost.localdomain (abvx12.neoplus.adsl.tpnet.pl [83.8.221.12])
        by mx.google.com with ESMTPS id 16sm2631179bwz.5.2010.03.30.02.15.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 02:15:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2U9Ea7v007213;
	Tue, 30 Mar 2010 11:14:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2U9EL4D007200;
	Tue, 30 Mar 2010 11:14:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BB155B0.9020502@hartwork.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143560>

Sebastian Pipping <webmaster@hartwork.org> writes:

> I have written a tool called svneverever [1] to aid conversion of SVN
> repositories to Git done by on KDE's svn2git [2].
> 
> The blog post introducing it in detail is up at
> <http://blog.hartwork.org/?p=763>.
> 
> 
> If you work with svn2git it's worth a check-out for you.

> [1] http://git.goodpoint.de/?p=svneverever.git;a=summary
> [2] http://gitorious.org/svn2git/svn2git

Could you add (short) information about this tool to the wiki at
http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

-- 
Jakub Narebski
Poland
ShadeHawk on #git
