From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in latest gitk - can't click lines connecting commits
Date: Wed, 23 Jan 2013 08:35:55 -0800
Message-ID: <7vehhbj1qs.fsf@alter.siamese.dyndns.org>
References: <20130101172156.GA22450@gmail.com>
 <1kw18d3.5sftkl125qdz4M%stefan@haller-berlin.de>
 <20130101232220.GD20724@iris.ozlabs.ibm.com>
 <7v622p9lfs.fsf@alter.siamese.dyndns.org>
 <20130123114806.GA21124@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:36:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty3JD-00040v-SW
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 17:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab3AWQgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 11:36:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755480Ab3AWQf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 11:35:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA478C481;
	Wed, 23 Jan 2013 11:35:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uJ0PE4jOsC3OEW/cxPKsKZv37P0=; b=G2RW7w
	hEb2kjlGC6+HVaQIRSCsgheQ4Ct8OS9uMVLNBOYpp4Eq9qG86BPoa8Pi3MwuGNN7
	XislZxJhn7QfYYd90DLFBF8Fma0vDLrdfXv6/PFsv58qDxb5UFuUkMu/83PYxAoZ
	Gd6H8DNQLKvJx/azL83L9asQA13vt5wSIB2VU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EnbMTzbx/J+0Nl9lZ72u75l5ZjX2b/C8
	aRbcHXOQFnMBe0XwPmZsUXSWQoWJqtCtde/N4Mav+4e6yA/VY6Kiwq96rHW99mG/
	0frOj3cgSTkQ2Vf/rGnAn6SHvuWxhovsa8Jadu8U4Z1LwFIXFxr+ltxeFkjSdBKQ
	SXpilXnLk24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D07B8C480;
	Wed, 23 Jan 2013 11:35:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 521ABC47F; Wed, 23 Jan 2013
 11:35:57 -0500 (EST)
In-Reply-To: <20130123114806.GA21124@iris.ozlabs.ibm.com> (Paul Mackerras's
 message of "Wed, 23 Jan 2013 22:48:06 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6AC23B6-657A-11E2-9EA9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214333>

Paul Mackerras <paulus@samba.org> writes:

> On Tue, Jan 22, 2013 at 09:28:23AM -0800, Junio C Hamano wrote:
>> 
>> I notice that I have a handful of commits that I haven't pulled from
>> your repository, and the last commit on your 'master' is about 20
>> days old.  Is it safe for me to pull these now?
>
> Yes, please pull them now.

Thanks.
