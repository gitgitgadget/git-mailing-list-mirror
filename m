From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Mar 2014, #05; Mon, 24)
Date: Tue, 25 Mar 2014 12:01:11 +0100
Message-ID: <533161F7.5010508@alum.mit.edu>
References: <xmqqr45rpcjm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Adam <adam@sigterm.info>
X-From: git-owner@vger.kernel.org Tue Mar 25 12:01:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSP6f-0005Fu-IA
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 12:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbaCYLBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 07:01:16 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62946 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbaCYLBP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 07:01:15 -0400
X-AuditID: 12074414-f79d96d000002d2b-ef-533161fac580
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.C5.11563.AF161335; Tue, 25 Mar 2014 07:01:14 -0400 (EDT)
Received: from [192.168.69.148] (p57A25AC4.dip0.t-ipconnect.de [87.162.90.196])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2PB1C7d027380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 25 Mar 2014 07:01:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqr45rpcjm.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqPsr0TDYYO8WRYvNneIWXVe6mSwa
	eq8wOzB7XLyk7DH72E9Wj8+b5AKYo7htkhJLyoIz0/P07RK4M9b9Ky5Yw1Ix80JwA+Mh5i5G
	Tg4JAROJW5v/MUHYYhIX7q1n62Lk4hASuMwo0TX7GSOEc55JYtHtBSwgVbwC2hJLd1wD62AR
	UJVovLgYLM4moCuxqKcZLC4qECyx+vIDqHpBiZMzn4DZIgIOEhuWrAUaysHBLCAu0f8PLCws
	YC/xbnkD2EFCAlYSLeuOsIHYnALWEkse3WEGKZcAKu9pDAIJMwvoSLzre8AMYctLbH87h3kC
	o+AsJMtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdC73czBK91JTSTYyQUBbZ
	wXjkpNwhRgEORiUe3ghjg2Ah1sSy4srcQ4ySHExKoryyUYbBQnxJ+SmVGYnFGfFFpTmpxYcY
	JTiYlUR4DcOAcrwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErwmwJgV
	EixKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFbnwxMHpBUjxAe2/Eg+wtLkjMBYpC
	tJ5iNOa4tWFNIxPHhm1AUoglLz8vVUqcVx1kkwBIaUZpHtwiWBJ7xSgO9LcwrwdIFQ8wAcLN
	ewW0igloVXiTHsiqkkSElFQD48LLC+bpW8eUMssub7mWufnSllmKDnfXVd32ndAdmbqgMmT2
	/EyRGdsuPZ51a1eFDc/asEsPe9gmnr26/mPY9Py3xic0fk5J79GT0vv6ru3KnRXm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245026>

On 03/24/2014 09:27 PM, Junio C Hamano wrote:
> [...]
> * an/branch-config-message (2014-03-24) 1 commit
>  - branch.c: install_branch_config: simplify if chain
> 
>  Will merge to 'next'.

The Signed-off-by line in this commit shows the name as only "Adam".
Adam, unless this is your full name, please add a S-o-b line with your
full name as per Documentation/SubmittingPatches.  This is important to
help us track the provenance of all code in Git.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
