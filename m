From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH/RFC] Developer's Certificate of Origin: default to COPYING
Date: Thu, 12 Sep 2013 19:15:38 -0400
Message-ID: <52324B1A.2030001@bbn.com>
References: <1379023862-29953-1-git-send-email-rhansen@bbn.com> <xmqqy571n05d.fsf@gitster.dls.corp.google.com> <CA+55aFyQZ8EiOg+CZy-KMaX0Hnkdmvq1+8b9p6uuMuHAUzYaAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 13 01:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKG70-0007iw-C1
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 01:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab3ILXPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 19:15:42 -0400
Received: from smtp.bbn.com ([128.33.0.80]:17263 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756196Ab3ILXPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 19:15:42 -0400
Received: from socket.bbn.com ([192.1.120.102]:55542)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VKG6t-0002Ho-69; Thu, 12 Sep 2013 19:15:39 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id DD9894092A
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <CA+55aFyQZ8EiOg+CZy-KMaX0Hnkdmvq1+8b9p6uuMuHAUzYaAg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234710>

On 2013-09-12 18:44, Linus Torvalds wrote:
> On Thu, Sep 12, 2013 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Linus, this is not limited to us, so I am bothering you; sorry about
>> that.
>>
>> My instinct tells me that some competent lawyers at linux-foundation
>> helped you with the wording of DCO, and we amateurs shouldn't be
>> mucking with the text like this patch does at all, but just in case
>> you might find it interesting...
> 
> There were lawyers involved, yes.
> 
> I'm not sure there is any actual confusion, because the fact is,
> lawyers aren't robots or programmers, and they have the human
> qualities of understanding implications.

Well stated.  :)

> So I'm actually inclined to
> not change legal text unless a lawyer actually tells me that it's
> needed.

Is it worthwhile to poke a lawyer about this as a precaution?  (If so,
who?)  Or do we wait for a motivating event?

> 
> Plus even if this change was needed, why would anybody point to
> "COPYING". It's much better to just say "the copyright license of the
> file", knowing that different projects have different rules about this
> all, and some projects mix files from different sources, where parts
> of the tree may be under different licenses that may be explained
> elsewhere..

I agree that your phrasing is better.

-Richard
