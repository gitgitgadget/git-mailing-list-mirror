From: Manuel Doninger <manuel@doninger.net>
Subject: Gitweb: Show git clone url on projects list
Date: Thu, 7 Oct 2010 10:47:03 +0200
Message-ID: <AANLkTimGhR_64CDKuN0x4Lk6Ve8rr7BAOCL1uGUkQv6v@mail.gmail.com>
References: <AANLkTi=5P1OiKprOifyu2xuFjVToL5kE9dXrEr3gSr+_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 10:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3m8T-0001Va-5v
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 10:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760188Ab0JGIr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 04:47:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35506 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab0JGIrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 04:47:25 -0400
Received: by iwn9 with SMTP id 9so563148iwn.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 01:47:25 -0700 (PDT)
Received: by 10.231.148.20 with SMTP id n20mr471771ibv.196.1286441244160; Thu,
 07 Oct 2010 01:47:24 -0700 (PDT)
Received: by 10.231.17.71 with HTTP; Thu, 7 Oct 2010 01:47:03 -0700 (PDT)
In-Reply-To: <AANLkTi=5P1OiKprOifyu2xuFjVToL5kE9dXrEr3gSr+_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158387>

Hi,
i installed gitweb on my server, and it works great.
In gitweb.conf i defined @git_base_url_list, an on every projects
status page the clone url is shown.
But i want also the clone url shown on the projects list, like on
http://git.kernel.org/ (the "git" link on the right border of every
line).
How can i do this (i use git 1.7.3)?

Regards,
Manuel Doninger
