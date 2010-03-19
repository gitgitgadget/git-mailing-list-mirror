From: david@lang.hm
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 10:02:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003190959410.10411@asgard.lang.hm>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com> <4BA3855A.1070005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 19 18:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsfaf-0007nt-Be
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 18:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab0CSRCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 13:02:23 -0400
Received: from mail.lang.hm ([64.81.33.126]:53251 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647Ab0CSRCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 13:02:22 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id o2JH2FE5020350;
	Fri, 19 Mar 2010 09:02:15 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <4BA3855A.1070005@alum.mit.edu>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142618>

On Fri, 19 Mar 2010, Michael Haggerty wrote:

> Michael Witten wrote:
>> On Fri, Mar 19, 2010 at 02:41, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Michael Witten wrote:
>>>> Rather than use a (name,email) pair to identify people, let's use
>>>> a (uuid,name,email) triplet.
>>>> [...]
>>> A UUID doesn't need to be a big hex number.  All it has to be is a
>>> "Universally Unique Identifier".  Like, oh, for example, your
>>>
>>>                   *** EMAIL ADDRESS ***
>>>
>>> [1].  There is even already a way to fix up mistakes or unavoidable
>>> email address changes, namely the .mailmap file.
>>
>> *facepalm*
>>
>> You've just repeated everything that I've said; go look at the rest of
>> the thread, where I spend plenty of time correcting the same hangups
>> about my choice of the word UUID and my use of hex digits.
>
> No, my point is to use the *existing* email address as the UUID
> *without* adding another field.  Nothing needs to be changed!

if you are now proposing using the e-mail address, that already 
exists and is supported by the tools, it sounds like you are just 
withdrawing your proposal (other than possibly proposing that the e-mail 
field gets renamed to UUID????)

David Lang
