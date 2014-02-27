From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git in GSoC 2014
Date: Thu, 27 Feb 2014 21:26:01 +0100
Message-ID: <530F9F59.4030307@alum.mit.edu>
References: <20140225154158.GA9038@sigill.intra.peff.net> <530CCFB0.5050406@alum.mit.edu> <20140226102350.GB25711@sigill.intra.peff.net> <530DC4D1.4060301@alum.mit.edu> <xmqq8usx4pvh.fsf@gitster.dls.corp.google.com> <530EEAA2.3030306@alum.mit.edu> <xmqqlhwwz7m7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:26:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7X2-0004Bw-GH
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbaB0U0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 15:26:08 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54435 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbaB0U0G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 15:26:06 -0500
X-AuditID: 1207440e-f79c76d000003e2c-79-530f9f5d512a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B5.0E.15916.D5F9F035; Thu, 27 Feb 2014 15:26:05 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RKQ2te020339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 15:26:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqlhwwz7m7.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqBs7nz/YYP48QYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BkL5nxiKbjEUXF0qXUD4xO2
	LkZODgkBE4kT/25B2WISF+6tB7K5OIQELjNKvDnaww7hnGeSuHFkOitIFa+AtsTabUfZQWwW
	AVWJNyv+MYHYbAK6Eot6msFsUYFgidWXH7BA1AtKnJz5BMwWEVCTmNh2CMjm4GAWMJKYd7oe
	JCwsICtx/95qqMXLmCTmPF7GDJLgFLCW+PzyFjNIvYSAuERPYxBImFlAR+Jd3wNmCFteYvvb
	OcwTGAVnIdk2C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKE
	BDTfDsb29TKHGAU4GJV4eCd48gcLsSaWFVfmHmKU5GBSEuXlnAIU4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJMLrOwcox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4C2Y
	B9QoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rf+GJgBIOkeID2BoC08xYXJOYC
	RSFaTzHqctxu+/WJUYglLz8vVUqc1xqkSACkKKM0D24FLH29YhQH+liY1wKkigeY+uAmvQJa
	wgS05Kg0D8iSkkSElFQDY3PcjZjAP4Eel2KmSs5PXGh4RPJFoMLBPsfH7kv/b475bjDlOcd/
	rmNKfksc3k2d/9i2s+mLj/ER7wdXOmwuLcjZlB4dejy9X9W/ec2RA/prf71hdro8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242850>

On 02/27/2014 08:19 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Sounds good.  I suggest we make your blob a paragraph before the list of
>> bullet points rather than part of the list.  Please suggest some "TBD*"
>> then I'll add it to the text.  Would we also fill in "X" with the name
>> of the actual student involved in the conversation that is pointed to?
> 
> I was not thinking about using a student thread (I do not remember
> having a good on-list interaction with past GSoC students).
> 
> How about using this one from our recent past:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/239068
> 
> which has the following good points to be used as an example.  It:
> 
>  - involved multiple cycles and multiple reviewers;
> 
>  - showed good response to the comments from the original author;
>    and most importantly
> 
>  - had everything related to the topic in one single neat thread.
> 

Change pushed.  Thanks Junio!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
