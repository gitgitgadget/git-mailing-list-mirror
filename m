From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/merge-options.txt: restore `-e` option
Date: Thu, 16 May 2013 16:39:10 -0700
Message-ID: <7vbo8a336p.fsf@alter.siamese.dyndns.org>
References: <1368743160-11866-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:39:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7lV-0006au-2e
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab3EPXjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:39:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab3EPXjM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:39:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DB251F25A;
	Thu, 16 May 2013 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=g0iy0w
	UFeIuAoCOW+9AMfsR4gy19tXgp9sMc2BNHHnen6xMJLgTmYC6VJWq89rVuVchbUA
	KmYRLnWI8PN981rbbbPipe+GJX2wPYo5W8c8pQqJKmGhJ4j4ORdDsOli2aJB/uwI
	MrF59iMjC/7KzACXMHNRJP/EpBKx/IrhM9NwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QWdBqiUYR2aJsUuaRX9VtdPO/aJm6rMC
	7NOLRMItLOUKF+eamrfXgRnXkkxB8z79XYkEOiigt3TiRbUgBvIebd2uX3DmAYBT
	S9gprFx7TuLFDTdxgS4ONwZUSl8YkA3ZbJ5zVWQMSvTnpOxD7D+ZU/d0LMQl9k5B
	4qKs3KdTfuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 914EB1F259;
	Thu, 16 May 2013 23:39:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 180151F258;
	Thu, 16 May 2013 23:39:12 +0000 (UTC)
In-Reply-To: <1368743160-11866-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Thu, 16 May 2013 18:26:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFCF2D00-BE81-11E2-B903-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224637>

Thanks.
