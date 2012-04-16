From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Mon, 16 Apr 2012 08:03:40 -0700
Message-ID: <7vehrnyb03.fsf@alter.siamese.dyndns.org>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org>
 <4F8BE14D.7090501@seap.minhap.es> <7vlilwxf3w.fsf@alter.siamese.dyndns.org>
 <4F8C0171.6090203@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:03:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJnT4-0007oS-FV
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab2DPPDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:03:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761Ab2DPPDo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 11:03:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B759681A;
	Mon, 16 Apr 2012 11:03:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2h9aBZd0cJvJRsDbbtxje36Anso=; b=KyX/tN
	CEUq3oGi+8RtazVzboatUHT9J7LJQk+J4diR2g8DocERXpicqMeW0iSjrLcVHe4C
	Zdl8fhiF8o+JBu/mBU+okCRnKx7QrYcx4e4tMjVNbJueayiH6X6LHuQT4xugyz1Z
	JPmpxXPqKOlx/UrXurGCMkR31hT35EDaY6NOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xEyk8a3+ds72BJuGstCW4Qa1PiOOVrWu
	boJyEb4TYzWw47LUNU0mFdqxhX/DJW2r3/KabegvSD+TcFXvXRfY6Z3oeG1MOExp
	fCMBFXgehZdBiImaVch32sa4E7uN6HlQdtZNK89eAE4sGNr5j69Ksia84zmlSxU3
	1Aul3U7VHV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 621756819;
	Mon, 16 Apr 2012 11:03:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 693026815; Mon, 16 Apr 2012
 11:03:42 -0400 (EDT)
In-Reply-To: <4F8C0171.6090203@seap.minhap.es> (Nelson Benitez Leon's message
 of "Mon, 16 Apr 2012 13:24:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B1FBB02-87D5-11E1-9BE7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195643>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> Ok, I've been offline for a week, I already found the thread and I'm
> going through it.

Thanks.
