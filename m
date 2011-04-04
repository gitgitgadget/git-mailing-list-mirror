From: Cyril Roelandt <tipecaml@gmail.com>
Subject: GSoC 2011 : one more interested student.
Date: Mon, 04 Apr 2011 02:38:16 +0200
Message-ID: <4D9912F8.60002@gmail.com>
Reply-To: tipecaml@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 02:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6XoF-0002U4-P8
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 02:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab1DDAiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 20:38:21 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64606 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab1DDAiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 20:38:20 -0400
Received: by wwa36 with SMTP id 36so5888967wwa.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 17:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:reply-to:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding;
        bh=raPsyjW7agKkdtfNlu7GO6z0KwVceY0GZEClaknxC5c=;
        b=RUULikltNijX9cLcS59g908BSjp1/9KyU32CQaDqHf+uXpud8gkMD9B/3UIyoouLMb
         wmLBtQZfVdceLBm9O4H8gkbdfmeblwF4TZXBgufLguRLrYSwTCD/2pz7phHOXcgMdPAY
         qTMtDFK6KHpMEB7UnwKDw/6MCBkAygVOdGM4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=IVvyyfJBg+GSmmGoicVE2oEnSDl8Vxor8QLWaj8yrAExy8QYOMEu+6q2BOzznGtkMt
         Z6rXQbIsTH/iLmkHEMDHwkHofD28hBUWoZZhvTe3xAYuRF7EA9MZWg1v0XeXkDNV0pvS
         xN0oZUOg01/M2ndUPFwF0BcFXT3HGjNOl+ulM=
Received: by 10.216.143.88 with SMTP id k66mr3603162wej.15.1301877499438;
        Sun, 03 Apr 2011 17:38:19 -0700 (PDT)
Received: from [192.168.0.10] (tal33-1-82-226-197-59.fbx.proxad.net [82.226.197.59])
        by mx.google.com with ESMTPS id g7sm2612671wby.48.2011.04.03.17.38.17
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 17:38:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170784>

Hi.

I am currently studying Computer Science and Engineering. I have been 
using Open Source software for quite a while now, but I have  not 
contributed a lot of code to Open Source projects - except for a few 
patches to Gnome.

Being a git user, I would be interested in working on this project. I 
believe that taking part in the GSoC would be a good opportunity for me 
to discover the guts of a version control system.

* Complete some libgit2 features
Implementing a few key features seems like a great way to understand the 
way a VCS works. I would be interesting in working on the diff command 
and on the network related commands (git-push, git-fetch).

* Build a minimal Git client based on libgit2
It seems to be a quite popular task :) Hacking on this small git client 
would be a nice experience and would help me understanding how libgit2 
works.

* Build in more external commands
I am wondering why these commands should be rewritten. You know what 
they say : "if it is not broken, do not fix it" :-p Do these commands 
currently have performance issues ?


I will be working in a research lab until the end of June, but I will 
have more free time in July/August, that I could use to hack on git, 
which means I may have less time than most US students, who can enjoy a 
slightly longer summer break. Do you think it would be possible to work 
one of these projects anyway ?

Best regards,
Cyril.
