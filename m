From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Problems pushing???
Date: Sun, 08 Jul 2012 13:52:03 +0200
Message-ID: <4FF97463.90002@ira.uka.de>
References: <1341738766823-7562695.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pbGit <pblakeley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 14:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnqKY-0002Fk-JK
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 14:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab2GHMLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 08:11:08 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39051 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750798Ab2GHMLH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jul 2012 08:11:07 -0400
X-Greylist: delayed 1128 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Jul 2012 08:11:07 EDT
Received: from dslb-088-066-042-202.pools.arcor-ip.net ([88.66.42.202] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1Snq28-0005gL-Og; Sun, 08 Jul 2012 13:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <1341738766823-7562695.post@n2.nabble.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1341748338.132870000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1341749466.255272000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201174>

Am 08.07.2012 11:12, schrieb pbGit:
> http://www.petermac.com/setup-git-local-and-remote-repositories/ this .  All

The recipe at this address seems to have a "--bare" parameter missing at 
the git init in step 7
