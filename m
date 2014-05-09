From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v1 23/25] contrib: remove 'hooks/multimail'
Date: Fri, 09 May 2014 17:00:43 +0200
Message-ID: <536CED9B.3080706@alum.mit.edu>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com> <1399597116-1851-24-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 17:00:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimI7-0000Db-ON
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810AbaEIPAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:00:47 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62403 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755841AbaEIPAr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 11:00:47 -0400
X-AuditID: 1207440f-f79326d000003c9f-b1-536ced9d8e5d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 55.F6.15519.D9DEC635; Fri,  9 May 2014 11:00:46 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2E4D.dip0.t-ipconnect.de [93.219.46.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s49F0h60026864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 9 May 2014 11:00:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399597116-1851-24-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqDvvbU6wQd9yJouDj/Msuq50M1k0
	9F5hdmD22DnrLrvHxUvKHp83yQUwR3HbJCWWlAVnpufp2yVwZ8yY4Fbwl71iR99H9gbGg2xd
	jJwcEgImEnd6TzJB2GISF+6tB4pzcQgJXGaUmLH9ACOEc5ZJ4ty1D2BVvALaEtMObWAHsVkE
	VCX+vm1gBrHZBHQlFvU0A9VwcIgKBEn8OasIUS4ocXLmExYQW0TATaLt9EGwMcwCahKHljxi
	BLGFBewlft2YwwSxq4NRonHbErCZnALeEleutbKCzJQQEJfoaQyC6NWReNf3gBnClpfY/nYO
	8wRGwVlI1s1CUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCHh
	zL+DsWu9zCFGAQ5GJR5eidc5wUKsiWXFlbmHGCU5mJREeUW3AIX4kvJTKjMSizPii0pzUosP
	MUpwMCuJ8GoeBsrxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4o98A
	NQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSD4je+GBjBICkeoL08IO28xQWJuUBR
	iNZTjLocFxpWtDAJseTl56VKifO+AflFAKQoozQPbgUseb1iFAf6WJg3EWQUDzDxwU16BbSE
	CWiJr342yJKSRISUVAOjldTSqfz3gyri7qwJKIk79cnm+YdOnob70iye6dPqE9LZebOVmGeJ
	b2P9kMbh1S3S6TZ375SpN8MNNSpdmD6Wx/ILOTzNzzsqvO391XmHuTjP1slPWdfz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248564>

On 05/09/2014 02:58 AM, Felipe Contreras wrote:
> No tests. No chance of ever graduating.
> 
> Already out-of-tree.
> 
> Cc: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Thank you for your input.

git-multimail is maintained outside of the Git project and is only
distributed along with Git as a convenience to Git users.  It does in
fact have a test suite, along with some other bits and bobs that are not
needed to use it, in the upstream repository at

    https://github.com/mhagger/git-multimail

What's more, it has a maintainer who doesn't routinely insult other
people on the mailing list, conduct endless and pointless flame wars,
think that he is superior to everybody in sight, and throw temper
tantrums when his rudeness, argumentativeness, and arrogance for some
reason don't win the hearts and minds of other contributors.

Cheers,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
