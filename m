From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Suggestion: "man git clone"
Date: Wed, 03 Sep 2008 20:31:04 -0700
Message-ID: <48BF5678.8080201@zytor.com>
References: <48ACB29C.7000606@zytor.com> <48ADE2FF.4080704@acm.org> <48BF4662.9000305@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Federico Lucifredi <flucifredi@acm.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 05:32:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb5Zy-0005Dv-77
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 05:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYIDDbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 23:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYIDDbM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 23:31:12 -0400
Received: from terminus.zytor.com ([198.137.202.10]:57722 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbYIDDbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 23:31:12 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m843V9Ai017700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Sep 2008 20:31:10 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m843V97e016357;
	Wed, 3 Sep 2008 20:31:09 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m843V48q007545;
	Wed, 3 Sep 2008 20:31:04 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48BF4662.9000305@acm.org>
X-Virus-Scanned: ClamAV version 0.93.3, clamav-milter version 0.93.3 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94884>

Federico Lucifredi wrote:
> Hello HP, All,
>  I somehow managed to forget this (age must be taking its toll), but 
> there is a convention commonly used for man pages of Perl Modules, which 
> can be reasonably usable for subcommands as well:
> 
>  man APR::Brigade
> 
> will work just fine, with a file by the same name. This convention is in 
> current use, and would map to
> 
>  man git::clone
> 
> while :: is not as immediate in context as in Perl, it does do the job, 
> and works regardless of pager.
> 

That's just as bad as "man git-clone".  Arguably worse.

	-hpa
