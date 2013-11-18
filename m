From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] remote-hg, remote-bzr fixes
Date: Mon, 18 Nov 2013 13:47:07 -0800
Message-ID: <xmqq61rpbcx0.fsf@gitster.dls.corp.google.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
	<1384747970-25481-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 22:47:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViWf6-0004YV-4S
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 22:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab3KRVrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 16:47:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3KRVrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 16:47:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60F6951196;
	Mon, 18 Nov 2013 16:47:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=szqHS1pIBo5Db3RWHn5fhGfkJUc=; b=l1fZXI
	XHF3RAG6PdXTME67asKg0+Xo8lGv5ZIK4eyDzyDrNqoWHkIW63Qz1WYHuBz6Eii6
	JdWEKnkXO0Gu9S4vdeChZ2aMWI44USTpodkC/ys1DPHTSROI90FRmb055UwF7gvC
	Y+vCxQPOWVdEgndpkIZn73E5juSlQrMPyBXlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YS7We2MI0TdhmHC7LpPaTDlS81AQWSC9
	2BZAVPZPAXeUlQ1nJi3BkspBg6SEl6TLxwuJ6eYQdiWOdPBhzezunKE/vM9n4dhK
	d6Bk5fKqONBhH/S/DHZ9qAfdwR5n8A0SjkmmGkhZo+HgnQ7cd0XJqOpxBGSOAGNC
	Fv1WM/K9NOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5013351195;
	Mon, 18 Nov 2013 16:47:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88AE651194;
	Mon, 18 Nov 2013 16:47:10 -0500 (EST)
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Sun, 17 Nov 2013 23:12:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA4B9B58-509A-11E3-BF51-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238016>

Thanks, will requeue.
