From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: problems installing GIT on my MAC OS X 10.11.5
Date: Tue, 14 Jun 2016 20:12:29 +0300
Message-ID: <20160614201229.9f2d11897b921458d895b6cd@domain007.com>
References: <1F59C8B7-AF53-4C84-9428-5A4AB80DB295@gmail.com>
	<20160614190641.0d0ba5344e52304e16ca4f52@domain007.com>
	<f4c72626-1bd5-0b26-a18a-49feed67a742@web.de>
	<E9D8E5F7-BBD1-4384-A6D6-B9184AEDE881@gmail.com>
	<e88e33b0-5443-0517-370e-5b0b76a4df5b@web.de>
	<ADD00034-0B8C-4CBA-87C9-E3F50AA408A2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Torsten =?UTF-8?B?QsO2Z2Vyc2hhdXNlbg==?= <tboegi@web.de>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	git@vger.kernel.org
To: Maria Jose Fernandez <mjose.fernandezj@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 19:12:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCrtG-00087s-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 19:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbcFNRMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 13:12:34 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:34988 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbcFNRMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 13:12:34 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4) with SMTP id u5EHCT7K016768;
	Tue, 14 Jun 2016 20:12:30 +0300
In-Reply-To: <ADD00034-0B8C-4CBA-87C9-E3F50AA408A2@gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297309>

On Tue, 14 Jun 2016 17:49:50 +0100
Maria Jose Fernandez <mjose.fernandezj@gmail.com> wrote:

> I am very sorry but I am not understanding what you are saying. 
> I will try with homebrew and see if it works that way.

Torstean means:

1. Using the Finder, locate the Terminal application and run it.
   An open with command prompt (the "$" character) will appear.

2. Type there, literally:

     git --version

   and hit the Enter key.

   See whether it errors out at you -- something like

     bash: git: command not found

   or the version of the installed Git program will be printed,
   like in

     git version 2.9.0

   (yours might be different but that doesn't matter).

Whatever the outcome is, select that text and paste it into the message
you're composing to send here.

[...]
> > Do you think that you open a terminal and type
> > which git
> > git --version
> > and post the output here ?
