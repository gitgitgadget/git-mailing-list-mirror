From: Jerry Seutter <jerry.seutter@pason.com>
Subject: cg-init find error message on empty project directory
Date: Tue, 12 Jul 2005 22:47:43 -0600
Message-ID: <42D49CEF.9010909@pason.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 13 06:46:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsZ7p-0002TX-3k
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 06:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVGMEpO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 00:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVGMEpO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 00:45:14 -0400
Received: from hemlock.pason.com ([208.38.1.1]:45654 "EHLO
	exch-calgary.int.pason.com") by vger.kernel.org with ESMTP
	id S262566AbVGMEpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 00:45:12 -0400
Received: from [172.16.0.231] ([172.16.0.231]) by exch-calgary.int.pason.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 12 Jul 2005 22:45:12 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-OriginalArrivalTime: 13 Jul 2005 04:45:12.0158 (UTC) FILETIME=[A78057E0:01C58765]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When I run cg-init on an empty directory, it displays the following output:

$ cg-init
defaulting to local storage area
find: *: No such file or directory
Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed as d25f00309e336884854de8cab8ab9e819294bb83.

Is the find error message supposed to be displayed?

Jerry
