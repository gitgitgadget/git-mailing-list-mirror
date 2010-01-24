From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] clarify 'git merge' documentation
Date: Sun, 24 Jan 2010 11:29:12 -0800
Organization: 
Message-ID: <7v636r714n.fsf@alter.siamese.dyndns.org>
References: <20100123092551.GA7571@progeny.tock>
 <201001241425.07027.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 24 20:29:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ89V-0002Gs-8q
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 20:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab0AXT32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 14:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232Ab0AXT32
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 14:29:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab0AXT3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 14:29:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE6D793624;
	Sun, 24 Jan 2010 14:29:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8xnFxT+Nag4ZCnns452+IpA03g4=; b=aYlMAzybar35JF/Pj62aJSv
	u0RxtTOWyRLlLTRFtGtVuBt3YG/cQeBKJqCOfm/5boGiTT5tBvZn0YOvQOnRip+G
	gIQ3lsn6IuHKDEvqWEr9Pq7sugleE41IJ4+XjLDzRkOhfCfhT8BHL4QWuORrGTBm
	1jrO8N+IbQgbCgfuGf3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fawYU+FVWWBJl99feAD1T/jzEfd4O2a8rGJQ0be/CyuwY1z8C
	w3PczW0NoPR23S65x4GCF6EIEblz0HgTCd9pCAb8m7kgMvh9z8dwcktoNKIqZLcZ
	oPPO8KRuAqpIUWqVT0sB7/38GBm/WFoXaRdJTivKsy9Td0Ys4Q4jbo+ZtA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D04F93611;
	Sun, 24 Jan 2010 14:29:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94B129360B; Sun, 24 Jan
 2010 14:29:13 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4809856-091E-11DF-B31B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137915>

Thanks, pulled.
