From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Sat, 19 May 2012 07:40:56 +0200
Message-ID: <4FB73268.4020204@alum.mit.edu>
References: <20120508141137.GA3937@tgummerer.surfnet.iacbox> <4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer> <4FAC0633.90809@alum.mit.edu> <20120511171230.GA2107@tgummerer> <4FB01080.6010605@alum.mit.edu> <20120514150113.GD2107@tgummerer> <4FB1746A.6090408@alum.mit.edu> <20120515134916.GA2074@tgummerer.unibz.it> <4FB334C7.2070201@alum.mit.edu> <20120516215407.GA1738@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 07:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVcWU-0006PZ-6l
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 07:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab2ESFsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 01:48:09 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:58341 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751366Ab2ESFsG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 01:48:06 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 May 2012 01:48:06 EDT
X-AuditID: 12074412-b7f1c6d00000092d-28-4fb7326d8242
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 73.75.02349.D6237BF4; Sat, 19 May 2012 01:41:01 -0400 (EDT)
Received: from [192.168.2.130] (p4FC0C79F.dip.t-dialin.net [79.192.199.159])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4J5evHc001400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 19 May 2012 01:40:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120516215407.GA1738@tgummerer.surfnet.iacbox>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqJtrtN3f4GC/hMWjk5uZLLqudDNZ
	NPReYbb40dLDbDH/0ERWiwurb7NbrNy1kMmB3WPnrLvsHgs2lXo8693D6HHxkrLHn/N7WD3m
	flrE6vF5k1wAexS3TVJiSVlwZnqevl0Cd8asnvKCPVIVG66fYW5gnCLaxcjJISFgIvHt0HF2
	CFtM4sK99WxdjFwcQgKXGSUOLDzBAuGcYZK4t/8UWBWvgLbEymdP2UBsFgFViW0Lv4LZbAK6
	Eot6mpm6GDk4RAXCJFY/0IAoF5Q4OfMJC4gtIqAlMelrHyuIzSzQwijxel4ESLmwgIzEhvVe
	EKvmMkucnNYAVsMpYCsx//IZVpAaZgFriW+7iyBa5SW2v53DPIFRYBaSDbMQqmYhqVrAyLyK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyQGhHYwrj8pd4hRgINRiYf30qRt
	/kKsiWXFlbmHGCU5mJREeWMMt/sL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuF9qwuU401JrKxK
	LcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4F0BMlSwKDU9tSItM6cEIc3EwQky
	nEtKpDg1LyW1KLG0JCMeFKPxxcAoBUnxAO29DNLOW1yQmAsUhWg9xWjM8efhomuMHDM+AUkh
	lrz8vFQpcd7VIKUCIKUZpXlwi2DJ7xWjONDfwrx7Qap4gIkTbt4roFVMQKsq2baBrCpJREhJ
	NTAWS53/8rbz0AF105kzP92S4yvufxx/qjWe7+ck7UNV+05pLZgmNeOSRPhFu9eL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198016>

On 05/16/2012 11:54 PM, Thomas Gummerer wrote:
> On 05/16, Michael Haggerty wrote:
>> I just reviewed version 1369bd855b86 of your script, and it is MUCH
>> better.  It's easy to read and review.  The functions that it
>> defines are now self-contained and could therefore be reused for
>> other purposes.  There are fewer magic numbers (though there are
>> still a few; I wonder if there is a way to get rid of those?)
>> You've done a nice job polishing up the code.
>
> Thanks for the feedback! I could get rid of the magic numbers for
> the crc code, but I'm not sure if it makes sense to replace the
> others with constants, since they only occur once in the file. I
> added comments instead explaining where those numbers come from
> instead.

I think it is possible to remove the last magic number and also to make 
the CRC handling easier.  I have pushed some suggested changes to github 
[1]:

1. With the current code, trying to read a file that is less than 24 
bytes long would result in a struct.error (because it would try to 
unpack a string that is shorter than the struct) whereas the underlying 
error in this case should almost always be reported as a signature 
error.  So it is correct to read the signature separately from the rest 
of the header, but it is even more correct to check the signature 
(including its length) before reading on.

2. I introduce a class CRC to hold checksums, so that (a) the code for 
handling checksums can be encapsulated, and (b) an instance of this 
class can be passed into functions and mutated in-place, which is less 
cumbersome than requiring functions to return (data, crc) tuples.  This, 
in turn, makes possible...

3. ...a new function read_struct(f, s, crc), which reads the data for a 
struct.Struct from f, checksums it, and returns the unpacked data.  This 
function is more convenient to use than the old read_calc_crc().

4. The checksum instance can also be made responsible for verifying that 
the next four bytes in the file agree with the expected checksum.  This 
removes some more code duplication.  (See CRC.matches().)

5. You read the extension offsets using CRC_STRUCT.size, which is 
technically correct but misleading.  In fact, the extension offsets 
should be documented using their own EXTENSION_INDEX_STRUCT.  Also, it 
makes more sense to store the unpacked integer offsets to extoffsets 
rather than the raw 4-byte strings.

6. With a couple of more minor changes it is possible to replace the 
magic number "24" in read_index_entries().  With this change the 
computation is documented very explicitly and is also (somewhat) robust 
against future changes in the format.

Look over my changes and take whatever you want.

> Thanks, I have changed those. I added the docstrings for all read
> functions, they however don't seem to make sense for the print
> functions, since you're probably faster just reading the code for
> them.

That's fine.  If you document nontrivial functions you are already doing 
much better than the git project average.

> One since I changed in addition is to those changes, is that I
> gave the exceptions names to make them more meaningful.

Good.

Michael

[1] https://github.com/mhagger/git/tree/pythonprototype

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
