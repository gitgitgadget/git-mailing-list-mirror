From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Branch Name Case Sensitivity
Date: Thu, 27 Feb 2014 22:00:43 +0100
Message-ID: <530FA77B.2030707@alum.mit.edu>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com> <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com> <530FA0C1.3000109@web.de> <CAJHY66H2M2aQvQ8MLN7XB4uYiFohRfhhsXhd56hwDR5qMGi6Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 22:00:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ84d-00047W-KV
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 22:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbaB0VAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 16:00:51 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57152 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751072AbaB0VAr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 16:00:47 -0500
X-AuditID: 12074411-f79ab6d000002f0e-1e-530fa77e6d03
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DD.E3.12046.E77AF035; Thu, 27 Feb 2014 16:00:46 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RL0hVi022019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 16:00:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAJHY66H2M2aQvQ8MLN7XB4uYiFohRfhhsXhd56hwDR5qMGi6Tg@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqFu3nD/YoOWwtUXXlW4mi4beK8wW
	a57/ZrLo7PjK6MDisXPWXXaPi5eUPT5vkvO4/WwbSwBLFLdNUmJJWXBmep6+XQJ3xqHFk1gL
	1nJX/Jj5nL2BcSpnFyMnh4SAicTlLaeYIWwxiQv31rOB2EIClxklWg7GQdjnmSTWr3AGsXkF
	tCW2f1zJBGKzCKhKHNv/nxHEZhPQlVjU0wwWFxUIllh9+QELRL2gxMmZT8BsEQFliWVnW4Hm
	c3AwC9RKnN0SBRIWFtCUuHrhFVAJF9Cqe4wSJz/eB6vhFAiU2LGbCcSUEBCX6GkMAilnFtCR
	eNf3gBnClpfY/nYO8wRGwVlIls1CUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqm
	ermZJXqpKaWbGCEBLriDccZJuUOMAhyMSjy8Ezz5g4VYE8uKK3MPMUpyMCmJ8nJOAQrxJeWn
	VGYkFmfEF5XmpBYfYpTgYFYS4fWdA5TjTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1I
	LYLJynBwKEnw1iwDahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxW58MTB6QVI8
	QHsFQNp5iwsSc4GiEK2nGHU5brf9+sQoxJKXn5cqJc7bvhSoSACkKKM0D24FLJ29YhQH+liY
	txhkFA8wFcJNegW0hAloyVFpHpAlJYkIKakGxvTYedoqT6zflczvFrMQk5nsH3v51R+jP5+n
	5sXXHray41jvGFEg9Ua7fNnSNQ0b1RJ/hed+O/DhyjzRGKu7gXNPZ8dPUD1bv79s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242858>

On 02/27/2014 09:37 PM, Lee Hopkins wrote:
>> Perhaps git-{branch,tag}.txt and possibly gitrepository-layout.txt
>> in Documentation/ may need a new "*Note*" section to warn against
>> this.
> 
> A little more documentation never hurt anyone :).
> 
>> Or we can possibly trigger this function at the the of
>> "checkout -b" or "fetch" commands ?
>> Only when core.ignorecase == true ?
> 
> This would essentially make git always use packed-refs when
> core.ignorecase == true, correct? Are there any downsides to always
> using packed-refs?

There are at least two reasons I can think of:

1. Efficiency: any time a reference changes, the whole packed-refs file
would have to be read and written as opposed to a single, small
loose-ref file.

2. Lock contention: two processes can modify loose references at the
same time without contending with each other.  If they always wrote the
packed-refs file, there would be more lock contention (which in the git
world means that one of the processes would fail).

Whether these are concern for a single user using a local git repository
(as opposed to git running on a server) mostly depends on how many
references you have.  With a hundred references you would probably not
notice any difference.  With ten thousand you probably would.  Somewhere
in between lies the pain threshold.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
