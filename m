From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] git-gui: Improve the application icon on Windows.
Date: Tue, 27 Nov 2007 23:09:14 +0100
Message-ID: <A7DA7B28-E67A-47FC-AE8D-C277ECA60FAC@zib.de>
References: <1196177124-13601-1-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0711271539310.27959@racer.site> <200711272147.22511.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Nov 27 23:08:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix8bo-0000p3-Vg
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 23:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746AbXK0WIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 17:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758692AbXK0WIX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 17:08:23 -0500
Received: from mailer.zib.de ([130.73.108.11]:38861 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758588AbXK0WIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 17:08:22 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lARM83Nx028394;
	Tue, 27 Nov 2007 23:08:03 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1bb7f.pool.einsundeins.de [77.177.187.127])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lARM82d8015353
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 27 Nov 2007 23:08:03 +0100 (MET)
In-Reply-To: <200711272147.22511.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66266>


On Nov 27, 2007, at 9:47 PM, Johannes Sixt wrote:

> On Tuesday 27 November 2007 16:40, Johannes Schindelin wrote:
>> Hi,
>>
>> On Tue, 27 Nov 2007, Johannes Sixt wrote:
>>> Previusly, there was only a 16x16 image, which looked very  
>>> distorted.
>>> Here we add a 32x32 version, and also make the image sharper.
>>>
>>> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
>>> ---
>>> 	I'm by far not an artist, but improving the previous version
>>> 	was not difficult at all. ;)
>>
>> Why did you not just use the svg contained in msysGit?
>
> Because I cannot find one?
>
> $ GIT_PAGER=cat git grep -i svg 4msysgit/devel
> 4msysgit/devel:attr.c:   * attributes, e.g. "*.svg       
> merge=special-...


http://msysgit.googlecode.com/files/gitlogo.svg

	Steffen
