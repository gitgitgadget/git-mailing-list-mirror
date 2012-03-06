From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] Documentation/git-branch: cleanups
Date: Tue, 06 Mar 2012 11:43:41 -0800
Message-ID: <7vobs9sefm.fsf@alter.siamese.dyndns.org>
References: <1331023866-5658-1-git-send-email-vfr@lyx.org>
 <1331026365-7044-1-git-send-email-user@vincent-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 20:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S50IX-0004iH-7d
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 20:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232Ab2CFTno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 14:43:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965176Ab2CFTno (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 14:43:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9380963B4;
	Tue,  6 Mar 2012 14:43:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dtypmHRfcO3M1zX+6EWmN9tksk=; b=KflHef
	rYCAJxKCGXknT8DHjmzHKpjHSM0y6WAwTp59S9SWZ9VKpveO1zMiNsimHPK/LiqF
	QfwUSdFrgmjEQt8i8ZAET0WfUMeEucvM1e1GRLEQPUgL3pPiSpihBoQhxV2B2BRm
	HNOihfw0CqwJWwCxncp0d3vlAygKuDt/Qevt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KIi/tY7xKY3u7OoHDnZXAVWZx7MZAjJk
	cAPMT/QRlbVWja/v+8Xc7CTgUKEbDUdnTY91IQyzZoXbbUMiEnVU85Vi36O9xwWG
	MU3KLbzxg1C0lymFaBNy6x34zGdXO3L1TvBMyy5YUJz9XCd9o4PzPQixfwCd/sUe
	2YoHwGf45sY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AD8263AF;
	Tue,  6 Mar 2012 14:43:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2233163AE; Tue,  6 Mar 2012
 14:43:43 -0500 (EST)
In-Reply-To: <1331026365-7044-1-git-send-email-user@vincent-VirtualBox>
 (Vincent van Ravesteijn's message of "Tue, 6 Mar 2012 10:32:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE30CB50-67C4-11E1-89F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192381>

Thanks, both.
Will queue.
