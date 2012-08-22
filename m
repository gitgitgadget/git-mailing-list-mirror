From: Lanoxx <lanoxx@gmx.net>
Subject: Git to use XDG Base Directory Standard
Date: Wed, 22 Aug 2012 23:33:56 +0200
Message-ID: <50355044.7040201@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 23:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4IYw-0002XF-Bz
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180Ab2HVVeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:34:01 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:47738 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756631Ab2HVVd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:33:59 -0400
Received: (qmail invoked by alias); 22 Aug 2012 21:33:57 -0000
Received: from chello084112131062.3.11.vie.surfer.at (EHLO [192.168.0.22]) [84.112.131.62]
  by mail.gmx.net (mp033) with SMTP; 22 Aug 2012 23:33:57 +0200
X-Authenticated: #2691801
X-Provags-ID: V01U2FsdGVkX19ZtWZ4qJRZNW47woY0VYOGDbHKFlxr6DSQMFQcSh
	5GQETPQttCRcT/
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204101>

Hi,

Git and Gitk are currently using the ~/.gitconfig and ~/.gitk files in 
the $HOME directory. It would be nice to use the XDG Base Directory 
standard for the location instead, see [1] and [2]. Are there any plans 
regarding this standard?

Best Regards
Lanoxx

[1] http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
[2] https://live.gnome.org/GnomeGoals/XDGConfigFolders
