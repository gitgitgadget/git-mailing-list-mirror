From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/51] ref-api-C and ref-api-D re-roll
Date: Mon, 12 Dec 2011 00:24:58 -0800
Message-ID: <7vmxay6vtx.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Dec 12 09:25:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1CH-0002Rx-4p
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab1LLIZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:25:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab1LLIZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:25:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10135274E;
	Mon, 12 Dec 2011 03:25:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGVew5zbvWUwNIZYLy2t3g6MfeA=; b=rzr/Xs
	aZF6ngKvmo7egjI99OIML2GQsXLIeleoiRcaA5yygp3p+O3OESoeR6X7gUUbpWh6
	dpVaSvyqp9HAfBXrb3AG5cNNdZdSTlNxLtxF03qokWl382IVK+7Z8aDS1MN1NHma
	dbQIWyb819b1EXeTiirgWwmJrTTUOQCx77ymQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S6RiVykOIGtLzXDSbyGeKNjPRoupL7jP
	h+PXvpzk6nFqrPFG9vwltsgSgXkXHa3MD6m9DLaLzSQa2eOeMjszw3He5rCIWm6D
	KvfgpmxRqKK6bGqz5zcnZpX+a4KeJz0HY2rwZj79WqJ3tWTgOwHKb1ld3ovXyd6a
	AMhUF3r5ekQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0732B274D;
	Mon, 12 Dec 2011 03:25:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88AFE274C; Mon, 12 Dec 2011
 03:24:59 -0500 (EST)
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Mon, 12 Dec 2011 06:38:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7F142F8-249A-11E1-942B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186889>

Thanks for a re-roll. Will take a look early this week.
