From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #03; Fri, 18)
Date: Mon, 21 Jun 2010 11:31:34 -0700
Message-ID: <7v631ci6ex.fsf@alter.siamese.dyndns.org>
References: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
 <AANLkTinB4N6xXm7_Locp-xJyN8Nkew_7t16XhjVi_GlB@mail.gmail.com>
 <7v7hltvcfy.fsf@alter.siamese.dyndns.org>
 <AANLkTiksOHr2m4HCPp8779VG95zexvYwgE86MsFzBJxF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 20:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQlme-0001r7-Ff
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 20:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab0FUSbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 14:31:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349Ab0FUSbm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 14:31:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50ED3BD1CD;
	Mon, 21 Jun 2010 14:31:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i6oXvQZ3ezxzI3TJvaWxEY7zbF8=; b=Pca6Bk
	EOFBPv8g9rZOdfzR+wHfhD9B2FcDIBWvZpl2RVV560YpU1YDdNS153ae45N30l6M
	nYSxozoTK/Z61/sVXYDsywjdiLcKFGlYmuUSjT+Yle27H1n0oiZRF7pKuhPbvVYC
	iWDx5b9r2zJhkQocjJkfkxtXyGOQcC41ujLTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eVIFKb6sblv4Cap/f139p98LuTvcLH+Y
	WRQFuGzMntm6Q0OAvNonXRaExHGAzoRWhtO48StwLbqTjvyAy5FgaPXIq+/4Le+w
	HazBfzLjb5lHilRQk4lXdJBuEgsSCWnPoODRIZbSH/3ZJOaTsvElDARROVYZVkI4
	dxyd4noVkRw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DAD8BD1B6;
	Mon, 21 Jun 2010 14:31:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A1CCBD1AE; Mon, 21 Jun
 2010 14:31:36 -0400 (EDT)
In-Reply-To: <AANLkTiksOHr2m4HCPp8779VG95zexvYwgE86MsFzBJxF@mail.gmail.com>
 (Pavan Kumar Sunkara's message of "Mon\, 21 Jun 2010 21\:07\:16 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B201672-7D63-11DF-9587-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149429>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> So, here is the message ID
> 1275399845-13311-1-git-send-email-pavan.sss1991@gmail.com

Do you really mean that one?  Jakub had quite long review comments; so did
Pasky.  I had an impression that the following was the last/latest version.

    Subject: [PATCHv2] git-instaweb: Add option to reuse previous config file
    Date: Wed,  2 Jun 2010 03:29:49 +0530
    Message-ID: <1275429589-30634-1-git-send-email-pavan.sss1991@gmail.com>

(FYI, you can visit "http://mid.gmane.org/$that_message_id", click on its
subject string to see the thread in context).

I see Jakub's Ack to it.  Please confirm that one is what you meant and
I'll apply.

Thanks.
