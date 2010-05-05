From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 1
Date: Wed, 5 May 2010 14:59:41 +0200
Message-ID: <g2zf3271551005050559v2ea99346gcc59f941d634ce1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 05 15:02:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9eEo-0008Fk-Aa
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 15:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529Ab0EENAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 09:00:04 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:46419 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab0EENAD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 09:00:03 -0400
Received: by pzk42 with SMTP id 42so1370591pzk.4
        for <git@vger.kernel.org>; Wed, 05 May 2010 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=x/KnSDws0yXM6RSL84m9iyKVM0j1uhynRCSjtTrsl3Y=;
        b=vP8Rhxjj0aBui+uw1Hq7oVZguICj8vXckdbgV4nUxbLe1HlyhHRklzJuM0UwgprAkJ
         tT4RobNl46N7+CSZD5t+S2quLLO8xhqy/Zlmr8SWvlj8dsMDFuRCqUdI1KPmZShbxmK7
         8lVajw5Rjl1osY2o44xbLGlp9iXqcOf+3kZEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=PBqZcSS/vKMbrDgO7VtykusberEdcB7Ds5RGuCU7Cfn2BmDHhauW+Nukit2OuHYXMD
         IO1+Hvxr8iM72tNFzZaZbqqEQWOYiFV2if1jz0EjinWccOceaeZzFKLO4OP3hFbeN+iA
         Q2ytt6HHTmSoK7YYBTy77v5Vv30y8T8po61ng=
Received: by 10.142.195.20 with SMTP id s20mr1454478wff.248.1273064401192; 
	Wed, 05 May 2010 06:00:01 -0700 (PDT)
Received: by 10.142.254.21 with HTTP; Wed, 5 May 2010 05:59:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146390>

Hi,

I'm sorry that this comes a couple of days late owing to the fact that
I flew down the Copenhagen just a couple of days ago, and am coping
with the jetlag. I've just started working, and I'm currently
investigating David's SVN exporter. Hopefully, after I've moved into
an apartment, I'll have something concrete to show next week.

-- Ram
