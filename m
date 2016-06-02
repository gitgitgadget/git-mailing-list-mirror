From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Thu, 2 Jun 2016 14:02:48 +0200
Message-ID: <57502068.5000500@alum.mit.edu>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
 <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
 <vpqy46qs3f3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, gitster@pobox.com, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 14:03:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8RL1-0006DN-RK
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 14:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbcFBMCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 08:02:55 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50144 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750811AbcFBMCy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 08:02:54 -0400
X-AuditID: 1207440c-c53ff70000000b85-f1-5750206b93c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F8.29.02949.B6020575; Thu,  2 Jun 2016 08:02:51 -0400 (EDT)
Received: from [192.168.69.130] (p508EAEB0.dip0.t-ipconnect.de [80.142.174.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u52C2mpI031299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 2 Jun 2016 08:02:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <vpqy46qs3f3.fsf@anie.imag.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqJutEBBu8O+1mcWn2ROYLLqudDNZ
	NPReYbZY+j/Z4tLn9awWnVNlLWaf/MJucfnOMiYHDo+JX46zelxb+JLRY/nSdYweFy8pe3ze
	JBfAGsVtk5RYUhacmZ6nb5fAnfGm6SZjwVuuikM/VzA1MD7m6GLk4JAQMJF4/S68i5GLQ0hg
	K6NEQ881FgjnPJPElj3bgBxODmEBL4nrd+8xgdgiAhkSmyZ9YIYoWsEo0dq/mRXEYRbYzChx
	9/56NpAqNgFdiUU9zWAdvALaEi83LGUHsVkEVCT2HWwAqxEVCJE4v24rK0SNoMTJmU9YQE7i
	BKpf9kYFJMwsoC7xZ94lZghbXmL72znMExj5ZyHpmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pT
	k3WLkxPz8lKLdA31cjNL9FJTSjcxQsKcZwfjt3UyhxgFOBiVeHgZdPzDhVgTy4orcw8xSnIw
	KYnyriwDCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhbZcLCBfiTUmsrEotyodJSXOwKInzqi5R
	9xMSSE8sSc1OTS1ILYLJynBwKEnw/gBpFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3J
	iAfFZHwxMCpBUjxAe+vA9hYXJOYCRSFaTzHqchzZf28tkxBLXn5eqpQ472eQIgGQoozSPLgV
	sKT2ilEc6GNh3p3yQFU8wIQIN+kV0BImoCUFj/xBlpQkIqSkGhhD6rKLp1674Jlif80qZWnE
	VO67x/zv80xs8Zlxc8OCRUt1m4sbp0c0HNdV9qvdeEN8Tu/UbBYL97Y72isPf99/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296196>

On 05/31/2016 04:33 PM, Matthieu Moy wrote:
> Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:
> [...]
>> +DESCRIPTION
>> +-----------
>> +
>> +Triangular Workflow (or Asymmetric Workflow) is a workflow which gives
>> +the possibility to:
>> +
>> +- fetch (or pull) from a repository
>> +- push to another repository
> 
> [...]
> 
> I find Michael Haggerty's definition of triangular workflow much
> clearer:
> 
> https://github.com/blog/2042-git-2-5-including-multiple-worktrees-and-triangular-workflows#improved-support-for-triangular-workflows
> 
> I don't see a licence on the GitHub blog, so I don't think it's legal to
> copy-past directly to our docs, but Michael might allow us to do so?

I'm glad you find that blog post useful!

You are correct that the text of GitHub blog posts is copyrighted, so
indeed you need to ask before using it.

It is OK with me (and more importantly with GitHub, because I wrote this
text in their employ) for you to use the text about triangular workflows
from the blog post mentioned above under the Git project's license.

I strongly suggest that you adapt it to make it fit better with the rest
of the Git documentation, and because having verbatim copies of the same
text in two places seems a little bit silly. But that's up to you.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael
