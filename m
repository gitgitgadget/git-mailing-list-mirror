From: Piet Delaney <piet.delaney@tensilica.com>
Subject: Editing Git Log
Date: Wed, 17 Sep 2008 22:52:52 -0700
Message-ID: <48D1ECB4.9080808@tensilica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Piet Delaney <piet.delaney@tensilica.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 07:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCSo-0005At-G4
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 07:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbYIRFwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 01:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbYIRFwz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 01:52:55 -0400
Received: from hq.tensilica.com ([65.205.227.29]:55316 "EHLO
	mailapp.tensilica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751580AbYIRFwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 01:52:54 -0400
Received: from localhost ([127.0.0.1])
	by mailapp.tensilica.com with esmtp (Exim 4.34)
	id 1KgCRh-0000qP-JN; Wed, 17 Sep 2008 22:52:53 -0700
Received: from mailapp.tensilica.com ([127.0.0.1])
	by localhost (mailapp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02985-02; Wed, 17 Sep 2008 22:52:53 -0700 (PDT)
Received: from pdelaney_fc5.hq.tensilica.com ([192.168.11.55])
	by mailapp.tensilica.com with esmtp (Exim 4.34)
	id 1KgCRh-0000qJ-2y; Wed, 17 Sep 2008 22:52:53 -0700
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at hq.tensilica.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96159>

I think I recall reading that a feature of git was the prevention of the 
git commits
from being changed. I noticed today that a couple of us have checked in 
files
without our customary [XTENSA] architecture prefixed to the 1st line of our
Commit Messages.

I couldn't find a way to do this, other than our reverting back to a 
earlier repository
and recommitting (each?) change with the slightly changed Commit Message;
not an attractive investment of our time.

Any suggestions?

-piet
