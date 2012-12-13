From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git.txt: add missing info about --git-dir
 command-line option
Date: Thu, 13 Dec 2012 10:54:06 -0800
Message-ID: <7vy5h1ye9d.fsf@alter.siamese.dyndns.org>
References: <1355421439-14024-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:54:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjDvP-0005iq-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 19:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab2LMSyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 13:54:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121Ab2LMSyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 13:54:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F078DA49E;
	Thu, 13 Dec 2012 13:54:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Mnuv5g
	wiOfbuNhnfSpkVBmGvstGlo9ZXkoypJ9kCFk/rRPV7BlpZE8/G8bo/BB1TyRU3h0
	bbTCPnBSTT/HwUTKKOxAvHAdXeFYYrRq3aMsn3y+H7T0YVNMYMBFqSd7D3c++HWH
	Vpgugcn68chiE0epcJ2PD9otKoEGojn/ZVSCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dIodObaMMLR0S0gfW+p5PY9p1h6+VIzh
	4mqhoJjx6wugFhsGF4SRBzirpA8JN1Xx67jyTHNsqcALI7Tru+jdhv90BO142g4+
	2nJDBEl/tgYS6VZWtRVarA7Obwh18Qn9RHsvhi+yq8lVdI4SU6ZXZAhnTBuxHtyI
	3nSEnzHFWx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94F26A49B;
	Thu, 13 Dec 2012 13:54:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1647DA497; Thu, 13 Dec 2012
 13:54:07 -0500 (EST)
In-Reply-To: <1355421439-14024-1-git-send-email-manlio.perillo@gmail.com>
 (Manlio Perillo's message of "Thu, 13 Dec 2012 18:57:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79698432-4556-11E2-989A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211466>

Thanks.
