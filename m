From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: GIT on MinGW, with tcltk for gitk
Date: Sun, 27 May 2007 18:55:20 -0300
Message-ID: <f329bf540705271455m4c0f5a55v14b9a8cc6bd7778d@mail.gmail.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
	 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
	 <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org>
	 <00a601c7a09f$218c1020$0200a8c0@AMD2500> <4659F5D0.2070406@xs4all.nl>
	 <00b901c7a0a5$77983420$0200a8c0@AMD2500>
	 <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Aaron Gray" <angray@beeb.net>
X-From: git-owner@vger.kernel.org Sun May 27 23:55:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsQi0-0007WZ-5H
	for gcvg-git@gmane.org; Sun, 27 May 2007 23:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466AbXE0VzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 17:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbXE0VzW
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 17:55:22 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:28970 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbXE0VzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 17:55:21 -0400
Received: by an-out-0708.google.com with SMTP id d31so361487and
        for <git@vger.kernel.org>; Sun, 27 May 2007 14:55:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JULhIybUBz1gh9/bSWPSjJhDiO0YJw0EfU2/0B82shhXZEdLz9N6GhIyGjfANLgsOU6PH8ibaqo7RdtLA+QHmYqSmZ4PmquGJJX/wReTf4ykD8IsZ1Dz4lCcPaoZnL9G7Gh0c1YUxeJqpD7AwBJqPBYQsnmRaNOg7XuHz2LwrKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N08LPqrPtE94hJiQ+4xddwhluTjrzrwf3d5W+BRCa7TAvyY3X+p4exVsvkgZ4qKzE2ktQv0CEfybyVIh+yZhiR6ZYY8HIt3I59UGMnjTgog9ZJytec4YZ5GVOsNx8XP+7Gfp3Cm23uyYsZiF6Pkg87glBAMckGsVD16CUg9/VO8=
Received: by 10.101.71.16 with SMTP id y16mr4144658ank.1180302920116;
        Sun, 27 May 2007 14:55:20 -0700 (PDT)
Received: by 10.100.94.14 with HTTP; Sun, 27 May 2007 14:55:20 -0700 (PDT)
In-Reply-To: <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48586>

2007/5/27, Aaron Gray <angray@beeb.net>:

> '"C:\Program Files\Git\usr\bin\wish.exe"' is not recognized as an internal
> or external command, operable program or batch file.
>
> Theres a file called 'wish84.exe' under 'C:\Program Files\Git\usr\bin', but
> no wish.exe.

can you edit this .bat to say wish84.exe iso. wish.exe ?

thnks,

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
