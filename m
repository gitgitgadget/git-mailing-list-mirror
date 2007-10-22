From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: .gittattributes handling has deficiencies
Date: Mon, 22 Oct 2007 07:38:28 +0200
Message-ID: <2C5D2967-A89F-4056-AD2A-0644B952C38F@zib.de>
References: <1192956535617-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710210204580.4818@asgard> <B61AE1A9-E983-4ACE-BF71-8FDC113A4F34@zib.de> <Pine.LNX.4.64.0710211007430.4818@asgard> <1A07FEE6-88D8-4ED7-BEFD-F7F3B71310A5@zib.de> <Pine.LNX.4.64.0710211056580.4818@asgard> <C7F59DFB-D4E4-4F75-88F7-F1A90C7D41E8@zib.de> <Pine.LNX.4.64.0710211645210.12998@asgard.lang.hm> <Pine.LNX.4.64.0710211703060.12998@asgard.lang.hm>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Oct 22 07:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijpyv-0006pk-4R
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbXJVFhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbXJVFhF
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:37:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:42393 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbXJVFhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:37:03 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9M5b01E009395;
	Mon, 22 Oct 2007 07:37:00 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db11d6f.pool.einsundeins.de [77.177.29.111])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9M5axKx026250
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 22 Oct 2007 07:36:59 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710211703060.12998@asgard.lang.hm>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61936>


On Oct 22, 2007, at 2:05 AM, david@lang.hm wrote:

>
> by the way, I am not saying that my suggestion is the right way for  
> things to be (especially long term), but I'm trying to figure out a  
> work-around for the short term.

And I'm saying your proposed workaround is dangerous and doesn't
work reliably.

> I'm very interested to see the logn-term suggestions, becouse I  
> suspect that modt of them could be leveraged for the metastore jobs.

I'd prefer this, too.
	
	Steffen
