From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fa/remote-svn (Re: What's cooking in git.git (Oct 2012, #01;
 Tue, 2))
Date: Thu, 04 Oct 2012 09:30:40 -0700
Message-ID: <7vsj9u19ov.fsf@alter.siamese.dyndns.org>
References: <1550217065.62365.1349356580255.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtbT-00033L-AW
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729Ab2JDQap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:30:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab2JDQao (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:30:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A51862C;
	Thu,  4 Oct 2012 12:30:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fXBYHcTiR3Z6XVWrHHp95V8XNyg=; b=EvWWOe
	leiXvZ8ZLw4lG4Camh1+Gkr559rEnwLUXA8xrgZHxSNWKBOlOq1Y17+8arZU77vF
	YoXodZqfdXhwAsfgKXQr1XP69vZlrXrw1AN34/aALrVNTKNnmhBFIr3KkooOxvDY
	1GppBv398BcwWV61JevVZtWPkrwabaxaX4Qko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJPAgXhnKBn+i//sSaqRHiam/gioqQTH
	tEoLjNwTXzr/LlDNr57aPHV7RCvweq0RV3T0bqKV3Zz2rLzYXmXmDxMFhjMLLKQ5
	jIYw7DDbNyGzIZhOLf/4rGqovgMcfclvvFGNlU4f6T7aERVKlr+4p5KYzcwSjE0G
	ilTmlY1gMjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A14E1862B;
	Thu,  4 Oct 2012 12:30:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14E1C862A; Thu,  4 Oct 2012
 12:30:42 -0400 (EDT)
In-Reply-To: <1550217065.62365.1349356580255.JavaMail.root@genarts.com>
 (Stephen Bash's message of "Thu, 4 Oct 2012 09:16:20 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D783A252-0E40-11E2-8904-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206978>

Stephen Bash <bash@genarts.com> writes:

> I seemed to have missed the GSoC wrap up conversation... (links happily
> accepted).

I also seem to have missed such conversation, if anything like that
happened.  It certainly would have been nice for the mentors and the
student for each project to give us a two-to-three-paragraphs
summary.

As GSoC is a Google event and not the Git community one, I wouldn't
*demand* a concluding write-up, but it still took considerable
community resource, so...
