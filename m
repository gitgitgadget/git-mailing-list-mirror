From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] gitk: add the equivalent of diff --color-words
Date: Fri, 16 Apr 2010 23:55:10 -0700
Message-ID: <7vhbna601d.fsf@alter.siamese.dyndns.org>
References: <cover.1271260308.git.trast@student.ethz.ch>
 <bc720738f918f0523842b3839b7e611c453b5241.1271260308.git.trast@student.ethz.ch> <20100417063557.GB6681@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Miles Bader <miles@gnu.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Apr 17 08:55:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O31wR-0001w5-Q4
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 08:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab0DQGza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 02:55:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0DQGz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 02:55:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79DADAB4BF;
	Sat, 17 Apr 2010 02:55:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xmysr396GCxHUiu5Gr1WTqfJ0Oc=; b=p+hxv0
	VletCGu2DrfkDlngHiHSxCWMZvlMuUhdn10zoCHKe9s4mbIVNufrpJz9/QjQTs33
	pl4ePwjsVLrtep/GjJSGtj6aoiHG+UYQIxKXqTS6tVzfphbht+RdEgNqZOXXDrZF
	08in94ObuMK+IvhnkkZRMUlj2O3OIY4DdSePw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OUG3csOjpB1VOEudLyGBbjdafECRGOXU
	IXNCaXDPtGcZRuQczyVKijgr6buI+M+fPugo4Mdh2VlY841+nKJRXDmVBGBOLTXP
	bI3aY+al9wy4nLGguFDTDM2W8ZRBtD7DsLby7QSv+WfKseZVR+R4pIVcpNrfbNPt
	Cb3wNzccZvs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8139AB4B8;
	Sat, 17 Apr 2010 02:55:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3944AB4B0; Sat, 17 Apr
 2010 02:55:11 -0400 (EDT)
In-Reply-To: <20100417063557.GB6681@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Sat\, 17 Apr 2010 16\:35\:57 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2FE3DED6-49EE-11DF-BBA7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145118>

Paul Mackerras <paulus@samba.org> writes:

> When does this need to go in, i.e. when is the git patch likely to go
> in?

I am expecting that this will be in soon after the current 1.7.1 cycle,
sometime around early-to-mid May timeframe.
