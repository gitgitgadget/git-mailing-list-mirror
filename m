From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Fri, 23 Sep 2011 12:29:07 -0700
Message-ID: <7vsjnnt5vg.fsf@alter.siamese.dyndns.org>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
 <CAP2yMaL3rewYZSXQFxkSLkiNbaBAP8r707x2dScVK1zeVr8hXQ@mail.gmail.com>
 <7vvcsjuojp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 21:29:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7BQz-0001XS-Ee
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 21:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab1IWT3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 15:29:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab1IWT3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 15:29:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC9DD4815;
	Fri, 23 Sep 2011 15:29:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vvyjAh8fLkcIs+vlXnCH9j2z2Yc=; b=qS8cll
	fc2ttWx5albbyhb90hC1JiNEG7M6e110NceWL6ia6UnOydiFWz8pGvtMonb8xUlv
	Bs8y58Ju9/INpAs56tFSPozu2mtqIDDEL8Nq7OSC4akobrFUl5z87qjQvVawI3aI
	/hN81vPe/N1FyJ9TyAhnTxbYpRDwa0ppyE0V8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCeFt2VUTKIgHMdeFz0hQv3j20uM8UUj
	NWpeVjIMQSoUk5vGTANGzyT3KmMS9zxguZr+QnLw2TviS0wn4cXgzlEP7zL0X+fP
	AFF7lFob0SlXKgZg/tlHvDu32Tfyw2HfIGZ1hjIFuxhDogjaAq/fxXrD7hkIfrc6
	MSEEiicxpDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3F7D4814;
	Fri, 23 Sep 2011 15:29:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50BFC4813; Fri, 23 Sep 2011
 15:29:09 -0400 (EDT)
In-Reply-To: <7vvcsjuojp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 23 Sep 2011 11:00:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F331382-E61A-11E0-86B7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181993>

Junio C Hamano <gitster@pobox.com> writes:

> Scott Chacon <schacon@gmail.com> writes:
>
>> It appears that you're no longer pushing the 'html' branch to the
>> GitHub repo,...
>
> It is not even "no longer".

It just occurred to me that https://github.com/git/git repository might be
the one you are talking about, but that repository is not even mine.  The
page at https://github.com/git says git@logicalawesome.com is its contact
person.

I _suspect_ it is set up to mirror from my k.org repository and obviously
nothing is updated from that route for the past few weeks. It is correct
to say "html branch in that repository is no longer updated", but I cannot
do anything about that repository ;-).
