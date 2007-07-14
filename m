From: Nikodemus Siivola <nikodemus@random-state.net>
Subject: Restoring files from old commits
Date: Sat, 14 Jul 2007 15:09:59 +0300
Message-ID: <4698BD17.5080205@random-state.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 14:31:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9gmN-00087I-Se
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 14:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752AbXGNMbC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 08:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757732AbXGNMbB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 08:31:01 -0400
Received: from smtp5.pp.htv.fi ([213.243.153.39]:52650 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757710AbXGNMbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 08:31:00 -0400
X-Greylist: delayed 1257 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jul 2007 08:31:00 EDT
Received: from manic.local (cs181229041.pp.htv.fi [82.181.229.41])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 714255BC186
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 15:10:02 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52474>

What is the recommended way to restore individual files
(or directories) in the working tree to the content they
had in a given commit?

That is to say, now that Cogito is deprecated, what should
I use instead of cg-restore?

Cheers,

  -- Nikodemus
