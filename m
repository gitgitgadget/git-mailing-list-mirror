From: Matthew Caron <Matt.Caron@redlion.net>
Subject: Re: diff/merge tool that ignores whitespace changes
Date: Tue, 28 Aug 2012 13:41:51 -0400
Message-ID: <503D02DF.3030802@redlion.net>
References: <1679275990.100371.1346175639379.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Enrico Weigelt <enrico.weigelt@vnc.biz>, <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 19:44:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Ppk-0008Rf-Or
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 19:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab2H1RoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 13:44:06 -0400
Received: from msex2.hq.corp.redlion.net ([205.159.151.218]:24405 "EHLO
	msex2.hq.corp.redlion.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab2H1RoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 13:44:05 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2012 13:44:04 EDT
Received: from MSEX1.hq.corp.redlion.net (172.16.2.15) by
 msex2.hq.corp.redlion.net (172.16.2.18) with Microsoft SMTP Server (TLS) id
 14.0.722.0; Tue, 28 Aug 2012 13:41:52 -0400
Received: from BL-MSEX1.hq.corp.redlion.net (10.128.0.5) by
 msex1.hq.corp.redlion.net (172.16.2.15) with Microsoft SMTP Server (TLS) id
 14.1.355.2; Tue, 28 Aug 2012 13:41:52 -0400
Received: from [10.128.3.6] (10.128.3.6) by BL-MSEX1.hq.corp.redlion.net
 (10.128.0.5) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Aug 2012
 13:41:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <1679275990.100371.1346175639379.JavaMail.root@genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204433>

On 08/28/2012 01:40 PM, Stephen Bash wrote:
> ----- Original Message -----
>> From: "Enrico Weigelt" <enrico.weigelt@vnc.biz>
>> Sent: Tuesday, August 28, 2012 12:26:39 PM
>> Subject: diff/merge tool that ignores whitespace changes
>>
>> I'm looking for a diff / merge tool that treats lines with
>> only whitespace changes (trailing or leading whitespaces,
>> linefeeds, etc) as equal.
>>
>> The goal is to make reviews as well as merging or rebasing
>> easier when things like indentions often change.
>>
>> Does anybody know an solution for that ?

I'm fond of Meld.

-- 
Matthew Caron, Software Build Engineer
Sixnet, a Red Lion business | www.sixnet.com
+1 (518) 877-5173 x138 office
