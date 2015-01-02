From: Ben Aveling <bena.001@optusnet.com.au>
Subject: Re: Git's Perl scripts can fail if user is configured for perlbrew
Date: Fri, 02 Jan 2015 14:08:25 +1100
Message-ID: <54A60BA9.1020204@optusnet.com.au>
References: <54A085D1.8060407@blackperl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "Randy J. Ray" <rjray@blackperl.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 04:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y6t6w-0008Ol-OV
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 04:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbbABDht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2015 22:37:49 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:53611 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751523AbbABDhs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2015 22:37:48 -0500
X-Greylist: delayed 1765 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jan 2015 22:37:48 EST
Received: from [10.1.1.3] (d220-237-50-134.mas801.nsw.optusnet.com.au [220.237.50.134])
	(Authenticated sender: bena.001@optusnet.com.au)
	by mail104.syd.optusnet.com.au (Postfix) with ESMTPSA id C1BBF4214E4;
	Fri,  2 Jan 2015 14:08:19 +1100 (AEDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54A085D1.8060407@blackperl.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.1 cv=R8o6R7hX c=1 sm=1 tr=0
	a=uklerOY5PXGv+x1DhnXQTA==:117 a=uklerOY5PXGv+x1DhnXQTA==:17
	a=PO7r1zJSAAAA:8 a=DgqbUt__V68A:10 a=N659UExz7-8A:10
	a=oo9BxBm8y9Wd0OSQfWIA:9 a=pILNOxqGKmIA:10 a=lUdQZDr125cA:10
	a=zqZUzNLwlzgA:10 a=uHdMVzTb254A:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261975>

On 29/12/14 09:36, Randy J. Ray wrote:
> I don't know enough about the overall git ecosystem to know if this 
> would have an adverse effect on anything else (in particular, Windows 
> compatibility, but then Windows probably isn't having this issue in 
> the first place).

Perlbrew doesn't support Windows, so no, not an issue for Windows.

Regards, Ben
