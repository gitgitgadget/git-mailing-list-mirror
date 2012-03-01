From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Quick Question
Date: Thu, 01 Mar 2012 11:35:48 -0800
Message-ID: <7vk434m7vv.fsf@alter.siamese.dyndns.org>
References: <F0482166E5DED147A785422B0FCBD3F1172AA2A2E0@itsMAIL01.its.bldrdoc.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Max Lucchetti <mlucchetti@its.bldrdoc.gov>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:35:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3BnC-0001AE-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 20:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab2CATfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 14:35:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866Ab2CATfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 14:35:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CB237712;
	Thu,  1 Mar 2012 14:35:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U7Y0BBvB2PKl/5j2ywvuzvs8Yfs=; b=iNgCG8
	uJwR3SKQEHBZiW3fbwIPSHKLfrSfGsi1vYyZW1sS9AOp9RkRikS3niAEBdzgA5bo
	O031q8OjH02s8nvlT7axih+cQpFhWxAX5pI8puvZAcO0Nv0uGs4i8GWT2YYz7V4h
	62umgKhJZIVgDYYNmgUz5v6Fe91WXRU5/yQCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G3hM3gTDdBHdlTY5Yemfq+LtDb9bqu2d
	vR8CCvtDhBk42C38iS9hy8Gt/UvNk+zCPZhiLcVBttg2dQe6tpYXip9tCxZsdaTU
	klITv50wa65aDsv5Hg6tCXOKBrtFHlhBO1Vj8nnd3qTBy0Qu543y4s3UxywMpiCy
	xOkpqHwLb3A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73CBA7711;
	Thu,  1 Mar 2012 14:35:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C5FB770F; Thu,  1 Mar 2012
 14:35:49 -0500 (EST)
In-Reply-To: <F0482166E5DED147A785422B0FCBD3F1172AA2A2E0@itsMAIL01.its.bldrdoc.gov> (Max
 Lucchetti's message of "Thu, 1 Mar 2012 12:00:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0244D66-63D5-11E1-AE67-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191961>

Max Lucchetti <mlucchetti@its.bldrdoc.gov> writes:

> I wanted to confirm that your product "Git" is free for the US
> government to use?

As far as _we_ are concerned, anybody should be able to use it for free
(as both in "libre" and in "gratis" sense); it is licensed under GPLv2 and
the copy of the license is found in COPYING file. Some part is licensed
under BSD license, but that shouldn't change the picture.

Having said that we are in no position of knowing if the branch of the US
goverment you work for has its own restriction regarding its software
procurement process (e.g. "It has to be produced by an ISO 14000 certified
facility").  So...

> If you cannot answer this question, would you know who could?

...if this is a legal inquiry, only _your_ lawyer can answer it.
