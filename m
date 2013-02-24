From: Thomas Koch <thomas@koch.ro>
Subject: Re: Load testing of git
Date: Sun, 24 Feb 2013 17:58:16 +0100
Message-ID: <201302241758.18316.thomas@koch.ro>
References: <CAGjB8pR+uByiJJikBXbaxUZO4rDgyfvJ31agxaQuWrMwSS1N7Q@mail.gmail.com>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yuri Mikhailov <yuri.mikhaylov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 17:58:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9euY-0007RY-1Y
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496Ab3BXQ6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 11:58:23 -0500
Received: from koch.ro ([88.198.2.104]:43107 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757952Ab3BXQ6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 11:58:22 -0500
Received: from 123-16.2-85.cust.bluewin.ch ([85.2.16.123] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1U9eu4-0004cn-Aw; Sun, 24 Feb 2013 17:58:20 +0100
User-Agent: KMail/1.13.7 (Linux/3.7-trunk-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <CAGjB8pR+uByiJJikBXbaxUZO4rDgyfvJ31agxaQuWrMwSS1N7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216994>

Yuri Mikhailov:
> Dear Git community,
> 
> I am a Software Developer and I have been using git for a while.
> Currently my company is looking for a version control system to use
> and we find Git a good candidate for us. But what is important for us
> to know is scalability of this VCS. Does anyone performed load testing
> of Git? What is the practical maximum number of files and revisions
> this system can handle?
> 
> Best regards,
> Iurii Mykhailov

Have a look at the projects using Git[1]. There are for sure projects that 
exceeds the scalability you're thinking about. The linux Kernel might be the 
biggest project.

[1] https://git.wiki.kernel.org/index.php/GitProjects

Thomas Koch, http://www.koch.ro
