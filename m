From: David Mansfield <centos@dm.cobite.com>
Subject: Re: Collecting cvsps patches
Date: Tue, 13 Jun 2006 09:46:46 -0400
Message-ID: <448EC1C6.5060902@dm.cobite.com>
References: <20060611122746.GB7766@nowhere.earth> <1150173310.15831.6.camel@dv> <20060613095445.GM1297@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, GIT list <git@vger.kernel.org>,
	cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Tue Jun 13 15:47:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq9EK-0000g1-OD
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 15:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWFMNqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 09:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFMNqt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 09:46:49 -0400
Received: from iris.cobite.com ([208.222.83.2]:39108 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S1751102AbWFMNqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 09:46:48 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 2AE15982D1; Tue, 13 Jun 2006 09:46:13 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 24484-05; Tue, 13 Jun 2006 09:46:13 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id E5A1E984F6; Tue, 13 Jun 2006 09:46:12 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 5138C982D1; Tue, 13 Jun 2006 09:46:12 -0400 (EDT)
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060613095445.GM1297@nowhere.earth>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21778>



Yann Dirson wrote:
> Hi Pavel,
> 
> On Tue, Jun 13, 2006 at 12:35:10AM -0400, Pavel Roskin wrote:
>> I'm sending four patches - two compile
>> fixes for recent regressions and two patches fixing DNS resolution on
>> 64-bit systems - one on Linux and the other on other OSes.
> 
> Thanks, applied the two latter fixes, and folded the compile fix into
> the patch it should have been part of :)
> 
> For the dependency stuff, I added the -Y flag to hte makedepend
> invocation.  This produces many warnings, but at least does the job
> right.
> 
> I'll push the whole once I have finished a little work on another
> branch.
> 
> Please excuse any delays due to the recent birth of our 3rd son ;)

Congratulations.  I'm really glad someone has taken some time to collect 
these patches.  I feel really bad about 'abandoning' (for now only, I 
hope) the project.

At the very least, I should put some mention in the web page, is there 
some text you want me to put up there, and/or a like?

David
