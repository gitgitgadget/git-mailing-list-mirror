From: Anjib Mulepati <anjibcs@hotmail.com>
Subject: Push from specific directory.
Date: Thu, 22 Mar 2012 18:04:20 -0400
Message-ID: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 23:04:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAq7S-0006RA-OM
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 23:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab2CVWE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 18:04:26 -0400
Received: from blu0-omc3-s3.blu0.hotmail.com ([65.55.116.78]:13227 "EHLO
	blu0-omc3-s3.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755708Ab2CVWEZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 18:04:25 -0400
Received: from BLU0-SMTP471 ([65.55.116.73]) by blu0-omc3-s3.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 22 Mar 2012 15:04:24 -0700
X-Originating-IP: [146.243.44.97]
X-Originating-Email: [anjibcs@hotmail.com]
Received: from [146.243.44.97] ([146.243.44.97]) by BLU0-SMTP471.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 22 Mar 2012 15:04:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
X-OriginalArrivalTime: 22 Mar 2012 22:04:21.0702 (UTC) FILETIME=[BC4EBE60:01CD0877]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193722>

Hi All

I am starting using Git and few queries about it.
1. Is it always necessary to be in root directory to do the push?
2. Can I have a folder structure like
         (a) /Hello-World
         (b) /Hello-World/gitVersion/GitVersionFile.txt and
         (c) /Hello-World/nonGitVersion/NonGitVersionFile.txt
where I give git init for (a) and (c). If Itry to push only from (c) is 
that valid?

Thanks,
Anjib
