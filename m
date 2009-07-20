From: Roald de Vries <rdv@roalddevries.nl>
Subject: local configuration
Date: Mon, 20 Jul 2009 12:54:44 +0200
Message-ID: <33BF73EE-79AB-435F-B35F-E848DD1F3BF3@roalddevries.nl>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 13:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSqmF-0005GW-EN
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 13:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbZGTLLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 07:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbZGTLLP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 07:11:15 -0400
Received: from platinum.liacs.nl ([132.229.131.22]:58953 "EHLO
	platinum.liacs.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbZGTLLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 07:11:14 -0400
X-Greylist: delayed 945 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2009 07:11:14 EDT
Received: from localhost (localhost [127.0.0.1])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6KAtMSY011166
	for <git@vger.kernel.org>; Mon, 20 Jul 2009 12:55:24 +0200
X-Virus-Scanned: amavisd-new at liacs.nl
Received: from platinum.liacs.nl ([127.0.0.1])
	by localhost (platinum.liacs.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id trXG9hgdGxyt for <git@vger.kernel.org>;
	Mon, 20 Jul 2009 12:55:07 +0200 (CEST)
Received: from prive147.liacs.nl (prive147.liacs.nl [132.229.16.147])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6KAso90011081
	for <git@vger.kernel.org>; Mon, 20 Jul 2009 12:54:52 +0200
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (platinum.liacs.nl [132.229.131.22]); Mon, 20 Jul 2009 12:54:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123585>

Hi all,

I want to use git to synchronize my bashrc's (and other configuration  
files) between computers. These have common stuff in them, and stuff  
that's specific to a certain computer. The way I do it now is with a  
branch for each computer, and one common branch. Is this a known use  
case, am I misusing git, and is there a more elegant way to do this?

Thanks in advance for replies, kind regards, Roald
