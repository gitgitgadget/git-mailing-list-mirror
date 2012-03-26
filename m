From: Anjib Mulepati <anjibcs@hotmail.com>
Subject: Finding list of commit object
Date: Mon, 26 Mar 2012 11:22:45 -0400
Message-ID: <BLU0-SMTP344C6638261C23F2023DD72B1450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 17:22:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCBl1-0001ru-FX
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 17:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636Ab2CZPWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 11:22:49 -0400
Received: from blu0-omc3-s32.blu0.hotmail.com ([65.55.116.107]:50638 "EHLO
	blu0-omc3-s32.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932303Ab2CZPWs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 11:22:48 -0400
Received: from BLU0-SMTP344 ([65.55.116.74]) by blu0-omc3-s32.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 26 Mar 2012 08:22:47 -0700
X-Originating-IP: [146.243.44.97]
X-Originating-Email: [anjibcs@hotmail.com]
Received: from [146.243.44.97] ([146.243.44.97]) by BLU0-SMTP344.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 26 Mar 2012 08:22:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
X-OriginalArrivalTime: 26 Mar 2012 15:22:46.0423 (UTC) FILETIME=[4C0DF270:01CD0B64]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193917>

Hi All,

I was doing some research on git objects. I understand that each object 
is represented with hash code and we can find the type of object with 
git cat command. I was wondering is there any command we can give to 
find the list of commit object (or any other object type) in current 
project without doing cat on each and every object inside .git/objects/

Thanks,
Anjib
