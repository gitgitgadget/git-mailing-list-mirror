From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Sun, 13 May 2012 21:50:24 +0200
Message-ID: <4FB01080.6010605@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox> <4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer> <4FAC0633.90809@alum.mit.edu> <20120511171230.GA2107@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 21:58:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STewG-0003Ez-7S
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 21:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab2EMT6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 15:58:39 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:43920 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752612Ab2EMT6i (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 15:58:38 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 May 2012 15:58:38 EDT
X-AuditID: 1207440f-b7fe16d000000920-0c-4fb010c85b66
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 36.B6.02336.8C010BF4; Sun, 13 May 2012 15:51:36 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0AF35.dip.t-dialin.net [79.192.175.53])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4DJoPaY009814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 13 May 2012 15:50:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120511171230.GA2107@tgummerer>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsUixO6iqHtCYIO/weuD0haPTm5msui60s1k
	0dB7hdniR0sPs8X8QxNZLS6svs1usXLXQiYHdo+ds+6yeyzYVOrxrHcPo8fFS8oef87vYfWY
	+2kRq8fnTXIB7FHcNkmJJWXBmel5+nYJ3BmTZ6xhLdiiULG9/RJrA+NZyS5GTg4JAROJabOv
	MEHYYhIX7q1n62Lk4hASuMwocejbJTaQhJDAGSaJw63BIDavgLbEtdbNLCA2i4CqRNfkmcwg
	NpuArsSinmagQRwcogJhEqsfaECUC0qcnPkErFxEQEti0tc+VhCbWaCFUeL1vAiQcmEBGYkN
	670g1i5hknix4ik7SA2ngJ7ErC3zWEFqmAWsJb7tLoJolZfY/nYO8wRGgVlINsxCqJqFpGoB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJAY4N/B2LVe5hCjAAejEg/v
	AtH1/kKsiWXFlbmHGCU5mJREedN5N/gL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFd/xConDcl
	sbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEkwdvODzRUsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhSj8cXAKAVJ8QDtbQVp5y0uSMwFikK0nmLU5ZjxadE1RiGW
	vPy8VClx3iqQIgGQoozSPLgVsIT3ilEc6GNh3hSQKh5gsoSb9ApoCRPQEn6BdSBLShIRUlIN
	jG1WZpclt7okbt/xR/zu6sN3Tq23nX3ccN+2DXfOZNTO5Q7a1e7L/Op352wXt53u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197753>

On 05/11/2012 07:12 PM, Thomas Gummerer wrote:
> Thanks for your feedback! To get clearer code I've now written a
> working reader for the v5 index format in Python. The full reader
> would probably be to long for the mailing list, but here is the
> interesting part:
>
> [...]
> The full reader can be found here:
> https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py

Good.

I tried to review your code 3fe08f9b:git-read-index-v5.py and compare it 
to your file spec f858cf6a9:Index-format-v5.textile.  I have the 
following comments (some of them already discussed in IRC):

1. Your script seems to be reading a different version of the file than 
described in the spec.  [When I mentioned this on IRC you pushed a new 
version a4ee558ea of the spec.]

2. Your script seems to assume that the index file has no extensions. 
It would be better (for documentation purposes and to ensure that there 
are no surprises) to make sure that the code knows how to handle extensions.

3. Please document briefly how the scripts should be used.

4. Please limit line length to 80 columns (like the main git project).

5. Python has a nicer way to initialize dictionaries whose keys are all 
valid identifiers; for example:

-        return dict({"signature": signature, "vnr": header[0], "ndir": 
header[1], "nfile": header[2], "next": header[3]})
+        return dict(signature=signature, vnr=header[0], ndir=header[1],
+                    nfile=header[2], next=header[3])

6. Some of your print statements are just begging to be written using 
string interpolation; e.g.,

-        print d["pathname"] + " " + str(d["flags"]) + " " + 
str(d["foffset"]) + " " + str(d["cr"]) + " " + str(d["ncr"]) + " " + 
str(d["nsubtrees"]) + " " + str(d["nfiles"]) + " " + str(d["nentries"]) 
+ " " + str(binascii.hexlify(d["objname"]))
+        print ("%(pathname)s %(flags)s %(foffset)s %(cr)s %(ncr)s "
+               "%(nsubtrees)s %(nfiles)s %(nentries)s " % d
+               + str(binascii.hexlify(d["objname"])))

printheader() can be rewritten similarly.

7. You have a couple of while loops that would be easier to read if 
written as for loops.

8. There is no need to use global variables.  Global variables have lots 
of disadvantages, one of which is that it is hard to tell what functions 
have side effects via the global variables.  It is better to pass the 
needed variables explicitly to functions that need them.

9. ...after you eliminate the global variables, you will see that the 
checksums are mostly needed over limited areas of code then can be 
discarded.  Rewriting the checksum handling in this way would make it 
easier to see exactly what range of bytes is included in a particular 
checksum.

10. There is no need to keep track of all of the data that will go into 
a checksum.  The CRC32 checksum can be computed incrementally via the 
second argument of binascii.crc32(data, crc).  Therefore, you only need 
to retain a 32-bit running checksum instead of the filedata array of 
data strings.

11. It is bad style to generate output from within the 
readindexentries() function.  Given that it reads the whole array of 
file entries anyway, it would be cleaner to return the array to the 
caller and let the caller print out what it wants.

12. Your handling of checksum errors is inconsistent.  In some places 
you generate exceptions; in another you simply print an error to stdout 
(not stderr!) and proceed to use the corrupt data.

13. It is probably clearer to unpack the tuples returned by 
struct.unpack() directly into local variables with meaningful names 
instead of carrying them around as a tuple; e.g.,

-    header = struct.unpack('!IIII', checksum.add(f.read(16)))
+    (vnr, ndir, nfile, next) = struct.unpack('!IIII', fread(16))

14. It is more correct to check the file signature and version 
explicitly before plowing into the rest of the file (that's what they're 
there for!)

That's as far as I've got.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
