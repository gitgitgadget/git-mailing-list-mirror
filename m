From: Roald de Vries <rdv@roalddevries.nl>
Subject: clone
Date: Mon, 20 Jul 2009 16:33:51 +0200
Message-ID: <D229D90E-0294-475D-B7AC-6C7B23CC169A@roalddevries.nl>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 16:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MStx9-0006k4-1w
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 16:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbZGTOes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbZGTOer
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 10:34:47 -0400
Received: from platinum.liacs.nl ([132.229.131.22]:60601 "EHLO
	platinum.liacs.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZGTOer (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 10:34:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6KEYc35022125
	for <git@vger.kernel.org>; Mon, 20 Jul 2009 16:34:40 +0200
X-Virus-Scanned: amavisd-new at liacs.nl
Received: from platinum.liacs.nl ([127.0.0.1])
	by localhost (platinum.liacs.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m+o5LXdkWNZz for <git@vger.kernel.org>;
	Mon, 20 Jul 2009 16:34:25 +0200 (CEST)
Received: from prive147.liacs.nl (prive147.liacs.nl [132.229.16.147])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6KEXvKP022003
	for <git@vger.kernel.org>; Mon, 20 Jul 2009 16:33:58 +0200
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (platinum.liacs.nl [132.229.131.22]); Mon, 20 Jul 2009 16:33:59 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123605>

Dear all,

If I clone a repository with multiple branches to 'newdir', and then  
type 'git branch' in 'newdir', I see only 1 branch. 'git branch -r'  
gives me all branches. Is that correct behaviour? If so, why? And  
mainly: can I configure git to clone all original branches to non- 
remote branches?

Kind regards, Roald
