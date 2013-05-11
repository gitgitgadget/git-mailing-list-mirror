From: Sebastian Staudt <koraktor@gmail.com>
Subject: [ANN] Mestral =?utf-8?B?4oCTIEhvbw==?= =?utf-8?Q?k?= management for
 Git
Date: Sat, 11 May 2013 21:16:06 +0200
Message-ID: <20130511191606.GA41792@mormegil.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 21:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbFHE-0005Iv-DW
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 21:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab3EKTQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 15:16:11 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:40213 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab3EKTQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 15:16:10 -0400
Received: by mail-ee0-f45.google.com with SMTP id l10so1068681eei.4
        for <git@vger.kernel.org>; Sat, 11 May 2013 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=8uSnTZ/8aNJV051S4EAs62Wyt9qym4dkljfOxoviIRk=;
        b=G7ffvlbTonFOMJPXSSiVGYr19cfnNsNFZu2jnAqnLk9JJMOAMOFsItq37DVN9N7nDD
         yA+11nvtjAgk1eDbNWtoPq8Z85dGBcqWqSay+BABUKgQotSOZsf88iMPC/z0Tig8+MhU
         pBB/7qvcddWlBqpNH8QXCcTQ8J5FlCIU3J+qeiDaFYufyK7XnsdRxrcpoGcpOKHWYJ4W
         CO2xgQf8IeGV87ei2Eio+In0zVphsrGTiWtZ9HaJgmctlg4XK68CSyKg1bUlfAQMpdhH
         EGn9wYXuc4KDhkztGPVPVBInJcV9JYmHzUJj5dB7tpu23TjDs466XDnzFja7IoxxhAZa
         24Nw==
X-Received: by 10.14.181.131 with SMTP id l3mr9493275eem.16.1368299769126;
        Sat, 11 May 2013 12:16:09 -0700 (PDT)
Received: from mormegil.local (88-134-170-217-dynip.superkabel.de. [88.134.170.217])
        by mx.google.com with ESMTPSA id e50sm11647674eev.13.2013.05.11.12.16.08
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 12:16:08 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224003>

Hi,

today I'd like to introduce a new tool to manage Git hooks. It's called Mestral
and is available at GitHub: https://github.com/mestral/mestral

It is written in Ruby and inspired by Homebrew (http://brew.sh). It uses Git
itself to load and update hooks and aims to be easy to use for both users and
hook authors.

Currently, it's an early proof of concept and I'm looking for some early
adopters who want to try it, give valuable feedback and maybe contribute to the
development. That means any feedback is appreciated, may it be a short tweet to
@k0raktor, a reply to this mail, an issue on GitHub or a pull request.

Best regards,
    Sebastian
