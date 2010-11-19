From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git doc generation question
Date: Fri, 19 Nov 2010 11:47:32 -0500
Message-ID: <1290185252.13785.1.camel@drew-northup.unet.maine.edu>
References: <4CE6A53A.9090203@obry.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Fri Nov 19 17:48:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJU8E-0002Zn-7m
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 17:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab0KSQsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 11:48:08 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:58439 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0KSQsH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 11:48:07 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oAJGlbJt005702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Nov 2010 11:47:42 -0500
In-Reply-To: <4CE6A53A.9090203@obry.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oAJGlbJt005702
X-MailScanner: Found to be clean
X-MailScanner-SpamScore: s
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1290790063.93412@VF3lbUYXKgg4nId3JMdX7g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161766>


On Fri, 2010-11-19 at 17:26 +0100, Pascal Obry wrote:
> Hi,
> 
> I'm building Git from source and in the documentation I have some code
> remaining, for example:
> 
>    $ man git
> 
> git me in the CONFIGURATION MECHANISM section:
> 
> 
> <<
>        example:
> 
>            .ft C
>            #
>            # A '#' or ';' character indicates a comment.
>            #
> 
>            ; core variables
>            ...
>            .ft
> >>
> 
> It looks like the ".ft C" and the ending .ft are some code not properly
> parsed. Right?
> 
> Is that a known issue?
> 
> I had this problem on Cygwin and now on GNU/Debian!
> 
> Thanks,
> Pascal.

Pascal,
Have a look at this thread:
http://article.gmane.org/gmane.comp.version-control.git/161607


-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
