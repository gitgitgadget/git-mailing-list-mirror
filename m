From: Fabien Dubail <fabien.dubail@labage.be>
Subject: git merge
Date: Tue, 20 Mar 2012 10:47:35 +0100
Message-ID: <4F685237.5060402@labage.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 12:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9wwm-0001eK-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 12:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758177Ab2CTLJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 07:09:44 -0400
Received: from uk44.verygoodserver.com ([94.76.225.150]:56306 "EHLO
	uk44.verygoodserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab2CTLJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 07:09:43 -0400
X-Greylist: delayed 5101 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Mar 2012 07:09:43 EDT
Received: from labage.giga.ulg.ac.be ([139.165.90.197]:50687 helo=[192.168.0.108])
	by uk44.verygoodserver.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <fabien.dubail@labage.be>)
	id 1S9vcO-0005TK-0a
	for git@vger.kernel.org; Tue, 20 Mar 2012 09:44:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - uk44.verygoodserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - labage.be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193494>

Hi,

I've conflicts when I merge branches. I can resolve some conflicts but 
not all. The remaining conflicts will be solved by someone else?
To do that I would like to merge only some files and resolve 'my' 
conflicts. (something like: 'git checkout branch files' but with merge)
Than remaining files will be merged by someone else and remaining 
conflicts will be resolved .
Is-it possible to do that with git and how? Or is there an other way?

Thanks

Fabien
