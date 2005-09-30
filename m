From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Fri, 30 Sep 2005 12:08:10 -0700
Message-ID: <433D8D1A.9010904@zytor.com>
References: <433B3B10.5050407@zytor.com> <7v4q826ffy.fsf@assigned-by-dhcp.cox.net> <433D6F62.3030906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 21:09:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELQFk-0002rS-3K
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 21:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVI3TIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 15:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbVI3TIk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 15:08:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:47020 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030308AbVI3TIX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 15:08:23 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8UJ8F4e023869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Sep 2005 12:08:15 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433D6F62.3030906@zytor.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9572>

Okay, I have updated the git-cygwin repository with the changes 
proposed, and they seem to work.

	-hpa
