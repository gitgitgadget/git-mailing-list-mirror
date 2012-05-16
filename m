From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Wed, 16 May 2012 07:01:59 +0200
Message-ID: <4FB334C7.2070201@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox> <4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer> <4FAC0633.90809@alum.mit.edu> <20120511171230.GA2107@tgummerer> <4FB01080.6010605@alum.mit.edu> <20120514150113.GD2107@tgummerer> <4FB1746A.6090408@alum.mit.edu> <20120515134916.GA2074@tgummerer.unibz.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 07:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUWUG-0002UG-W7
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 07:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966044Ab2EPFJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 01:09:13 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:45029 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932766Ab2EPFJJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 01:09:09 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 May 2012 01:09:09 EDT
X-AuditID: 1207440d-b7f336d00000097b-74-4fb334cd7ac9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D8.74.02427.DC433BF4; Wed, 16 May 2012 01:02:05 -0400 (EDT)
Received: from [192.168.69.142] (p4FC0D6A1.dip.t-dialin.net [79.192.214.161])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4G521sq015160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 May 2012 01:02:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120515134916.GA2074@tgummerer.unibz.it>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqHvWZLO/wYX9nBaPTm5msui60s1k
	0dB7hdniR0sPs8X8QxNZLS6svs1usXLXQiYHdo+ds+6yeyzYVOrxrHcPo8fFS8oef87vYfWY
	+2kRq8fnTXIB7FHcNkmJJWXBmel5+nYJ3Bn/t11hLNgkWPH08kymBsbvvF2MHBwSAiYSD7qy
	uxg5gUwxiQv31rN1MXJxCAlcZpS4s7yfBcI5yyRxaUMTC0gVr4C2xOeWvWA2i4CqxNUV95lB
	bDYBXYlFPc1MIENFBcIkVj/QgCgXlDg58wlYuYiAlsSkr32sIDazQAujxOt5ESDlwgIyEhvW
	e0Gs2sgssenibHaQGk4Bc4lDvw+xgdQwC1hLfNtdBNEqL7H97RzmCYwCs5BsmIVQNQtJ1QJG
	5lWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYITHAu4Px/zqZQ4wCHIxKPLyG
	TZv8hVgTy4orcw8xSnIwKYnyhups9hfiS8pPqcxILM6ILyrNSS0+xCjBwawkwuvyFKicNyWx
	siq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBe8QYaKhgUWp6akVaZk4JQpqJ
	gxNkOJeUSHFqXkpqUWJpSUY8KEbji4FRCpLiAdr7HaSdt7ggMRcoCtF6itGY48/DRdcYOWZ8
	ApJCLHn5ealS4rzXQEoFQEozSvPgFsGS3ytGcaC/hXkPg1TxABMn3LxXQKuYgFaV5YK8WFyS
	iJCSamC0ZdZUvBvFeqRI/wnfKq69BY88fj/xroyY/UCuRmPh9rYNdxXYsm79jP4S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197864>

On 05/15/2012 03:49 PM, Thomas Gummerer wrote:
> Thanks again for your feedback. I've refactored the code again,
> thanks to your suggestions.

I just reviewed version 1369bd855b86 of your script, and it is MUCH 
better.  It's easy to read and review.  The functions that it defines 
are now self-contained and could therefore be reused for other purposes. 
  There are fewer magic numbers (though there are still a few; I wonder 
if there is a way to get rid of those?)  You've done a nice job 
polishing up the code.

I have only a few remaining niggles::

1. The struct module can handle fixed-length strings, so you could read 
and parse the SHA1s as part of FILE_DATA_STRUCT and DIR_DATA_STRUCT 
rather than handling them separately.

2. At least some of the functions deserve docstrings, especially when 
they are nontrivial.  For example, what arguments read_files() needs and 
how they are used is far from obvious.

3. It would be easier to read the multiline string formatting templates 
if they are written as multiline strings (even though this kindof 
requires that they be made file-level constants); e.g.,

FILE_FORMAT = """\
%(name)s (%(objhash)s)
mtime: %(mtimes)s:%(mtimens)s
mode: %(mode)s flags: %(flags)s
statcrc: """

In the future, please try to commit one self-contained change at a time 
and make your commit messages really describe what is changed in the 
commit.  For example, commit fb2654c648a does at least three things, 
only one of which is mentioned in its commit message.  It would be 
better to break this into three commits with three commit messages.  Use 
"git rebase -i" and the other commit-rewriting tools liberally to tidy 
up commits before publishing them (but not after publishing them!); for 
example, commit be8d01c22c should really have been squashed on top of 
"Changed main to a function" so that the rest of the world doesn't have 
to see the broken latter commit.

But I don't want to detract from the fact that altogether you have made 
very nice improvements to the script, and I hope to see more like this 
from you in the future!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
