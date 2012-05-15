From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Tue, 15 May 2012 17:02:37 +0200
Message-ID: <4FB2700D.5000900@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox> <4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer> <4FAC0633.90809@alum.mit.edu> <20120511171230.GA2107@tgummerer> <4FB01080.6010605@alum.mit.edu> <20120514150113.GD2107@tgummerer> <4FB1746A.6090408@alum.mit.edu> <20120515134916.GA2074@tgummerer.unibz.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 17:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUJGy-0008C1-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 17:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132Ab2EOPCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 11:02:43 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53780 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107Ab2EOPCm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 11:02:42 -0400
X-AuditID: 1207440f-b7fe16d000000920-51-4fb27011dd5c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C8.D3.02336.11072BF4; Tue, 15 May 2012 11:02:41 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4FF2cZB015317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 May 2012 11:02:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120515134916.GA2074@tgummerer.unibz.it>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsUixO6iqCtYsMnfYPVBYYtHJzczWXRd6Way
	aOi9wmzxo6WH2WL+oYmsFhdW32a3WLlrIZMDu8fOWXfZPRZsKvV41ruH0ePiJWWPP+f3sHrM
	/bSI1ePzJrkA9ihum6TEkrLgzPQ8fbsE7owzG+cyFUwRrNh9/idzA+Mp3i5GTg4JAROJj6uv
	sUHYYhIX7q0Hsrk4hAQuM0q07zvLCOEcZ5I4tKSJGaSKV0BbonHVU9YuRg4OFgFViZ/vE0DC
	bAK6Eot6mplAwqICYRKrH2hAVAtKnJz5hAXEFhHQkpj0tY8VxGYWaGGUeD0vAqRcWEBGYsN6
	L4hNG5klNl2czQ5SwylgLnHo9yE2kBpmAWuJb7uLIFrlJba/ncM8gVFgFpINsxCqZiGpWsDI
	vIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJAb4dzB2rZc5xCjAwajEw/tq
	zUZ/IdbEsuLK3EOMkhxMSqK8Jjmb/IX4kvJTKjMSizPii0pzUosPMUpwMCuJ8IqZAeV4UxIr
	q1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK87PlAjYJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgGI0vBkYpSIoHaO/fPJC9xQWJuUBRiNZTjLocMz4tusYoxJKX
	n5cqJc77HqRIAKQoozQPbgUs4b1iFAf6WJj3D0gVDzBZwk16BbSECWhJWS7YkpJEhJRUA6N0
	9BP+j0uaHvAHFrzcstZJ70pHUkN4PcuPmQXH+rN7YzXlJP9fW3X2i/fpY1vedzTv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197834>

On 05/15/2012 03:49 PM, Thomas Gummerer wrote:
> Thanks again for your feedback. I've refactored the code again,
> thanks to your suggestions.

Good.  I'll try to review the new version as soon as possible.

I suggest that you apply the same kinds of cleanups to 
git-convert-index.py (which I personally haven't looked at yet at all). 
  If you want my feedback on that script, please let me know when you 
think it is ready.

 > If I'm correct it's fine to have the
> compiled structs global?

Yes, that's OK because they are constants so there is no risk of them 
propagating side-effects.  (Of course, Python doesn't enforce the 
constness of identifiers, but by convention ALL_CAPS identifiers are 
constants and it would be an obvious no-no to modify one.)

A real Pythonic solution would probably encapsulate all of your code 
(including the constants) in classes.  But since you will eventually 
translate the code to C, I don't think that step is crucial.  If, on the 
other hand, you propose to include Python scripts in the git 
distribution, then making them Pythonic would definitely be on the agenda.

>> What is your plan for testing this code, and later the C version?
>> For example, you might want to have a suite of index files with
>> various contents, and compare the "git ls-files --debug" output with
>> the output that is expected.  How would you create index files like
>> this?  Via git commands?  Or should one of your Python scripts be
>> taught how to do it?
>
> I thought of using real world examples for this, for example the
> WebKit index, which is pretty large, and some others, for example the
> git index and the linux kernel index.

It is good to do such manual tests, but you probably also want small, 
hand-constructed, automatable tests to make sure that all of the 
codepaths are exercised.  For example,

* A directory containing only files

* A directory containing only subdirectories

* A mixed directory whose last element is a file / last element is a 
subdirectory

* Various types of conflicts

...etc.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
