From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestions for "What's cooking"
Date: Thu, 13 Sep 2012 21:24:39 -0700
Message-ID: <7v7grx9qpk.fsf@alter.siamese.dyndns.org>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org>
 <504F8427.1020507@web.de> <7vhar4gxdq.fsf@alter.siamese.dyndns.org>
 <5050E0CA.7080907@web.de> <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley>
 <CAH5451kmwZehys4nL+NV8m8VGjDJtkSxru3o44_J_d3jD5ipxA@mail.gmail.com>
 <7vmx0t94rc.fsf@alter.siamese.dyndns.org>
 <CAH5451n3bAkidWrtu4sy=NXPYZ7wWc+WFoReOm98xq2S22+55w@mail.gmail.com>
 <7vboh99w1z.fsf@alter.siamese.dyndns.org>
 <CAH5451m28z_5Hbtyqx3+YkR-CoTNFB9bjLx6A1cJJXtj3hVjQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 06:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCNSV-0001ag-8s
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 06:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab2INEYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 00:24:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702Ab2INEYl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 00:24:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11A498E7E;
	Fri, 14 Sep 2012 00:24:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AiLOKWJs47bubhSM3K5wCP4tnTc=; b=JA3IAP
	ewizzcDKP0kxUmxL5pFp4Fbpl5M7fu3TnvG7UOZYorn0KtzFpJ4Vk1E/DI1bZCL4
	ooLpsHFG0mmOd7fKCkxytSdsGj/38XhwlAAs3mK6uQQChdBVOBop3e/8AgUhJK4p
	TsyDRUm/rWSub+0mPTWwk7yuNVy+rIdTmU9Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oq8XBMhNytetiwwu8JrPhLNJ0QfQ7Kaf
	ajENMyd5txchP6TqG2bkiJuth88YpDb+51MbIRCkGzDrZ2//h7JMeBOmDMTmN399
	K32GHUdH33QwCXKa7clRPu7Myc3lufuaLx42zOllIQLHM7jKQWYOnPebXJ01YlZB
	ZlGqt2YJgiA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F38578E7D;
	Fri, 14 Sep 2012 00:24:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F4818E7C; Fri, 14 Sep 2012
 00:24:40 -0400 (EDT)
In-Reply-To: <CAH5451m28z_5Hbtyqx3+YkR-CoTNFB9bjLx6A1cJJXtj3hVjQQ@mail.gmail.com> (Andrew
 Ardill's message of "Fri, 14 Sep 2012 13:58:05 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19E6801A-FE24-11E1-BD9A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205449>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> I feel a little bit like I might be bikeshedding this...

Yes you are.
