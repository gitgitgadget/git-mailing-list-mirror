From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: How to create empty CENTRAL  git with master / development branch ?
Date: Tue, 3 Apr 2012 16:23:52 +0530
Message-ID: <20120403162352.67cb165e@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 12:54:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF1NM-0006v5-12
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 12:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab2DCKyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 06:54:07 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:38307
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752194Ab2DCKyG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 06:54:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 315DBDA0E0D
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 12:54:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IlCmy1R3DN6W for <git@vger.kernel.org>;
	Tue,  3 Apr 2012 12:54:03 +0200 (CEST)
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id D060CDA0D94
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 12:54:02 +0200 (CEST)
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194612>

Dear list,

I need to create git repos on a remote server by the command executed on that server
through ssh as

` ` ` ` `
git --bare init project_name.git

` ` ` ` `

How can I also add the master branch, so that users don't need to
execute  [ git push origin master ]  ?

Thanks
