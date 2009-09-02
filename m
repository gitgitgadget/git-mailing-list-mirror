From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Tue, 01 Sep 2009 22:32:51 -0700
Message-ID: <7vk50hap30.fsf@alter.siamese.dyndns.org>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
 <c77435a80909011525m3a6e7917xe066d61f3863e615@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 07:33:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiiSv-0005Oc-64
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 07:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbZIBFc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 01:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730AbZIBFc4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 01:32:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbZIBFcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 01:32:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C965321D3E;
	Wed,  2 Sep 2009 01:32:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iuW4J4HgRqLKRU/h9694g88MHqU=; b=n1mImP
	kenEneAR3qG8sEKFaS/D0WNWJxtbwYlYkB+ja75iVrT/XF8ovVCPnLx/hHYCDnct
	igo0NDpbmid9amzLIrcFNcuuURa4tQlMxytY/3Vvi0KS2kZ/G5xyQLuGv1kRG5py
	wRmxcneYprsagdnPXQoYk9mNrjJdew1cwVH+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K2TvMvxAmHg/XsQQQHex0Xjhn6QpQOVc
	HPU+PB1YsufvY3sncjHa7x8+qg+DHbtX99xq6fVX4c81pUZvtUmmM/J42+0Qut9q
	Nj826kK6KOFqQoYUUjjvk2GtIErukafoKDm9osn/5pf0y1HGQgFZS+JJXbSJ37/w
	qWxk5ulBUeg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5A5A21D3C;
	Wed,  2 Sep 2009 01:32:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A3AF21D3B; Wed,  2 Sep
 2009 01:32:52 -0400 (EDT)
In-Reply-To: <c77435a80909011525m3a6e7917xe066d61f3863e615@mail.gmail.com>
 (Nick Edelen's message of "Tue\, 1 Sep 2009 18\:25\:05 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 111F6F0C-9782-11DE-8A13-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127583>

Nick Edelen <sirnot@gmail.com> writes:

> I vaguely remember something concerning those tests when starting the
> project.  I'm a bit disconnected from everything right now, but I'll
> try to get those fixed as soon as I can.

Thanks.
