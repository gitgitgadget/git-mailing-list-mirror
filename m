From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: GIT 0.99.9e
Date: Mon, 07 Nov 2005 09:08:36 -0800
Message-ID: <436F8A14.9070306@zytor.com>
References: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net> <20051107154718.GJ3001@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 18:10:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZAUY-0003Oc-EU
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 18:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVKGRIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 12:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVKGRIy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 12:08:54 -0500
Received: from terminus.zytor.com ([192.83.249.54]:45292 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932300AbVKGRIx
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 12:08:53 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jA7H8gHd021010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Nov 2005 09:08:42 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051107154718.GJ3001@reactrix.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11271>

Nick Hengeveld wrote:
> On Sun, Nov 06, 2005 at 09:43:19PM -0800, Junio C Hamano wrote:
> 
> 
>> - http-push seems to still have a bug or two but that is to be
>>   expected for any new code, and I am reasonably sure it can be
>>   ironed out; preferably before 1.0 but it is not a
>>   showstopper.
> 
> It seems like a minor point, but is this the appropriate name or should
> it be dav-push?  Not that there's anything else in the works AFAIK but
> it's certainly possible that something else could run over HTTP later
> on.
> 

Push over HTTP POST would at least be theoretically possible.

	-hpa
