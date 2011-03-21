From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Meaning of double + and - in Gitk's diff pane
Date: Mon, 21 Mar 2011 19:38:29 +0100
Message-ID: <4D879B25.9090300@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1k01-0007V3-Az
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1CUSig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:38:36 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:57153 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab1CUSif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:38:35 -0400
Received: from [84.176.60.154] (helo=[192.168.2.100])
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Q1jzr-000896-R6
	for git@vger.kernel.org; Mon, 21 Mar 2011 19:38:31 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169637>

Hello,

I regularly use gitk to get an overview. Great tool.
But sometimes it shows me in the diff pane lines preceeded
with two + or - signs or they are colored in blue or black
or printed in bold. I think this is true for merge commits
with conflicts.

The simple red - and green + lines are obvious, but is
anywhere documented what exactly the other fonts and colors
mean? I tried to "Ask The Audience" (which is Google), but
try searching for plus and minus! It's pointless.

Dirk
