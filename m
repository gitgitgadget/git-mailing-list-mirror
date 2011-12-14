From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is it "GIT" or "Git" or "git"? Standardize documentation?
Date: Tue, 13 Dec 2011 17:02:38 -0800
Message-ID: <7vy5ugrmmp.fsf@alter.siamese.dyndns.org>
References: <20111214004332.GA8464@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Morr <sebastian@morr.cc>
X-From: git-owner@vger.kernel.org Wed Dec 14 02:02:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RadF7-0006c4-ON
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 02:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab1LNBCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 20:02:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655Ab1LNBCk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 20:02:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF7006F8B;
	Tue, 13 Dec 2011 20:02:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TY0G7Q/C/Ka6uHfTa6CK++WRmMU=; b=OQ6/gz
	hz6PItuqvr0j3HVPtNlSUR8l6KJJzzkP4l4lQH7yMuuYihgCbjBR/yt6dJqqK1Fu
	xE3Uh0mJ6FMPVlS1b5UDSNJwyl5QMtUSMkMij9uThhACEJcDC6uhzVlE0czbwx3K
	OZQNf49rRRBuDaHj8ir3Pm589TpGl2uKkPMmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZevhvOuAR7d937B0/EgD0wqmBR1mMN7s
	nV3oI0e5OYiepAORpVPWSryaxPbkblZ1e4tjAxsi050RyYE5ExhaCeHLyS60/sos
	mjMlps76hmmETSMBqIysy4w3Dz4heBLuegp8SHY3uYK+cBvEii6PnsfnrzKJOJTx
	clbHmDiOFmM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7BD16F89;
	Tue, 13 Dec 2011 20:02:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 719446F88; Tue, 13 Dec 2011
 20:02:39 -0500 (EST)
In-Reply-To: <20111214004332.GA8464@thinkpad> (Sebastian Morr's message of
 "Wed, 14 Dec 2011 01:43:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51A1446C-25EF-11E1-A0C2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187089>

Sebastian Morr <sebastian@morr.cc> writes:

> Okay, I'd like to hear opinions on this before creating a patch.
>
> My perception is that "Git" is the name of the software, whereas "git"
> is used to refer to the actual command.

And "GIT" is used interchangeably with "Git" whenever the document author
feels like it warrants a bit more visibility than usual in the context.
Think of it as typesetting in a font with small-caps or something ;-).
