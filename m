From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] Cleaning up t4012
Date: Mon, 16 Jul 2012 14:11:05 -0700
Message-ID: <7vsjcrza1i.fsf@alter.siamese.dyndns.org>
References: <20120711221140.GA21303@akuma>
 <cover.1342468069.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Strasser <eclipse7@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 23:11:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqsZX-0001NL-8b
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 23:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab2GPVLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 17:11:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab2GPVLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 17:11:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D06288799;
	Mon, 16 Jul 2012 17:11:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LEMpHqac8bncOOQcybZD1Tb1PJI=; b=LTuugc
	EAH5/PxVt/g8kr7twtn4v8vStNiZpVhTefvxVrToG0i9lpQ/Mc+lsxd0vEn1l/SK
	m/G4g6caW/EioxlW/XUqMW/rfq3fTAhs5P721NYlGOPvvh9cV6MRS3D6/I9u3jWW
	2e7JxY1QQKQz8ETdR1NjRPNj+7TV5GtT0ADhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V9183huXNbYEVNpW3OPTcU8rtRlnoLxh
	1jeE94jUXH1lF1LAO29gT8D99xp8nkpuXWteVf9/u9FfOYyYUhdc5QgSAlJGidqa
	7mgY8T5IMaNftfRR2rnj9n4LQCN0hEv1rG1RmqlckDjynWBAGWMBEPMgoa5rjnmp
	UW4Kd1Ng0tA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B503A8797;
	Mon, 16 Jul 2012 17:11:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 368748792; Mon, 16 Jul 2012
 17:11:07 -0400 (EDT)
In-Reply-To: <cover.1342468069.git.eclipse7@gmx.net> (Alexander Strasser's
 message of "Mon, 16 Jul 2012 22:40:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C26F06DA-CF8A-11E1-B85D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201578>

All looked reasonable; thanks folks.  Will requeue and advance it to
'next'.
