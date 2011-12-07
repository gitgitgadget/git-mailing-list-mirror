From: Thomas Koch <thomas@koch.ro>
Subject: Re: How to make devs write better commit messages
Date: Wed, 7 Dec 2011 08:06:09 +0100
Message-ID: <201112070806.09539.thomas@koch.ro>
References: <CAOJsP-X0ZWT5HLHcBc2FmhoMpWFOvEFADiM9jGZ9R1ctqHDJ9w@mail.gmail.com>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joseph Huttner <huttnified@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 08:37:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYC4A-0005rQ-70
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 08:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab1LGHhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 02:37:15 -0500
Received: from koch.ro ([88.198.2.104]:58917 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab1LGHhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 02:37:14 -0500
X-Greylist: delayed 1852 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Dec 2011 02:37:14 EST
Received: from 94-155.76-83.cust.bluewin.ch ([83.76.155.94] helo=t61.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <thomas@koch.ro>)
	id 1RYBa7-0004RN-HO; Wed, 07 Dec 2011 08:06:19 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-1-amd64; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CAOJsP-X0ZWT5HLHcBc2FmhoMpWFOvEFADiM9jGZ9R1ctqHDJ9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186436>

Joseph Huttner:
> The bottom line is that good commit messages are really important, so
> we should make it as easy as possible for developers to go ahead and
> write a perfect commit message every time they commit code.

I recently started to work with the code review system Gerrit[1]. First I did 
not pay attention to it, but later I was amazed that the commit message can 
(and should) be reviewed just like the code changes.

So if you're using a code review prozess (you should!) then also include the 
commit message in the review.

[1] http://en.wikipedia.org/wiki/Gerrit_%28software%29

Thomas Koch, http://www.koch.ro
