From: "Neshama Parhoti" <pneshama@gmail.com>
Subject: Project Hosting with git ?
Date: Sat, 12 Jan 2008 15:53:44 +0200
Message-ID: <912ec82a0801120553u3621c991u7c4cb4793960159c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 14:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDgoQ-0006TJ-99
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 14:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759404AbYALNxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 08:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYALNxq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 08:53:46 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:42233 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbYALNxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 08:53:45 -0500
Received: by an-out-0708.google.com with SMTP id d31so317306and.103
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 05:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=U7Ql5P7GnAToBhwDR3ujZAZdBP8uoR9qk9YpnemIeCY=;
        b=S5lrZYf1C50KH4e1h4IlX1bMi3r41Be4L37OfdVtk5UJEMWqcvDZUuu8c6elC3RzW6m8U4wjaZewQ1/I/5BxG+YlWc4/pQpe25B39yy/uwGtbJPU253tgjt6GCi2fAxT0dk9AGnmUrQywHRPCLGJN+TGKwMXPQ2dD0qXvJF2OK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iy+7MpAhtglMl0WajZYu3v8/qyI9TBV6acIQ9Rl5upj428DrSM8GcEIN7yR88eZ5tcohhdW2b1PIrIITNMAkFWJhCTL1BRoU5A/6u3JN82sHBYYAjkplBZYwA116azHoIkFe9gVPDeYe4wNt0Qng44oRuQQ5trAI1cgA+xp48/s=
Received: by 10.100.216.3 with SMTP id o3mr9344679ang.95.1200146024651;
        Sat, 12 Jan 2008 05:53:44 -0800 (PST)
Received: by 10.100.131.14 with HTTP; Sat, 12 Jan 2008 05:53:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70316>

Hello,

I am beginning a new Open Source project which I would
like to manage with git.

I was wondering how is it possible with current hosting
solutions ?

I mean, if I open a SourceForge project, I have to use cvs/subversion right ?

Is there any way to use git ?

Of course I can pay for a VPS and install my own git server
but that would be a bit expensive.

Any ideas ?

How are the current git-using projects hosted (besides kernel.org...) ?

thank you very much
neshama
