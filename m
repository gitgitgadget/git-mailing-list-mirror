From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 08/17] revision: split some overly-long lines
Date: Thu, 23 May 2013 08:27:46 +0200
Message-ID: <519DB6E2.9010900@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu> <1368995232-11042-9-git-send-email-mhagger@alum.mit.edu> <7vzjvonsna.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 08:27:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfP0F-0006n6-TK
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 08:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab3EWG1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 02:27:52 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:57588 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372Ab3EWG1v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 02:27:51 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-81-519db6e6f62f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 9D.DA.02295.6E6BD915; Thu, 23 May 2013 02:27:50 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4N6RlAv005428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 May 2013 02:27:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vzjvonsna.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqPts29xAgwPdWhZdV7qZLBp6rzBb
	zLu7i8niR0sPswOLx6WX39k8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujMdXfzEV
	HOOs+PJ7P1MD4zX2LkZODgkBE4mzF76xQNhiEhfurWfrYuTiEBK4zChxdNcPKOcak8Shi58Y
	uxg5OHgFtCWuN0eDNLAIqEpca/3LCGKzCehKLOppZgKxRQXCJN4vm8oKYvMKCEqcnPkEbIGI
	gJrExLZDYDazQJzEzs5VYPXCAo4SHc8Xs0DsWs4o8fPmLrDrOAXMJF5PuAPVoCPxru8BM4Qt
	L7H97RzmCYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJT
	SjcxQgKaZwfjt3UyhxgFOBiVeHgP3JgTKMSaWFZcmXuIUZKDSUmU12fr3EAhvqT8lMqMxOKM
	+KLSnNTiQ4wSHMxKIrybe4ByvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkO
	DiUJ3okgQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRpfDIxWkBQP0N6ZIO28
	xQWJuUBRiNZTjMYcm89PfsfIMeMHkBRiycvPS5US550NUioAUppRmge3CJbKXjGKA/0tzLsQ
	pIoHmAbh5r0CWsUEtGrpqTkgq0oSEVJSDYxBwWumhjseelcXbvn6t/vWYpVHXH6p9lcjWx4e
	WscVJ2QrJr6DOW/3KVnrhofCN2X3sD68KOldWy16THNabcu6KEFei1O91+boTVTQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225217>

On 05/21/2013 07:34 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  revision.c | 20 ++++++++++++++------
>>  revision.h | 32 +++++++++++++++++++++-----------
>>  2 files changed, 35 insertions(+), 17 deletions(-)
> 
> Looks obviously good for *.c file, but I am on the fence for *.h
> one, as the reason we kept these long single lines in *.h files was
> to help those who want to grep in *.h files to let them view the
> full function signature.  It probably is OK to tell them to use
> "git grep -A$n" instead, though.

My goal with this patch was not to set a new policy but rather just to
make the code conform a little better to the existing policy as
described in CodingGuidelines.  *If* it is preferred that header files
list all parameters on a single line, then by all means adjust the
CodingGuidelines and I will just as happily make header files conform to
*that* policy when I touch them :-)

(That being said, my personal preference is to apply the 80-character
limit for header files too.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
