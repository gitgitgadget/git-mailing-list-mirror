From: "H. Peter Anvin" <hpa@zytor.com>
Subject: description
Date: Fri, 29 Apr 2005 17:14:41 -0700
Message-ID: <4272CDF1.9060207@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 30 02:09:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRfXe-0002wn-Ep
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 02:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbVD3AOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 20:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVD3AOu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 20:14:50 -0400
Received: from terminus.zytor.com ([209.128.68.124]:19903 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263079AbVD3AOt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 20:14:49 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3U0ElNm017685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 17:14:47 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, score=-3.9 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I guess this is technically speaking complete nonstandard addition to 
git :) but I have added the following to the script that generates 
http://www.kernel.org/git/:

If there is a plain text file called "description" in the .git 
directory, it will appear on that webpage.

	-hpa
