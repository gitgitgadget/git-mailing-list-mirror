From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/02] Remove gitweb/gitweb.cgi and other legacy targets
 from main Makefile
Date: Sun, 08 May 2011 11:53:30 -0700
Message-ID: <7vtyd5rplh.fsf@alter.siamese.dyndns.org>
References: <1304772321-22687-1-git-send-email-jnareb@gmail.com>
 <1304772321-22687-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 20:53:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ96t-0004Zl-LF
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 20:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227Ab1EHSxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 14:53:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab1EHSxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 14:53:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECC6453C0;
	Sun,  8 May 2011 14:55:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=exlWI24nWCUOd6u32x26gE9Nc1E=; b=mzEWOG
	FKaQGFZXt6WMzfu+xUSCYIU6f1GmPELUpqNbWETC88MmYLtzEhJ4E1ggLIkZye5s
	s1TYZckbwRLcvWK5cSkbPvp68U6T5jVYIXQpLMOCzlJxu8kz9xxgkKTw0tT0e/Z5
	9xsH2eVP+eh4YlzbLkfTjr4PY2DhAzZtW8gXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XcKj+yvD49UVOBqsSkAdKXTlWriBWGLe
	jh8fm+QvjNCjKHU7banxDkNIZRRMGR7AWovM0zBu7odp3iLWT5zrK7kanZLogz4v
	HRKkz4JzTO4a1GbfgO7KN1fmW1Pu3ASxCCBmK4Oov0L8Wo9JarnCxSM847snTy1v
	rH0XJy7W9mo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8B1653BF;
	Sun,  8 May 2011 14:55:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E637853BE; Sun,  8 May 2011
 14:55:36 -0400 (EDT)
In-Reply-To: <1304772321-22687-3-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Sat, 7 May 2011 14:45:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C45F4C76-79A4-11E0-952A-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173172>

Thanks, queued.
