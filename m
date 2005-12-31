From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 31 Dec 2005 13:53:09 -0800
Message-ID: <43B6FDC5.6020601@zytor.com>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se> <009701c60891$50893fd0$6900a8c0@sps> <Pine.LNX.4.63.0512241509240.24308@wbgn013.biozentrum.uni-wuerzburg.de> <003101c60976$f2912ff0$6900a8c0@sps> <20051231163952.GA29284@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 31 22:54:39 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsogN-0001sR-3U
	for gcvg-git@gmane.org; Sat, 31 Dec 2005 22:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVLaVxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Dec 2005 16:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVLaVxW
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Dec 2005 16:53:22 -0500
Received: from terminus.zytor.com ([192.83.249.54]:49824 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932319AbVLaVxV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Dec 2005 16:53:21 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBVLr93Z023259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 31 Dec 2005 13:53:10 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20051231163952.GA29284@trixie.casa.cgf.cx>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14126>

Christopher Faylor wrote:
> 
> As was mentioned, the Cygwin project is very far from dead and has
> actually never been close to dead.  It is, however, like any open source
> project and things like the setup program are always under slow,
> sporadic development.
> 
> The core cygwin dll is under active development and maintenance and most
> of the packages in the distribution are under active maintenance, however.

Cygwin probably could benefit greatly if they adopted something like 
rpm/yum for packaging, instead of reinventing the wheel.

	-hpa
