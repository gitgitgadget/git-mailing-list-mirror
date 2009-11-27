From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: gitk: how to display history w/o a certain remote?
Date: Fri, 27 Nov 2009 20:52:20 +0100
Message-ID: <4B102DF4.9010303@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 20:56:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE6vL-0005sc-CK
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 20:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbZK0Tzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 14:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZK0Tzv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 14:55:51 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:49824 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbZK0Tzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 14:55:51 -0500
Received: from [84.176.92.94] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1NE6re-0007wO-HT
	for git@vger.kernel.org; Fri, 27 Nov 2009 20:52:22 +0100
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133927>

Hi list,

next to those cute little spherules, gitk shows the labels of the
corresponding tags and branches, e.g. "master", "remotes/XXX/master",
and "remotes/YYY/master". Most of the time, I like that. :-)

"git log [...] --decorate" does it alike.

Sometimes I have many remotes and the actual commit message is far
beyond my screen because of the many labels.

Is there a way to prevent gitk/git-log from displaying certain remotes?

I tried the "--not" switch but that didn't work. At least for my arguments.

AHA,
     Dirk
