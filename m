From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Jabber, question on push,pull and --tags, and no help but jabber
Date: Mon, 6 Jun 2011 15:02:05 +0200
Message-ID: <20110606130205.GA41674@sherwood.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 15:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTZRj-0002eG-QI
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 15:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab1FFNCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 09:02:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62819 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab1FFNCN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 09:02:13 -0400
Received: by bwz15 with SMTP id 15so3273265bwz.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=av54I1YrQaSdcGEEE+5SwozMS3ZTUSrpB/350xpsDu0=;
        b=rGKYQHuVCEVPDbb1c2t13AJGZMPQavGoxE5O+80515uODzmYVNzsjfxlmYyr5r8jXc
         nO79QbPe5YzBHHyfUOQEJ2F7cuZZIZbgyP+2G6QPtv9nbUU+Kg0wCg3gNJJ4QNY/EJgB
         twF+vqVCi98BLy/DbIupOegOrDT8N/zACSOCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=mrDHwoEf/3GDCEIfepOLZdmJ/oHbZEj++L2u2DLG1Wrs5YgDO/qwJEfymD5pliBSaX
         IQKf0GG+cTdr7xMyCw7hWl987fcbsiLhQZ50uMQg6VwzdGzPZ0PZaqS7yEguRatJ+ZpS
         KsdnAV0vKQgnH8S0XIezF+jTc8pOY2+wrAcoY=
Received: by 10.204.35.206 with SMTP id q14mr4657583bkd.128.1307365332385;
        Mon, 06 Jun 2011 06:02:12 -0700 (PDT)
Received: from sherwood.local ([89.204.153.203])
        by mx.google.com with ESMTPS id k10sm3328541bkq.22.2011.06.06.06.02.10
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 06:02:11 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175120>

Hello GIT,
    first paragraph is reserved for praising your existence.
    'Used cvs(1) for long years in small team projects with local
    private repos and never felt the need for anything else.  2011
    is different.  I first tried you but failed resoundingly.  Due
    to vim(1) and mutt(1) i discovered hg(1) and i still love it's
    simple usage.  'Talking about the front-end anyway.  It's huge
    memory consumption and slow performance forbids it's usage on
    our old PCs (e.g. Cyrix 166+) though.  So i came back and
    found you still receptive!  And the more i work, the less
    i hurt, the greater the knowledge, the smoother the
    interaction.  Are you the final word on RC in the end?

I stumbled over one thing i don't understand, because it seems
illogical: why do i need to use --tags to force pushing of tags?
Because there is even a config option for the latter, i suspect
this is because of intention.  It would be nice to get some
information on the background of that, like a link to yet existing
documentation.  Anyway i was a bit astonished to look at some
heavily scripted page of my free private repo webhoster :-) and
don't see any tags, even though i've pushed multiple times and
v0.0.0 was created directly after the first commit.  I would *not*
have detected that otherwise ...
(Yes i know it's somewhat implied by 'git help push'..--tags.
But i'm blonde.)

Some more i'll pack into this so that it's gone with the wind:

- Due to my weak GPRS or noisy HDSPA radio connection here in the
  pampa :) i hope for continuable network actions - failing after
  98% is a costly pain.  So it was a real joy to read somewhere
  that a GSOC project will address this issue!!
- OpenSSL support for signing.  I don't use PGP/GPG.  But i use
  HTTPS, POPS, SSH etc., so i'll have an OpenSSL/OpenSSH
  environment here on my box ready to use.

Thanks for GIT!
--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
