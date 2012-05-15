From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Tue, 15 May 2012 08:43:29 +0200
Message-ID: <4FB1FB11.70209@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox> <4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer> <4FAC0633.90809@alum.mit.edu> <20120511171230.GA2107@tgummerer> <4FB01080.6010605@alum.mit.edu> <20120514150113.GD2107@tgummerer> <4FB1746A.6090408@alum.mit.edu> <87bolqtnva.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 15 08:50:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUBaw-0007Kq-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 08:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447Ab2EOGuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 02:50:44 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:56837 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756032Ab2EOGuk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 02:50:40 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 May 2012 02:50:40 EDT
X-AuditID: 1207440c-b7fc26d0000008c0-d0-4fb1fb19782b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C0.3F.02240.91BF1BF4; Tue, 15 May 2012 02:43:38 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4F6hTT1016642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 May 2012 02:43:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <87bolqtnva.fsf@thomas.inf.ethz.ch>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsUixO6iqCv1e6O/wa7bjBaPTm5msui60s1k
	0dB7hdniR0sPs8X8QxNZLS6svs1usXLXQiYHdo+ds+6yeyzYVOrxrHcPo8fFS8oef87vYfWY
	+2kRq8fnTXIB7FHcNkmJJWXBmel5+nYJ3Bn/515kKrjNVfFl6VqmBsZtHF2MnBwSAiYSsybu
	Z4OwxSQu3FsPZHNxCAlcZpT4fGwxC4RznEni9L+3rF2MHBy8ApoSNy9qgTSwCKhKrL28mRnE
	ZhPQlVjU08wEUiIqECax+oEGSJhXQFDi5MwnLCC2iIC6xMd1rUwgNrPAPEaJ1qn5IOXCAjIS
	G9Z7QWxaxSxx/9dVsHs4BQwk/k09BTaSWcBa4tvuIohWeYntb+cwT2AUmIVkwyyEqllIqhYw
	Mq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3ECIkBnh2M39bJHGIU4GBU4uF9
	tWajvxBrYllxZe4hRkkOJiVRXttvQCG+pPyUyozE4oz4otKc1OJDjBIczEoivJNagHK8KYmV
	ValF+TApaQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4OJQle519AjYJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgGI0vBkYpSIoHaG/PT5C9xQWJuUBRiNZTjLocMz4tusYoxJKX
	n5cqJc6bCrJDAKQoozQPbgUs4b1iFAf6WJg3AaSKB5gs4Sa9AlrCBLSEX2AdyJKSRISUVAPj
	zGyeEJ/TE3bWHRVeX9fN/yrz2s5Stid3eSrDah9U/lNuPSc9Kdb4ktHE+1y84r6T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197822>

On 05/15/2012 12:10 AM, Thomas Rast wrote:
> Michael Haggerty<mhagger@alum.mit.edu>  writes:
>> 9. read_files() doesn't need to return "entries".  Since entries is an
>> array that is only mutated in place, the return value will always be
>> the same as the "entries" argument (albeit fuller).
>
> (Ab)using an array in this fashion is somewhat iffy.  It seems
> unavoidable in this case (while still retaining the runtime), but try
> not to do it too often, and perhaps name the parameter something that
> makes this clear (such as 'out').  Usually changing it to use a
> generator function (with 'yield') helps.

If the goal were an ideal Python program, then by all means generators 
are the way to go.  But since the goal is a prototype for a C program, 
then a change to using generators would just have to be undone when 
converting to C.

>> 11. It is good form to move the file-level code into a main()
>> function, then call that from the bottom of the file, something like
>> this:
>>
>>> def main(args):
>>>      ....
>>>
>>> main(sys.argv[1:])
>
> It's customary to wrap it as
>
> if __name__ == '__main__':
>      main(sys.argv[1:])
>
> That way your script becomes 'import'-able, which can be handy (if only
> for testing).

+1

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
