From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: git-svn and svn sw --relocate
Date: Sun, 02 Apr 2006 20:04:46 +0200
Message-ID: <4430123E.5090605@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 02 20:06:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ6xj-0001jR-5e
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 20:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWDBSGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 14:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWDBSGE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 14:06:04 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:16396 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S932407AbWDBSGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 14:06:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 49D473F73
	for <git@vger.kernel.org>; Sun,  2 Apr 2006 20:06:01 +0200 (CEST)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30564-07 for <git@vger.kernel.org>;
	Sun, 2 Apr 2006 20:06:00 +0200 (CEST)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 50D883E92
	for <git@vger.kernel.org>; Sun,  2 Apr 2006 20:05:57 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18274>

ok, guys... next question:

i have now my repository locally and i want to get it remotely on a
server, in order to have a few collaborators...

the steps on the svn-side are clear. But what do i have todo on the
git-svn-side of this life?

does a simple "svn sw --relocate" do the job in the git-svn meta-dir?

Sincerly
Nicolas
