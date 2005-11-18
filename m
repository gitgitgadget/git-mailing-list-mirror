From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Thu, 17 Nov 2005 21:57:19 -0800
Message-ID: <437D6D3F.4050904@zytor.com>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de> <20051115215943.GW30496@pasky.or.cz> <437A5FAF.2000609@zytor.com> <200511160232.15162.Josef.Weidendorfer@gmx.de> <437D6294.8020003@zytor.com> <437D6AD8.90907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 07:45:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EczSI-0007r8-A8
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 07:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVKRF52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 00:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKRF51
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 00:57:27 -0500
Received: from terminus.zytor.com ([192.83.249.54]:2005 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964925AbVKRF51
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 00:57:27 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAI5vJ1R024555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Nov 2005 21:57:19 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: gitzilla@gmail.com
In-Reply-To: <437D6AD8.90907@gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12201>

A Large Angry SCM wrote:
> 
> Attached is the output of 'rpm --showrc' on my Suse 9.3 system.
> 
> -14: _vendor	suse

... looks promising.

	-hpa
