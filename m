From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 03 Mar 2009 00:04:24 -0800
Message-ID: <7vljrnf2wn.fsf@gitster.siamese.dyndns.org>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
 <1235865822-14625-3-git-send-email-gitster@pobox.com>
 <20090301031609.GA30384@coredump.intra.peff.net>
 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
 <20090301100039.GD4146@coredump.intra.peff.net>
 <20090301170436.GA14365@spearce.org>
 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
 <20090303070937.GB30609@coredump.intra.peff.net>
 <76718490903022337n79a0c11cw95e80d99cd598d17@mail.gmail.com>
 <7vtz6bf392.fsf@gitster.siamese.dyndns.org>
 <76718490903030002u5a7babe2k6f26b4cc4b48c9d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePdb-00026S-DW
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbZCCIEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbZCCIEf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:04:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZCCIEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:04:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FA4A9E4A7;
	Tue,  3 Mar 2009 03:04:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6673C9E4A6; Tue,
  3 Mar 2009 03:04:26 -0500 (EST)
In-Reply-To: <76718490903030002u5a7babe2k6f26b4cc4b48c9d1@mail.gmail.com>
 (Jay Soffian's message of "Tue, 3 Mar 2009 03:02:48 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDAC1A04-07C9-11DE-92B9-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112022>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Tue, Mar 3, 2009 at 2:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jay Soffian <jaysoffian@gmail.com> writes:
>>
>>> I concur w/Jeff and I think git probably should not as well. I think
>>> that instead adding it to init might be interesting
>>
>> The thing is Jeff and Shawn already rejected that route.
>
> Okay. I missed that, so I'll go search for it, but it still seems like
> "init [<path>|ssh://]" should be the basis for "push --init".

It was called "init --remote".
