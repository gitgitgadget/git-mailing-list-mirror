From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Wed, 29 Apr 2009 09:27:11 -0400
Message-ID: <D1C7AEA3-1565-4E86-AFF0-9EC2F0D79FCC@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <4E155CC5-B20A-4B79-8CBF-9D1E0E36920F@boostpro.com> <20090425003531.GA18125@coredump.intra.peff.net> <1A9F6DB0-983F-4A5B-B3B7-33227C11F36A@boostpro.com> <20090429063448.GA22448@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 15:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9pO-0001kQ-7i
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457AbZD2N1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756169AbZD2N1Q
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:27:16 -0400
Received: from boost-consulting.com ([206.71.190.141]:64029 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbZD2N1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:27:15 -0400
Received: from [192.168.188.134] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id B22F71CC1F;
	Wed, 29 Apr 2009 06:24:31 -0700 (PDT)
In-Reply-To: <20090429063448.GA22448@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117889>


On Apr 29, 2009, at 2:34 AM, Jeff King wrote:

> On Fri, Apr 24, 2009 at 08:53:37PM -0400, David Abrahams wrote:
>
>>> Actually, it is not the generally of trees that I think is  
>>> interesting
>>> there, but the generality of _objects_. That is, each of those  
>>> things is
>>> a first-class object, and has a unique name by which it can be
>>> referred.
>>
>> I'm sorry, but I think most people would find that so unremarkable  
>> that
>> making a big deal about it would lead to "what am I missing here"
>> confusion.  Maybe a person who's exclusively used CVS (or older)
>> technologies before coming to Git would be happy to know that, but  
>> it's
>> sort of obvious.  In CVS the lack of first-class directories sticks  
>> out
>> like a sore thumb.
>
> Sadly, I was away from email all weekend and so missed the ensuing  
> storm
> in this thread. :) However, I did want to respond to this one point.
>
> To me (and I am talking from personal experience, so it really may be
> _just_ me), an important part of understanding git was understanding  
> the
> object storage. That is, half of the idea of git is a big database of
> content-addressable objects.

Absolutely, it's important to know that everything is content- 
addressable (which essentially communicates the same important  
information as "the object's id is a hash of its contents").  I was  
trying to say that the fact that each one is a "first-class" object   
and has a unique name is not particularly remarkable.

--
David Abrahams
BoostPro Computing
http://boostpro.com
