From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Mingw: verify both ends of the pipe () call
Date: Fri, 28 Aug 2015 11:52:07 +0200
Organization: gmx
Message-ID: <e9a26e1698dfc5b29d12d87c67e734cd@www.dscho.org>
References: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
 <20150827215014.GA8165@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jose F. Morales" <jfmcjf@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 11:52:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVGKa-000350-66
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 11:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbbH1JwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 05:52:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:54790 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbbH1JwK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 05:52:10 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MV5hN-1ZCsNR1G17-00YOVj; Fri, 28 Aug 2015 11:52:08
 +0200
In-Reply-To: <20150827215014.GA8165@google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:PwLR6UlvzjPD0qfpf37Il7uLjL2OxPzw9JvQA0owxRFrLO+NKQf
 Ati5Qgem5hrb5WuqrzQwDSe1a8/0E40pCsxdT2+g2VRoySHcB1ttVggEe7QwKRUsNYSM21W
 NjK7VTcVuNUZVtGQZjmcgQeY8Pi72Mspix3y4HwGr2uRO6CTYypPwO+5E1nfhCeAzN1/lhj
 GQRbdTfVb0AALt9O5S24Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pynflkySI8c=:Kt1L5EJe34CedjfEE3B8Fr
 Ho0dhAnrj9o9J5z9l5y30Fk3gyUHUrymSLaeImlSX2/nIPa7qkuwN7gRSSZBWd7gEzCZSfYJk
 FAjmyCA+aOKg0Sofc/a9S0IYSzR30VnxYmCmU8zCbfjYXT326l+qLX2sCOkP3fVm7mIxDmbFy
 XhL6wV0iQQTPmXgdQ2VjWKNEjzFJiM1sqNCwSI8zuPpBecOOCMJCQNvhMY9LFzYAgCQtGmGyt
 V1+NcdARml8ZThU0xs+383Gbti4PLnU5RCHzbvkGgLMpHhzDS5Kr5tu+IV7Z9+LQjZKtNKjpE
 asX/quNJZ1XAmRKVmkbr641qJK5A1qs3Dlf2p+nStjXmeTDxsvv5kbmFbJOAAnHFmiTvKj8Vy
 Tq4zYGgJN+luecOAX7b0gjy5s3upcrpf8mONkeUwgs5EX3opAR75aztzNWxIrp7scvE3hqYMR
 LiZQ4AHN8o1hHwQKBjYYUQ13zagPEzqE2O+6RKtgAUxXGNPUgG8PJzY/Sc93h4DcDnav6P9i6
 QErtqXQKQjKPx0SyHYvfPlzOqK0N+0myKMg8/y505AGXeGhb6dvLJ2U37QcETCi51fAEtZzcb
 r9e7b1pQi9ynUx+ynEjgLVl2MZLZXNCVk6Ng6j37/cVTrQz0+8V4Q67bkbqtfyY/u7ILR2LeU
 I2hW9fWyRq7JLaUiZcV2OsUsg3Hj7jnXVJ5oOsk4QFbAVpl6tICt0KG3rx3PknbOmiinLKj04
 cASihgNc3x7nUvw9vCZ2LcCuEZELuoFWyIWQWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276713>

Hi Jonathan,

On 2015-08-27 23:50, Jonathan Nieder wrote:
> Johannes Schindelin wrote:
> 
>> From: jfmc <jfmcjf@gmail.com>
> 
> This means the name shown by git shortlog would be jfmc instead of
> Jose F. Morales.  Intended?

Fixed in v2 ;-)

Ciao,
Dscho
