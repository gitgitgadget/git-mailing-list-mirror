From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 15:45:25 +0100
Message-ID: <5310A105.50403@alum.mit.edu>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com> <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com> <530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com> <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com> <53105343.2040703@alum.mit.edu> <CACsJy8B7fFBJ5ZbJDjGj4G6mx1byitC7BU4oJ3C0zq7cuv4fvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Lee Hopkins <leerhop@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:45:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOgw-0005tC-KX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbaB1Opb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:45:31 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51858 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751586AbaB1Opa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 09:45:30 -0500
X-AuditID: 12074414-f79d96d000002d2b-cc-5310a109ed05
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 09.F2.11563.901A0135; Fri, 28 Feb 2014 09:45:29 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SEjQVc001612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 09:45:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CACsJy8B7fFBJ5ZbJDjGj4G6mx1byitC7BU4oJ3C0zq7cuv4fvA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqMu5UCDY4MoBWYuuK91MFg29V5gt
	Fv47ym6x5vlvJovuKW8ZLTo7vjI6sHnsnHWX3ePiJWWPz5vkPG4/28YSwBLFbZOUWFIWnJme
	p2+XwJ3RM1+24CF/ReeBL4wNjNd4uhg5OSQETCQ+Puxkh7DFJC7cW8/WxcjFISRwmVHixOOX
	7BDOOSaJnUeaGEGqeAU0JRbcfAlUxcHBIqAqMftPEUiYTUBXYlFPMxOILSoQLLH68gMWiHJB
	iZMzn4DZIgJKEm86tjGDzGQWeMsocailkxkkIQw08+qFVywQyx4wSSyddh4swSkQKPFm8lSw
	ZRIC4hI9jUEgJrOAusT6eUIgFcwC8hLb385hnsAoOAvJulkIVbOQVC1gZF7FKJeYU5qrm5uY
	mVOcmqxbnJyYl5dapGuhl5tZopeaUrqJERL2IjsYj5yUO8QowMGoxMM7wZM/WIg1say4MvcQ
	oyQHk5Ior9c8gWAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzT5wPleFMSK6tSi/JhUtIcLEri
	vN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeFkXADUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWk
	FiWWlmTEg6I3vhgYvyApHqC9piDtvMUFiblAUYjWU4y6HLfbfn1iFGLJy89LlRLn/QlyuABI
	UUZpHtwKWJJ7xSgO9LEw7y2QF3iACRJu0iugJUxASzg9wZaUJCKkpBoYg6f0fZSz01RZ8+ae
	xuog3RJ35Z2yOpcit3a9Ncp68/P1t7xfkmfTylZHRNqcu/si/oJ2rZvl3OZCPov7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242970>

On 02/28/2014 03:31 PM, Duy Nguyen wrote:
> On Fri, Feb 28, 2014 at 4:13 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 02/28/2014 12:38 AM, Lee Hopkins wrote:
>>> [...] Based Michael Haggerty's response, it seems that always
>>> using loose refs would be a better workaround.
>>
>> No, I answered the question "what would be the disadvantages of using
>> only packed refs?".  Now I will answer the question "what would be the
>> disadvantages of using only loose refs?":
>>
>> 1. Efficiency.  Any time all of the references have to be read, loose
>> refs are far slower than packed refs.
>>
>> 2. Disk space and inode usage: loose refs consume one inode and one disk
>> sector (typically 4k) each, whereas packed refs consume only one inode
>> in total, and many packed refs can fit into each disk sector.
>>
>> After all, there is a reason that we have both packed refs and loose
>> refs.  The basic idea is to use packed refs for the bulk of references,
>> especially "cold" references like tags that only change infrequently,
>> but to store "hot" references as loose refs so that they can be modified
>> cheaply.
> 
> Could we have a staging place for new refs in between? Case
> sensitivity is just another limitation we hit because we rely on
> filesystem. We already have problems with having both refs foo and
> foo/bar at the same time. Not all repos are super busy and need the
> top efficiencies of loose refs.

True.  Nor should most people usually need the ability to run multiple
git commands simultaneously.

In fact, I've started working on a pluggable backend for reference
storage.  After that change, it should be easy to experiment with
different combinations of loose-only, packed-only, or other (new)
storage schemes that don't suffer from directory/file conflicts, etc.  I
haven't talked about this work on the list yet because it's still very
young.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
