From: Sebastian Pipping <webmaster@hartwork.org>
Subject: "git clone --depth <depth>" producing history with <depth + 1> commits?
Date: Thu, 26 Mar 2009 18:00:00 +0100
Message-ID: <49CBB490.8040908@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 18:01:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmsxc-0007RC-2b
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 18:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757811AbZCZRAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 13:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756945AbZCZRAE
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 13:00:04 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:34309 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbZCZRAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 13:00:03 -0400
Received: from [85.179.3.0] (helo=[192.168.0.3])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Lmsvw-00061D-Nf
	for git@vger.kernel.org; Thu, 26 Mar 2009 18:00:00 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20090216)
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114804>

Hello!


Is "git clone --depth 1 <ropository>" expected to give a history
with 2 commits?  "--depth 2" gives 3 commits, "--depth 0" all.

Is that by design or a bug?



Sebastian
