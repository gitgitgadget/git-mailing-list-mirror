From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 22:21:59 +0200
Message-ID: <4d8e3fd30606221321u4e27cf56le3bf60e07a8c4527@mail.gmail.com>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 22:22:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtVgm-0003VA-99
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 22:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWFVUWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 16:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWFVUWE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 16:22:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:25810 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030396AbWFVUWB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 16:22:01 -0400
Received: by ug-out-1314.google.com with SMTP id a2so683737ugf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 13:22:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LBQ5TgFQI5vSZ1YDiF12+GTJr6O+q045UKgInWumRjY+g6VxEPMLY2fr/w5LMqkceD9yygYXhdEWACMcIrKl2c0v17cei+blzFGR8mExS/kryz67chctiKvGCcueVfrpzPG57JMYUz1sDj1BgvBImjd9oqB56cJ2BHJW7vbxMzk=
Received: by 10.78.151.15 with SMTP id y15mr835393hud;
        Thu, 22 Jun 2006 13:22:00 -0700 (PDT)
Received: by 10.78.121.12 with HTTP; Thu, 22 Jun 2006 13:21:59 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22367>

On 6/22/06, Junio C Hamano <junkio@cox.net> wrote:
> I've merged quite a bit of stuff and tagged the tip of "master"
> as GIT 1.4.1-rc1.


Pulled and installed.

When I fire up gitk I see the following error messages, even if gitk
seems to be working fine:
paolo@Italia:~/git$ gitk
invalid command name ".ctop.cdet.left.ctext"
    while executing
"$ctext conf -state normal"
    (procedure "dispneartags" line 7)
    invoked from within
"dispneartags"
    (procedure "restartatags" line 28)
    invoked from within
"restartatags 869"
    ("after" script)


-- 
Paolo
http://paolociarrocchi.googlepages.com
http://picasaweb.google.com/paolo.ciarrocchi
