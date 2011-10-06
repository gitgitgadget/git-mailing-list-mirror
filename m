From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] reroll bc/attr-ignore-case
Date: Thu, 06 Oct 2011 13:57:03 -0700
Message-ID: <7vfwj5zvmo.fsf@alter.siamese.dyndns.org>
References: <U4wiHVyDLLG1PhI-8iY3YvK8PNPcrE_H1LfZdeQFnOrSJ5O-Hev7KzBOnrAY-vjiT2yzgWpfSAPFG2-cG0LrUPezOcTUNC6trUWFODOXIkXyJzvz-maBv6HrPKDCs98TTT4OGmgo0j8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, j.sixt@viscovery.net
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 06 22:57:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBv0D-0000k1-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184Ab1JFU5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 16:57:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756843Ab1JFU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:57:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F32506049;
	Thu,  6 Oct 2011 16:57:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=S0GzB3
	rTezlYczsfuORtodYjd6H6Zzy8BTcaFrT4wxdMG8+XilHOCYaU9m9TfF4OrJeUGd
	LxFRcOtFrb2MH0rkkpQFUOr5Wbg3tECY6X31lep4GCMOuXSpDdUHvUB2m9fbUKK4
	quNbVeyi+xAOz1KnS0IesFJQDLnqgiss3MUaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rAYmpV9pTPrESU+HVT+4cT0YS8Ybzy2k
	ci0BqSN8Y8K/JdYPm8JTP/P+1bv0yCDP7EwTeCIEp/GJxCiqlYJoAbWCnpTkEuRy
	6FVO/il2eS4xUJdeRS/FQatvWKANP74NRbUq+5V2DdYp7of49m05lZ/69BM7v4Gt
	nsgym/t0Meg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA57B6048;
	Thu,  6 Oct 2011 16:57:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C4726047; Thu,  6 Oct 2011
 16:57:06 -0400 (EDT)
In-Reply-To: <U4wiHVyDLLG1PhI-8iY3YvK8PNPcrE_H1LfZdeQFnOrSJ5O-Hev7KzBOnrAY-vjiT2yzgWpfSAPFG2-cG0LrUPezOcTUNC6trUWFODOXIkXyJzvz-maBv6HrPKDCs98TTT4OGmgo0j8@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 6 Oct 2011 13:22:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFF9A91C-F05D-11E0-B1EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183032>

Thanks.
