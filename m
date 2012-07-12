From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: How can I append authentication with "git push" ?
Date: Thu, 12 Jul 2012 13:48:44 +0530
Message-ID: <20120712134844.2d1c4378@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 10:19:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpEbz-0006km-K2
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 10:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275Ab2GLISx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 04:18:53 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:39278
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753015Ab2GLISw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2012 04:18:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 16E97CFFC97
	for <git@vger.kernel.org>; Thu, 12 Jul 2012 10:18:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 38UfZJF3KGco for <git@vger.kernel.org>;
	Thu, 12 Jul 2012 10:18:50 +0200 (CEST)
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 4D356CFFC8F
	for <git@vger.kernel.org>; Thu, 12 Jul 2012 10:18:48 +0200 (CEST)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201351>


Dear list,

Is there any option to add user-name and password with git push ?
Or any repo wise configuration file where I can save the info, so that
it doesn't ask the credential before every push ?

Thanks
