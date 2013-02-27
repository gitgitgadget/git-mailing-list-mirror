From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/submodule: Add --force to update synopsis
Date: Wed, 27 Feb 2013 07:31:05 -0800
Message-ID: <7vppzlkc3q.fsf@alter.siamese.dyndns.org>
References: <7bf0424a37df48a59e4d45fb93f8518ff2db00f5.1361925124.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 16:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAiym-00016a-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 16:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208Ab3B0PbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 10:31:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab3B0PbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 10:31:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9138A43A;
	Wed, 27 Feb 2013 10:31:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=XUOOXF
	D2lKLFexgOrLRp43R12tyVpCQXdVT4ICqspxpiRfHXaeX6/Vcz4gRlWk4Kf3wfBQ
	KQn0HMBN2iQ9RMcxwvz/ozQRZxph0mewPBDZEcPhn4sTM7WMKTn4zhlrknnBb+ex
	f9U2DrZSIRmeExtXv5GQRm2gzcAlplOFJtfVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eaHiW7cP2FkO6U4pWZxPwXOImHVXZvPS
	5S6/GHFW8Q7dI62ao0robST6Sd2PUIPkcii1Dd+gEP9KuOWy+cJk8bJXbnjo8OcF
	zyGvfnDBQAsMz4LmY61Xf8z5B8h5MMs4zb1z3XM2VUzkSwK/2NwWR07c9udnUDbe
	q0/mnGcO1cA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BECBFA439;
	Wed, 27 Feb 2013 10:31:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 481FFA436; Wed, 27 Feb 2013
 10:31:07 -0500 (EST)
In-Reply-To: <7bf0424a37df48a59e4d45fb93f8518ff2db00f5.1361925124.git.brad.king@kitware.com> (Brad King's message of "Tue, 26 Feb 2013 19:41:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B47C7B42-80F2-11E2-A665-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217209>

Thanks.
