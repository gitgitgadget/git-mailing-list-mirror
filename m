From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/commit: add missing '/' in help message
Date: Wed, 21 Dec 2011 11:16:21 -0800
Message-ID: <7v62h9hh16.fsf@alter.siamese.dyndns.org>
References: <4EF1F380.3090901@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 20:16:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdReP-0007pX-4a
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 20:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab1LUTQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 14:16:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab1LUTQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 14:16:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5D306055;
	Wed, 21 Dec 2011 14:16:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=SWM8HV
	QeuSc/P1lq2jaPZNPxQo3W3393Id+d6fqzTREldNCRcT2jfC33dpR0qLizTcp9/2
	e6d2GKsgEY5Di12z+6MLXDLDQkeUrdknEHHvEdvDz92Q5dfBuMoy5cvXbimcsTtw
	cRANjXu74TEh4L6nabVq+q4+cX1pesndeozvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vQ/n58I9/spSlLJE2lV324Z6gsPTRFPM
	VEv4E1rd0KN7ebggOBruvimGk6LjsRVddedl9iBDuO8r7CYCRRpbGHDsfoUokSKf
	DWWfX+sgXceJLdq0SQpeNRwzEkdF909ooz08ekmfru6taX1j9Xwu+vO4OXoH/a5v
	we5l7MsQIzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD3CD6054;
	Wed, 21 Dec 2011 14:16:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B0AC6052; Wed, 21 Dec 2011
 14:16:23 -0500 (EST)
In-Reply-To: <4EF1F380.3090901@elegosoft.com> (Michael Schubert's message of
 "Wed, 21 Dec 2011 15:56:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 456B1528-2C08-11E1-A1A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187583>

Thanks.
