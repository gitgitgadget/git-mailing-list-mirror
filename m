From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] gitk: Add "Refs" menu
Date: Wed, 12 Oct 2005 10:47:44 -0700
Message-ID: <434D4C40.5020402@zytor.com>
References: <20051012115559.6546.qmail@web26305.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 19:50:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPkiD-0004YW-NU
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 19:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVJLRsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVJLRsS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 13:48:18 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56028 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751471AbVJLRsR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 13:48:17 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9CHlkek019565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Oct 2005 10:47:46 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051012115559.6546.qmail@web26305.mail.ukl.yahoo.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10041>

Marco Costalba wrote:
>  
> 
>>And making gitk cooperate with stgit would be a killer application not
>>just for gitk and stgit, but for git itself (i.e. it could be the reason
>>why git is chosen for development over e.g. Mercurial for new projects).
>>
> 
> 
> Not to advertise, but qgit (http://digilander.libero.it/mcostalba/) already offers 
> stgit integration, among other things.
> 
> I plan to release a new version implementing various suggestion from the list this week, there are
> also important stgit fixes and upgrades. 
> 
> To have a look at new features check the git arcihve: cg-clone
> http://digilander.libero.it/mcostalba/qgit.git
> 

I looked at qgit at one time, and I find its UI to be much less pleasant 
to look at that gitk, which is unfortunate, because it's much faster. 
Both the graph and the color scheme are much less pleasant, which 
distracts from the information conveyed.

	-hpa
