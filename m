From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/16] Make Gnome Credential helper more Gnome-y and support ancient distros
Date: Tue, 15 Oct 2013 15:40:45 -0700
Message-ID: <xmqqppr6b1jl.fsf@gitster.dls.corp.google.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <john@szakmeister.net>, <pah@qo.cx>,
	<felipe.contreras@gmail.com>, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:40:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDIL-0007Ep-EW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933880Ab3JOWkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:40:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933634Ab3JOWks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:40:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DC44AD24;
	Tue, 15 Oct 2013 22:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GyGtsjie3qlhqmwl81nZ+FLmrvo=; b=cSzl7d
	+awrRQ+8ETkfPXCelwlMBbnII249FZicmz1XNTKiE/DPwlDu1FDUD+O1HyeGHd1C
	o/E1goo6KsPZIA8O747rpGHIordtHoUc6lySVw2/fpRuh+fsM0y8mCHRxvtC4pz4
	0om2i4RspelfUx3tsODwxwH/RDadEO8ql4+00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ByNLhXRSGvpyEotst+6PegSB+OFMF3j2
	uTcsef9XawJidHEjl8JvvzK/6RFLHO9jCQYKz7g5/xXQ7jWCCNObk6WonGb74Aal
	DRrmZqPqTihoq7inm3RZ8ADfnzohqiysMOEJV3EukoE5iEhS6sZuQI4fFnOUz3xb
	KQ1AuAotRaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46F034AD23;
	Tue, 15 Oct 2013 22:40:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A56AB4AD16;
	Tue, 15 Oct 2013 22:40:47 +0000 (UTC)
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com> (Brandon
	Casey's message of "Mon, 23 Sep 2013 11:49:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D5CD7C12-35EA-11E3-AD88-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236209>

This seems to post-date what Jonathan has kept in his 'pu'; is this
the latest (I have a huge backlog to wade through, so I'd rather
skip it if another reroll is coming and move on to other topics).

Thanks.
