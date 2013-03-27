From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fixed typo in git-pull manual
Date: Wed, 27 Mar 2013 11:01:25 -0700
Message-ID: <7vboa4n2mi.fsf@alter.siamese.dyndns.org>
References: <7vmwtoomav.fsf@alter.siamese.dyndns.org>
 <1364403956-20443-1-git-send-email-mihai@mihaic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mihai =?utf-8?Q?Capot=C4=83?= <mihai@mihaic.ro>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKufe-0003YJ-4V
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3C0SBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:01:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab3C0SB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:01:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5284ACD9;
	Wed, 27 Mar 2013 14:01:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=NMm+0b
	Co7rwv5CiJT1DAn08kjVq7FuD5aQuWr9RdzTQAh8uTnGwLFlFnLdhAvSnygHb4uH
	dAvDYpWn4fhd9YvbE3QuKfQibPNt/M5KT65Wu+7A1PASCU7ByIf3EfTDG4yCAz4J
	7CrNpkzpddkCcbT67q6OLVwmeU1KuqP/fZWhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D22tlrEtSdQ5gz5WmkE+5gecyE9JPw3b
	Wv7ZvocpaTan6CotG51Ig9+B7iKtghC0gs645rJlkRc5kKL1VAKBQXHEcc8eTMj7
	YxEGWPAxTX1gS8jwmQlxQjBFm9p4rX3lYU4ARP8wELtO/ULaxX1fUpCPG+wgzKoW
	wAUegpj2eW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C95E5ACD8;
	Wed, 27 Mar 2013 14:01:28 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C54CACD7; Wed, 27 Mar 2013
 14:01:28 -0400 (EDT)
In-Reply-To: <1364403956-20443-1-git-send-email-mihai@mihaic.ro> ("Mihai
 =?utf-8?Q?Capot=C4=83=22's?= message of "Wed, 27 Mar 2013 18:05:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58FF7702-9708-11E2-AC13-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219292>

Thanks.
