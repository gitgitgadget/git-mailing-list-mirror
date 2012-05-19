From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Sat, 19 May 2012 15:00:59 +0200
Message-ID: <4FB7998B.2030305@alum.mit.edu>
References: <20120508141137.GA3937@tgummerer.surfnet.iacbox> <4FAA2CAF.3040408@alum.mit.edu> <20120510121911.GB98491@tgummerer> <4FAC0633.90809@alum.mit.edu> <20120511171230.GA2107@tgummerer> <4FB01080.6010605@alum.mit.edu> <20120514150113.GD2107@tgummerer> <4FB1746A.6090408@alum.mit.edu> <20120515134916.GA2074@tgummerer.unibz.it> <4FB2700D.5000900@alum.mit.edu> <20120518153826.GB1738@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 15:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVjOk-0007TA-Dh
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 15:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab2ESNIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 09:08:10 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:55235 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754836Ab2ESNIH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 09:08:07 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 May 2012 09:08:07 EDT
X-AuditID: 12074412-b7f1c6d00000092d-f3-4fb7998fe42a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 87.8C.02349.F8997BF4; Sat, 19 May 2012 09:01:03 -0400 (EDT)
Received: from [192.168.2.130] (p4FC0C79F.dip.t-dialin.net [79.192.199.159])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4JD10Fs016310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 19 May 2012 09:01:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120518153826.GB1738@tgummerer.surfnet.iacbox>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqNs/c7u/weFzKhaPTm5msui60s1k
	0dB7hdniR0sPs8X8QxNZLS6svs1usXLXQiYHdo+ds+6yeyzYVOrxrHcPo8fFS8oef87vYfWY
	+2kRq8fnTXIB7FHcNkmJJWXBmel5+nYJ3BkrP/9iLJivU3Gx4ydTA+M0pS5GTg4JAROJrTNv
	s0HYYhIX7q0Hsrk4hAQuM0r8f/+UBcI5wySxcMdE9i5GDg5eAW2J9rYikAYWAVWJG5tXMYHY
	bAK6Eot6mplASkQFwiRWP9AACfMKCEqcnPmEBcQWEdCSmPS1jxXEZhZoYZR4PS8CpFxYQEZi
	w3oviE1zmSUmnl0NVsMpYCtx5vIRsK3MAtYS33YXQbTKS2x/O4d5AqPALCQbZiFUzUJStYCR
	eRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSAwI7WBcf1LuEKMAB6MSD++l
	Sdv8hVgTy4orcw8xSnIwKYny9k7a7i/El5SfUpmRWJwRX1Sak1p8iFGCg1lJhHeFJ1CONyWx
	siq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mC99UMoEbBotT01Iq0zJwShDQT
	ByfIcC4pkeLUvJTUosTSkox4UIzGFwOjFCTFA7T3AUg7b3FBYi5QFKL1FKMxx5+Hi64xcsz4
	BCSFWPLy81KlxHm3gJQKgJRmlObBLYIlv1eM4kB/C/M+AqniASZOuHmvgFYxAa2qZNsGsqok
	ESEl1cCYuK/uZoHbQxXnxMenWJa6pgRMry6zTSwufXr/j4ZIudV+xrbD/GkPZi9j 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198029>

On 05/18/2012 05:38 PM, Thomas Gummerer wrote:
>
>> I suggest that you apply the same kinds of cleanups to
>> git-convert-index.py (which I personally haven't looked at yet at
>> all).  If you want my feedback on that script, please let me know
>> when you think it is ready.
>
> That would be great, if you have the time to do it. I'm not
> completely finished with it (docstrings and conflicted data writing
> are still missing).

I've looked over the writing side of git-convert-index.py version
81411fe6c98, and here are my first comments:

* Please remove trailing whitespace from the source code.

* I suggest that you move constants and code shared by
   git-convert-index.py and git-read-index-v5.py into a library.  Though
   actually, given that git doesn't seem to have infrastructure for
   dealing with Python libraries, this might take some improvisation.

* Please use constants for all of the struct formats.  Constants have
   names, making them mostly self-documenting.

* write_directories() currently writes pathnames and fake data and
   stores file offsets in memory.  Later write_directory_data() runs
   through the file again, seek()ing over the filenames and filling in
   real data.

   Wouldn't it be easier for the first pass just to *compute* and
   record the offsets of the entries to RAM, without writing anything
   to disk, and leave all of the writing to the second pass?

* Instead of writing blank data, it is possible to seek() past it and
   start writing the next thing.  The skipped-over file contents are
   logically initialized to zero.

* When working with iteritems(), it is clearer to unpack the item
   pairs and give them names rather than working with d[0] and d[1];
   for example,

     -    for d in sorted(dirdata.iteritems()):
     +    for (pathname,entry) in sorted(dirdata.iteritems()):

* write_directories() returns a "dirdata" that is just an empty
   defaultdict.  This seems pointless.  Do you have future plans to
   change write_directories() to store something into the dictionary?

* The documentation for binascii.crc32() mentions that it gives
   inconsistent results (signed vs. unsigned) for different versions of
   Python.  Please ensure that you are using it in a way that is
   maximally portable.  (That seems to imply using (binascii.crc32(...)
   & 0xffffffff) and treating the result as unsigned.)

* At first I thought it was a little bit odd that you pass data
   structures around as dictionaries, but I didn't object.  But as I
   look at more and more code it seems more and more cumbersome.
   Therefore, I suggest that you define classes to hold the various
   entities that are manipulated by your programs, because:

   * A class definition is a good place to document exactly what fields
     an object is expected to have, and what they mean.

   * Access of instance fields (entry.path) is easier to read and type
     than dictionary access (entry["path"]).

   * The class definitions will translate pretty directly to C structs.

   The fact that class instances use a bit more memory than
   dictionaries is, I think, unimportant.  But if that really bothers
   you, you can use __slots__ to save some of the instance memory.

At a higher level:

* What if the offsets to each section were stored in the header, and
   the offsets recorded for dirs and files were relative to the start
   of the section (rather than relative to the start of the file)?  I
   think that this would leave open the possibility of formatting the
   sections in memory in parallel in a single pass, then dumping the
   sections to disk in a few big writes (though I'm not saying that this
   should be the *default* way of writing).

* Do you plan to write prototypes for some of the cool new
   functionality that v5 is intended to make possible?  For example,

   * reading a few specific entries out of an index file

   * updating single entries

   * adding/removing conflict data to an existing file

   * dealing with all of the issues that will come with supporting the
     mutation of an existing index file (i.e., locking, consistency
     checks, etc)

   As you probably know from discussions on IRC, I think that the last
   of these is the biggest risk to the success of the project.

> I'm not sure about the read_tree_extensiondata method, if I should
> extract a method, which only reads one entry, but I'm not sure that
> would make any sense, since there would be a lot of parameters and
> return values to the function.

If the index were represented by a class instance, then all of the 
information would be grouped together as a coherent whole that is easy 
to pass around.

> The same thing is in the main method, where I'm not sure if it's
> better to extract the read_index and write_index functions, or
> just leave the code in the main method. My guess is that it makes
> sense in the main method, since there are less calls, but it
> doesn't make sense in the read_tree_extensiondata method?

Ditto.

> Another thing I'm unsure about is the write_directory_data method,
> if there is any way to replace the try/except with something
> simpler?

With dictionaries, you can do

-        try:
-            flags = d[1]["flags"]
-        except KeyError:
-            flags = 0
+        flags = d[1].get("flags", 0)

If you convert to class instances, then presumably the constructor would 
set valid default values for all of the fields.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
