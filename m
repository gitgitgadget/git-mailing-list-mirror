From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] urls.txt: avoid auto converting to hyperlink
Date: Fri, 24 May 2013 10:55:50 -0700
Message-ID: <7vip289s9l.fsf@alter.siamese.dyndns.org>
References: <1369410243-27732-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 19:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfwDd-0004XG-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 19:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab3EXRzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 13:55:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab3EXRzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 13:55:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90BC820CE9;
	Fri, 24 May 2013 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=vWOATu
	/zRIMi7OgREeGzEV8ylIVFwYYrQ6TItF+D8IB+cQxbJcoEpZkawHsCv2kuFVTOrq
	8IDP41VDP/ugajUpns/shYKDXqWmIuWKzxQMVCkrHK9q21wm52y0DCD0mnyOedCc
	OaPJje6il9OaMyJiNC3oQcOH4MwHPDub3P6Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=baBzL5gIXOBJQp2cQ/yqnJJazyI6FA37
	y4fWCAwqBFOCuftdnG+SwBWuytGCQh1BZ5Cv27VcGEXz4f623dosGm3ogBjoG6lI
	8WdC0pGCmSAUpJmAD43YWcbjY+LoZsoYEHsQTo/1x5H3TNY9mykWDpjbX0U//RKb
	FCXgxUHMmyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 868D020CE8;
	Fri, 24 May 2013 17:55:52 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AF1220CE6;
	Fri, 24 May 2013 17:55:51 +0000 (UTC)
In-Reply-To: <1369410243-27732-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 24
 May 2013 22:44:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C47CED8-C49B-11E2-A9BA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225389>

Thanks.
