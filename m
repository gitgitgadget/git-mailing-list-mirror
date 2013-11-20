From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/gitcli.txt: fix double quotes
Date: Wed, 20 Nov 2013 15:18:49 -0800
Message-ID: <xmqqli0i64rq.fsf@gitster.dls.corp.google.com>
References: <1384911280-20175-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Thu Nov 21 00:18:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjH2w-0004qR-0X
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 00:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab3KTXSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 18:18:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42744 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120Ab3KTXSx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 18:18:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA25054C0E;
	Wed, 20 Nov 2013 18:18:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=NxL4cW
	9NVWeDK1S1qS6xsLdN7n8EHbqmPoLsMCybSqULDNn7m0q9PbGhU/K9a865iJE9cg
	/uTafLCl78V1QEFXKvXDs45EVHiIm+kWAqsY031kespog+V1bWpJXJiFI22Pxi13
	ZbbsNMnHF2logHmN3glfFBPr51Z+y9CPxLnK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jh7je7VhTnsYxI8APMzgnUGBkvd/S3LV
	zPglClZG/owuU2np91ugwaDZe2IPnWTX9+h58sWuLQxWPuJO9YXSIptTwZ5AZwns
	/Cg+heRfWGgSV0Fex5pewO4l3iqHuk07kszxQNRNBYF5tvTvIDM1YlimgThv+6Vd
	qegj9ZDYefM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFA3F54C0D;
	Wed, 20 Nov 2013 18:18:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB13654C09;
	Wed, 20 Nov 2013 18:18:50 -0500 (EST)
In-Reply-To: <1384911280-20175-1-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Tue, 19 Nov 2013 20:34:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D8A000A-523A-11E3-8A83-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238106>

Thanks; will queue.
