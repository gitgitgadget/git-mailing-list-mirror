From: Thomas Koch <thomas@koch.ro>
Subject: Re: git ignore logic does not work as advertised
Date: Sun, 16 Jun 2013 10:58:50 +0200
Message-ID: <2750100.i86W7SrYHs@x121e>
References: <1766682.Es1SNxTkk2@x121e> <20130615170759.GH23890@serenity.lan>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 16 10:59:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo8nr-0006zv-0M
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 10:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030Ab3FPI6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 04:58:55 -0400
Received: from koch.ro ([88.198.2.104]:48141 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754896Ab3FPI6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 04:58:55 -0400
Received: from 44-25.106-92.cust.bluewin.ch ([92.106.25.44] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1Uo8nU-0002N0-Mz; Sun, 16 Jun 2013 10:58:52 +0200
User-Agent: KMail/4.10.4 (Linux/3.9-1-amd64; KDE/4.10.2; x86_64; ; )
In-Reply-To: <20130615170759.GH23890@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228001>

On Saturday, June 15, 2013 06:07:59 PM John Keeping wrote:
> Which version of Git are you using?  You may be hitting a regression
> that was introduced in Git 1.8.3 and is fixed in Git 1.8.3.1.
updated from 1.8.3 to 1.8.3.1 and solved. Thank you.

Thomas Koch, http://www.koch.ro
