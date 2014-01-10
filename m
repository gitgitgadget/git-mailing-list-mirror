From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: A question about the error: svn_fspath__is_canonical
Date: Fri, 10 Jan 2014 20:34:16 +0100
Message-ID: <52D04B38.6060203@web.de>
References: <CABRpx=1CvB55zeL1L8QOvyfbJCaG9FK+HEz-iK9cFGrnxmOJtg@mail.gmail.com> <20140110191650.GF4776@google.com> <CABRpx=3vf-bwtA8_2ndPYo+fWCNiHQdSbLRGFWts4Wp3uN6yDA@mail.gmail.com> <20140110192825.GG4776@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Dan Kaplan <dank@mirthcorp.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 20:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1hqe-0005Ns-Bz
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 20:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757860AbaAJTeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 14:34:25 -0500
Received: from mout.web.de ([212.227.15.14]:53141 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341AbaAJTeY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 14:34:24 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MJ1Nh-1W4AgY0Rlx-002btd for <git@vger.kernel.org>;
 Fri, 10 Jan 2014 20:34:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140110192825.GG4776@google.com>
X-Provags-ID: V03:K0:LF9fY/733CdYMZnyYqkbnVOCUss8rfKc9dPbpDanRqdRmmjekPm
 Zm/tQYQH6te5OIJFhRU+QPq5vHaEKB2y7zLEbxzGkG8oGcj8nLx1fTjbo4ql2DECBGb8HnY
 FLCPkK56KicxVPUYwNHCRTOi06JpW9dZtY6ohGMs7ECqAgUce1ffFF4GTudQYeYnaA69x0E
 trIsHTufIcLzktgtg9wBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240314>

On 2014-01-10 20.28, Jonathan Nieder wrote:
> Dan Kaplan wrote:
> 
>>                              Do you think it'll still work?
> 
> Yes, that's why I suggested it. ;-)
> 
> You might need to install the gcc-core, libcurl-devel, openssl-devel,
> and subversion-perl packages first.
> 
> Regards,
> Jonathan
Out of my head:
You probably need to install even:
make, expat-devel (or similar)
