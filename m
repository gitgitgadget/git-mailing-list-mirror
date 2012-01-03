From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible submodule or submodule documentation issue
Date: Tue, 03 Jan 2012 12:48:21 -0800
Message-ID: <7vvcosseay.fsf@alter.siamese.dyndns.org>
References: <1325013859.1987.65.camel@yos> <4EFB725C.7030600@web.de>
 <1325127030.1681.35.camel@yos> <4F00780C.7090801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Zaumen <bill.zaumen+git@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:48:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiBHY-0002Es-Pf
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab2ACUsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:48:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643Ab2ACUsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:48:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D630A6CA4;
	Tue,  3 Jan 2012 15:48:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vJffBc7/+CYCLfTj38WyaSDX7q8=; b=kY3Ore
	tif63ltNnuZENjuoj/gWK2VhC1Arky46sL+Tw98ELlaycon92J7z8ZYHheA6JAdZ
	180LoVpsM/wAidPqT1dt/AJInaaqo2Y3D/53Wj61YD43UhLp5Qnhiexsqjjse1Jp
	80iinKdZ0a7BISPcPqXER9MIoIiUIsgpX8Dww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+4wdXIN6shfeKSiBxHUHXS7bNDekgkm
	0pLK7Eosog7g5UuMtedrab1e5ulr4CcLi1OEPT5Ql2VjcUMzNgCctl+gAISOhUYO
	hJnNX7UlEqvylGoGsah/tDiNNa7yltGbkPWfEkGsOWJkIDZrQrGZ8S4eTBewK5BA
	H60lcj+mk1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDD426CA3;
	Tue,  3 Jan 2012 15:48:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6721B6CA2; Tue,  3 Jan 2012
 15:48:22 -0500 (EST)
In-Reply-To: <4F00780C.7090801@web.de> (Jens Lehmann's message of "Sun, 01
 Jan 2012 16:13:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4665FA8A-364C-11E1-B1AC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187896>

Will queue; thanks.
