From: SASh-4 <alexiev@gmail.com>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Thu, 4 Feb 2010 03:44:44 -0800 (PST)
Message-ID: <1265283884656-4512970.post@n2.nabble.com>
References: <823128.71540.qm@web37902.mail.mud.yahoo.com> <832452.93473.qm@web37901.mail.mud.yahoo.com> <810496.66936.qm@web37903.mail.mud.yahoo.com> <31942.12221.qm@web37902.mail.mud.yahoo.com> <alpine.LFD.2.00.0811190740200.18283@nehalem.linux-foundation.org> <86367.3986.qm@web37907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 12:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd08g-0005aQ-VT
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 12:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757025Ab0BDLop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 06:44:45 -0500
Received: from kuber.nabble.com ([216.139.236.158]:35879 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407Ab0BDLop (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 06:44:45 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <alexiev@gmail.com>)
	id 1Nd08a-0002hY-LO
	for git@vger.kernel.org; Thu, 04 Feb 2010 03:44:44 -0800
In-Reply-To: <86367.3986.qm@web37907.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138963>


I had the same problem. Turned out that the user.name must also match the one
in the gpg! Hope this helps!
-- 
View this message in context: http://n2.nabble.com/secret-key-not-available-unable-to-sign-the-tag-tp1500685p4512970.html
Sent from the git mailing list archive at Nabble.com.
