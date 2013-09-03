From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t: branch: trivial style fix
Date: Tue, 03 Sep 2013 12:13:37 -0700
Message-ID: <xmqq8uzdsopq.fsf@gitster.dls.corp.google.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
	<1377923511-20787-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 21:14:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGw3h-0003qq-Lb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 21:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933745Ab3ICTOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 15:14:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933691Ab3ICTNp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 15:13:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D3C93E9DA;
	Tue,  3 Sep 2013 19:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L/I4Ks+cDDEW0O82sQ5mEpqdHEg=; b=JQ7gXM
	ijzN2oss/1IgD8eaU3kd7VoXwEhNdIxvQLSGrfq++FG0QTJ/Lr2Q/Tj6+M1rJ/E/
	b3SCADWqjEozAOCXYP/q/tE6x0AkzBmajc0bETnze+lzEtVj5Ty5TP/5MgQlGDrg
	npz1V8pUXD6B86wRRYoAm7JHhPQ3riCxLSJm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/RqbQO/OSkKdeNEqdBn0LFJMu69rQOf
	K6VZw4ADtHsC5lqOw1rAc7enEBuqZF9FoqRqKIh914nJ9C/81hL+o6RYE4jtml2p
	YsjhH1gK1N8GtgwWZDOWgEaE5ooyt563Nz5C43hukEOcnzbToN5+Tk3LuhiMnkgw
	VVadKZOEe74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 752643E9D6;
	Tue,  3 Sep 2013 19:13:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B2803E9BA;
	Tue,  3 Sep 2013 19:13:41 +0000 (UTC)
In-Reply-To: <1377923511-20787-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 23:31:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1D13BAE-14CC-11E3-991F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233760>

The first three are trivially correct and good changes. I still have
to read the last one, but wanted to give a Thanks before doing so,
which would take more time.
