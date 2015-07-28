From: Filippo Gatti <filippo.gatti@centralesupelec.fr>
Subject: default configuration files on cygwin
Date: Tue, 28 Jul 2015 09:10:40 +0200
Message-ID: <55B72AF0.90208@centralesupelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 09:15:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJz6z-00023Q-Hn
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 09:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbbG1HPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 03:15:37 -0400
Received: from smtp1.ecp.fr ([138.195.33.53]:33202 "EHLO smtp1.ecp.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbbG1HPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 03:15:37 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2015 03:15:37 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.ecp.fr (Postfix) with ESMTP id 8ED7761E1C
	for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:10:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp1.ecp.fr
Received: from smtp1.ecp.fr ([127.0.0.1])
	by localhost (smtp1.ecp.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BdN3_VZ2ZKWE for <git@vger.kernel.org>;
	Tue, 28 Jul 2015 09:10:25 +0200 (CEST)
Received: from [192.168.1.57] (73.7.19.93.rev.sfr.net [93.19.7.73])
	(Authenticated sender: gattif)
	by smtp1.ecp.fr (Postfix) with ESMTPSA id 7223E60A0E
	for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:10:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274749>

Hi,

I'm currently running git on a cygwin platform.
I would like to know how i can set up a sort of configuration file to 
launch automatically the ssh-agent and get connected to github (for istance)
directly.

Thanks

Filippo
