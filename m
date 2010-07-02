From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improved autocrlf description in RelNotes-1.7.2.txt
Date: Fri, 02 Jul 2010 10:28:38 -0700
Message-ID: <7viq4x23p5.fsf@alter.siamese.dyndns.org>
References: <20100702075844.GA14583@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri Jul 02 19:28:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUk2k-0004dq-Fz
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 19:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759387Ab0GBR2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 13:28:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352Ab0GBR2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 13:28:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DBD9C0690;
	Fri,  2 Jul 2010 13:28:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rBdJle0oo5KRF2qT1TkKPNqU+r4=; b=VYBAfK
	MjmS++U9QBCf9MF65SyLoQschbhyL0DCApFiIewbawEBNgnWDphu1m5+xyJTDnGG
	dofVwDKkDpw2IjOOHhTUdFYJcBp8e8GKWLn+A90QxnSSi2e51mEN9Sbvx7Y1Uqm2
	YHF6f0TXlOIYHl5ySy57511xIKqFcEazT1emM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EdO6lOgTw5mCuQJQGq/XRgQTxzCdglNJ
	AmefV3UVqZLPRCDpIlAQ2y5d84ALI0UQ9sflpdJiJ8ZZVFbumx7HEC+jjuZEd58I
	Iqaz4DRFB5Jw0Qld4oMYTDza1KUrFYSro+j9p/3Q0FpZ4+UwPV8j+7IbljzK8yBt
	1MIhpw/g8ng=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CBD6C068F;
	Fri,  2 Jul 2010 13:28:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DEECC068E; Fri,  2 Jul
 2010 13:28:39 -0400 (EDT)
In-Reply-To: <20100702075844.GA14583@pvv.org> (Finn Arne Gangstad's message
 of "Fri\, 2 Jul 2010 09\:58\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42704E70-85FF-11DF-A6AE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150143>

Finn Arne Gangstad <finnag@pvv.org> writes:

> ---
> I think RelNotes should be rewritten along these lines..

Thanks.
