From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Remove a user of extra_refs in clone
Date: Mon, 16 Jan 2012 22:51:31 -0800
Message-ID: <7v39beu8i4.fsf@alter.siamese.dyndns.org>
References: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 17 07:51:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn2te-00087C-6E
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 07:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab2AQGve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 01:51:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886Ab2AQGvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 01:51:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 486A64323;
	Tue, 17 Jan 2012 01:51:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wa/NvyYXLq5cUorjzvqH6dcPtUs=; b=AfS7dF
	sBcK1qTc6FP+bewLUMPcV7Ld6hZBdN9MD7mDtTth18WlAEccG7RFxFLrq8B8KXjs
	lzyk7+miHcjXxARhMBbauuQ24PVMw5vlvmReuje7wctbQjBXZJ2t9MKkrk/7P2L0
	Mw9ZPFjswiRyLQ2VjUBASzUxL3eOXGBi/u6z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MMF2ZmpgKnOifbteEbsBo5u3hI9VITku
	9ls0napp4mZ/s22Jv6UuvEbQ56JN75PeKMu5+NMXZKbhSgfkwxTyDoPMDQyhP8ex
	VCeYGH1OUQFbezCdUOggkLJvUY7ncm78ei8nY7SZT54fl5lTA4WxxnOJwDrpkfY2
	271Z7xZoJbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EB2C4322;
	Tue, 17 Jan 2012 01:51:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B876D4321; Tue, 17 Jan 2012
 01:51:32 -0500 (EST)
In-Reply-To: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Tue, 17 Jan 2012 06:50:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0EBC9E4-40D7-11E1-9D31-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188694>

Yay ;-)

Thanks.
