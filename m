From: Michael Cohen <michaeljosephcohen@mac.com>
Subject: [RFC PATCH] OSX Mail.app IMAP cache support for git-mailsplit?
Date: Mon, 05 Nov 2007 01:36:11 -0500
Message-ID: <7B209F05-B720-41D6-AE98-39FAFF04B9F6@mac.com>
References: <06FE21A2-20D0-4AAA-B0C7-35783C604B68@mac.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: "Michael J. Cohen" <michaeljosephcohen@mac.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 07:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iovb6-0005jt-Du
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 07:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbXKEGhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 01:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbXKEGhx
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 01:37:53 -0500
Received: from smtpoutm.mac.com ([17.148.16.67]:64345 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbXKEGhx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 01:37:53 -0500
Received: from mac.com (asmtp002-s [10.150.69.65])
	by smtpoutm.mac.com (Xserve/smtpout004/MantshX 4.0) with ESMTP id lA56bqII020261
	for <git@vger.kernel.org>; Sun, 4 Nov 2007 22:37:52 -0800 (PST)
Received: from [192.168.1.109] (c-71-196-112-35.hsd1.fl.comcast.net [71.196.112.35])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp002/MantshX 4.0) with ESMTP id lA56boW4009293
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sun, 4 Nov 2007 22:37:51 -0800 (PST)
In-Reply-To: <06FE21A2-20D0-4AAA-B0C7-35783C604B68@mac.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63487>

On Nov 4, 2007, at 1:49 AM, Michael J. Cohen wrote:

> Trivially, adding support for checking for Messages/ inside the  
> specified Maildir after cur/ is found not to exist would be enough  
> to make this work.

my repo at git://home.325i.org/git-osxmail.git should have that portion.

unsure as to whether to make it an option, a fallback, a config value,  
or whatever...

-mjc
