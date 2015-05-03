From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Contribute Code to Git
Date: Sun, 03 May 2015 10:47:24 -0700
Message-ID: <xmqqtwvtv9hv.fsf@gitster.dls.corp.google.com>
References: <loom.20150430T124609-727@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alangi Derick Ndimnain <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 19:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoxzH-0007ic-Mz
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbbECRr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 13:47:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750990AbbECRr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 13:47:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B04384DF1E;
	Sun,  3 May 2015 13:47:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FpufMT8hSSzCKY/J2aD6bczgkLE=; b=Oq4WlJ
	ix3mTWx5DXf1ZC+pNIHDHuI74ezkaA5QwfHzqVQaEWPoz2igAgkN2A2C0bf7JkNs
	S7ZT3VEBdDOUo9iMr5luPzPX2vOBltzMG2DrdeNJL12nxzgnme7nbdqO76fR1uPP
	YmXrriCtruRLfytyHNAEO4AKj/tEvIkhJShAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A+UMI/4sgD/oEH5cwa5kiMdXHaQaw3Wm
	Mh7RmutbMKjMge8upyjX/SteefEDJ91XgbGK4wqPb2vEpi/9ZIiR5K/7H7pIbkaq
	FihonjtNDSvuMti/2v49qkMF0hQap47UDc2A5pbzEhf28IJtJMJ5AbM+DceSrjjU
	AAG/F47OGRE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA0544DF1D;
	Sun,  3 May 2015 13:47:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33DE74DF12;
	Sun,  3 May 2015 13:47:25 -0400 (EDT)
In-Reply-To: <loom.20150430T124609-727@post.gmane.org> (Alangi Derick
	Ndimnain's message of "Thu, 30 Apr 2015 10:49:54 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 754F7E64-F1BC-11E4-810E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268277>

Alangi Derick Ndimnain <alangiderick@gmail.com> writes:

>     I will like to have some advices and also start working on the system...

A few advices from my end are:

 - Think yourself and remember what annoyances, troubles and issues
   you had with your daily use of Git.  They are good problems to
   tackle, as you have a first-hand experience with them.  Don't
   go hunting for "problems to solve".  That will likely end up
   wasting your time (and reviewers' time as well).

 - Start by reading everything other people post, until you notice
   whose posts are worth your time reading.  And then, concentrate
   on following the discussion threads they are involved in, to
   learn how the best discussions are carried out on this list.

Thanks.  
