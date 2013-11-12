From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
Subject: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Tue, 12 Nov 2013 12:02:38 +0400
Message-ID: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 09:02:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg8vr-0004Mz-I0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 09:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab3KLICk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 03:02:40 -0500
Received: from mail-ve0-f177.google.com ([209.85.128.177]:56920 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab3KLICj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 03:02:39 -0500
Received: by mail-ve0-f177.google.com with SMTP id jz11so2883687veb.22
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 00:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=9te8PQrneW9p4/2Ttx6mF2Gzfj/iKZGQtxu7Bbglmvc=;
        b=KR6ByfzV1zfL1onv0iepp726S/oVDXBU3RbPhMJ97CE8YDM4chxygsqfKRWBu6XbcL
         kxKrqBff3BlpkRm709Bh7TYj063R/GTt4LYIZxa9jgOWwd6EFfd+psoGRdpfxSLf4sMd
         fOgYo3hT0upzJ4dt9G77DVBLZwsJYrl0P8cytIJI/hJyZYdQ36YaCRT1QIqz5vDIQJ5h
         vWPBzR8nNtSAylZ/PkmjgTlal++WmwlkQNjwT+LoW6u/MBHdv7al+Utmr+w68wYvD7zg
         5agJ1/gk5zUMfvxnFSNAcwGlTpmqRUQwAX+FyGTvN3stj6A5SjIxtuCzjiz2QvRQD8Id
         q7oQ==
X-Received: by 10.52.30.104 with SMTP id r8mr19605150vdh.18.1384243358304;
 Tue, 12 Nov 2013 00:02:38 -0800 (PST)
Received: by 10.58.109.71 with HTTP; Tue, 12 Nov 2013 00:02:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237703>

I get this error message every time I want to do a `git push`.
git version: 1.8.4.2

Is it a known issue? Do you need additional info to investigate it?

Ivan.
