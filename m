From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix various typos and grammaros
Date: Fri, 12 Apr 2013 09:10:36 -0700
Message-ID: <7vbo9jg26b.fsf@alter.siamese.dyndns.org>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org> <5167C2EB.7010709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:11:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgZ5-0000YZ-46
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab3DLQK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:10:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031Ab3DLQKm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:10:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69AC013898;
	Fri, 12 Apr 2013 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fA+dboZ6F/F5kf3QoLbCDy6kqDs=; b=MTVda9
	94YRuAGPSZPh1EGTAf/lRkEr7wjILtUBQ6CZ5d45+B9J3mXb8DxLQmiG8V5IYl1M
	IPK2u9EmH5xAbFt304NBivEsLYjNcR+I/mvhgaNtd2PwO/t6jGJ+NKNkh49EiG2o
	RoDgWCFQVWZu/F5wTjRXzJTgAYyuQukNJTnIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=enM8G62dN8zjzyEZZGGe+wIt09KOqGx9
	yp8sP1DG8q4awPTsx1ir4tQEzzI2AAvSUcNt8h+dGmbbyoDnIScdQY3CfmZFCQ5p
	dXLa7BN45I07ZltWdYRXsPtpMf2tHeNmyX1fQIODFiuXm+9d9iSuS5tatUXC8b/R
	K3YU7blvfEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F57A13896;
	Fri, 12 Apr 2013 16:10:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2CCC13894; Fri, 12 Apr
 2013 16:10:41 +0000 (UTC)
In-Reply-To: <5167C2EB.7010709@gmail.com> (Stefano Lattarini's message of
 "Fri, 12 Apr 2013 10:16:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86042812-A38B-11E2-A992-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220994>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> Hi Junio.
>
> On 04/12/2013 02:45 AM, Junio C Hamano wrote:
>> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
>> 
>> How much of this stuff have interact with real changes that are in
>> flight, with various doneness cooking in different integration
>> branches?
>> 
> I don't know, since I only follow the master branch of Git.  And
> honestly, I don't have time right now to go checking for possible
> conflicts, or to resubmit ...   But I see Jonathan has taken up
> the ball on this (thanks Jonathan!), so I'll leave the matter to
> him.

Yeah, that's OK.  Thanks.

> Next time I'll try to prepare a patch broken up in more digestible
> pieces, so that it will be easier for you to deal with conflicts,
> and/or to selectively decide which fixes are worth applying.
>
> Thanks, and sorry for the confusion,
>   Stefano
