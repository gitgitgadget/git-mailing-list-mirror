From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Tue, 04 Oct 2005 22:25:22 -0700
Message-ID: <434363C2.2040501@zytor.com>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com> <434299DB.7020805@zytor.com> <20051005031642.GD1393@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 07:27:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN1mx-0004i2-6r
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 07:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVJEFZw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 01:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVJEFZw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 01:25:52 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:26782 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932539AbVJEFZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 01:25:52 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j955PiJv003782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 22:25:46 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20051005031642.GD1393@trixie.casa.cgf.cx>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9700>

Christopher Faylor wrote:
> That's a relief.  Btw, AFAIK, strerror is working correctly under
> Cygwin also.

Now if we can only figure out why gitk is messed up...

	-hpa
