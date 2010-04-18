From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] SubmittingPatches: What to base work on
Date: Sun, 18 Apr 2010 16:11:09 -0700
Message-ID: <7v1vecuzjm.fsf@alter.siamese.dyndns.org>
References: <1271620352-sup-4304@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 01:11:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3deX-0000y2-1N
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 01:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab0DRXLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 19:11:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab0DRXLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 19:11:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 184EDAC9ED;
	Sun, 18 Apr 2010 19:11:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=4dWHyV8QYm83JWwz3oFIVPCnVe8=; b=Dtidbq2UTzCGjblPV5JwtUy
	NxlwJXsM/i6cS5Jzf48nOPsL409VzyM0cSbWk/AgzHumsEANBTIHsVUNU0JAICQQ
	nx7bcZeHqdq3TvBPzSStQ9e5pxMRhQ90RD2mBEH0I5wJ77210dUUlizJblVKX9zJ
	1teDhJQPQmfwCO8IGofk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fbRajubvyUebiuds8ArDfn2T0TSWNB+zRopspfbR86pmhB0zh
	IiinNfeAFFMEkTEFsqcZGBf5/4Xfpvd+YM/cKbGvTD7M61Jqew9mv/DIn0D6ZvxO
	BCk5I3ls5QBq3hfAlV/8tYc6gM3pftcIohWxOn2tRKN2TLoGq/5f+Ipzys=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA902AC9EB;
	Sun, 18 Apr 2010 19:11:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 366DEAC9E8; Sun, 18 Apr
 2010 19:11:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFC9CCE4-4B3F-11DF-96C7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145255>

Thanks; I like the final resulting test.
