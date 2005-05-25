From: "H. Peter Anvin" <hpa@zytor.com>
Subject: gitk feature request
Date: Wed, 25 May 2005 10:29:18 -0700
Message-ID: <4294B5EE.8020003@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 25 19:29:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dazfo-00042T-3H
	for gcvg-git@gmane.org; Wed, 25 May 2005 19:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVEYR3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 13:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVEYR3u
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 13:29:50 -0400
Received: from terminus.zytor.com ([209.128.68.124]:33976 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261417AbVEYR3g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 13:29:36 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4PHTOLK030082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 May 2005 10:29:25 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>, paulus@samba.org
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It would be really nice to be able to select a set of commits in gitk 
and write out a patch from one to the other -- just a wrapper arount 
git-diff.

	-hpa
