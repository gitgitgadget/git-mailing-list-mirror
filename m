From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 10:13:39 +0100
Message-ID: <53105343.2040703@alum.mit.edu>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com> <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com> <530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com> <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6?= =?ISO-8859-1?Q?gershausen?= 
	<tboegi@web.de>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJW4-0004qJ-7r
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbaB1JNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:13:53 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57863 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751163AbaB1JNo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 04:13:44 -0500
X-AuditID: 1207440e-f79c76d000003e2c-ca-53105346802d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E5.8F.15916.64350135; Fri, 28 Feb 2014 04:13:43 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1S9Demv021194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 04:13:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqOseLBBs8KnKoutKN5NFQ+8VZouF
	/46yW6x5/pvJorPjK6MDq8fOWXfZPS5eUvb4vEnO4/azbSwBLFHcNkmJJWXBmel5+nYJ3Blt
	DzexFqzgqHjX+pOtgfE6WxcjJ4eEgInEn4dLmCFsMYkL99YDxbk4hAQuM0o0XG1lB0kICZxj
	kjhyIAHE5hXQlrjy+ylYA4uAqsTbm4vABrEJ6Eos6mlmArFFBYIlVl9+wAJRLyhxcuYTMFtE
	QFli2dlWsAXMAocZJVp2bWcFSQgLaEpcvfCKBWLzb0aJ7a8WgU3iFAiU2Lr4LFARB9B54hI9
	jUEgYWYBHYl3fQ+YIWx5ie1v5zBPYBSchWTfLCRls5CULWBkXsUol5hTmqubm5iZU5yarFuc
	nJiXl1qka6yXm1mil5pSuokREvB8Oxjb18scYhTgYFTi4Z3gyR8sxJpYVlyZe4hRkoNJSZRX
	yU8gWIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb547UI43JbGyKrUoHyYlzcGiJM6rtkTdT0gg
	PbEkNTs1tSC1CCYrw8GhJMGrHQTUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K
	4fhiYBSDpHiA9koFguwtLkjMBYpCtJ5i1OW43fbrE6MQS15+XqqUOO9akCIBkKKM0jy4FbD0
	9opRHOhjYV4PkEt4gKkRbtIroCVMQEs4PcGWlCQipKQaGHtXOwj8//R556pS7bnJ4etDT6jP
	Vgrj4BPxCSkvXRly53P3YbfjFdvUbDuuGm26cLi+hPO98flNNwW7ZC6bdHb5i7Ud 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242916>

On 02/28/2014 12:38 AM, Lee Hopkins wrote:
> [...] Based Michael Haggerty's response, it seems that always
> using loose refs would be a better workaround.

No, I answered the question "what would be the disadvantages of using
only packed refs?".  Now I will answer the question "what would be the
disadvantages of using only loose refs?":

1. Efficiency.  Any time all of the references have to be read, loose
refs are far slower than packed refs.

2. Disk space and inode usage: loose refs consume one inode and one disk
sector (typically 4k) each, whereas packed refs consume only one inode
in total, and many packed refs can fit into each disk sector.

After all, there is a reason that we have both packed refs and loose
refs.  The basic idea is to use packed refs for the bulk of references,
especially "cold" references like tags that only change infrequently,
but to store "hot" references as loose refs so that they can be modified
cheaply.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
