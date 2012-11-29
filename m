From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull l10n updates for 1.8.1 round 1
Date: Wed, 28 Nov 2012 21:59:10 -0800
Message-ID: <7vobihrlu9.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHfhBXbLEEKdpJkhp+wY9-AJ1JkjfO62W3c+dm8qpk7_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 06:59:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdx9k-00017t-59
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 06:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab2K2F7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 00:59:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab2K2F7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 00:59:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38F48AD04;
	Thu, 29 Nov 2012 00:59:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=evpoi9
	M0tZx5Iq5DUscWi2I3MJSG8C6C1GQ2HzCG9I6PYqWcoQsbnGMpPOTXR6LAchb1wQ
	uaXkM2FzRQ7d0+mu/jcSXNNRH+YKY5jZhmYd447YLmECsmkJbb1BkVcVGQ+hVQt9
	8Sg2bTfKAj4kBzxpOY6aOZSmW3GsH2nOWgALI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bwZMhv0x1wjbY0nU1ce0Uv70cjenIDyr
	0DoJNFYBlYJE8nBWD4PSyO8zaOkK0R1Psrss0dPXeGzz+huCEJF+TDp0E/sERJyT
	ci8Bn25pgv4LO2pMJQyqMl5tgInPThc61SToToLjuH5mUJEAbKFwDKd+/cz56vxB
	Pz9A9WXBaYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25A1AAD03;
	Thu, 29 Nov 2012 00:59:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99195AD02; Thu, 29 Nov 2012
 00:59:11 -0500 (EST)
In-Reply-To: <CANYiYbHfhBXbLEEKdpJkhp+wY9-AJ1JkjfO62W3c+dm8qpk7_g@mail.gmail.com> (Jiang
 Xin's message of "Thu, 29 Nov 2012 09:19:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E593B4D4-39E9-11E2-A3C9-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210808>

Thanks.
