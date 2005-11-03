From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: HTTP pushes
Date: Wed, 02 Nov 2005 20:12:36 -0800
Message-ID: <43698E34.1060805@zytor.com>
References: <20051101020248.GA3928@reactrix.com> <Pine.LNX.4.64.0511011500580.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 05:14:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXWTU-0001eM-MY
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 05:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVKCEMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 23:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVKCEMt
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 23:12:49 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56034 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030299AbVKCEMs
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 23:12:48 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jA34CaWq024501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Nov 2005 20:12:44 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511011500580.25300@iabervon.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11065>

Daniel Barkalow wrote:
> 
> You obviously need a bit more than HTTP...
 >

Not really, as long as you can GET and POST arbitrary files.  Arguably, 
that's not how POST is typically used, though.
	
	-hpa
