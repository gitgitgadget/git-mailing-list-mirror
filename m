From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Documentation style fixes
Date: Sun, 17 Jan 2010 17:18:24 -0800
Message-ID: <7vpr58w6qn.fsf@alter.siamese.dyndns.org>
References: <7vaawp4wvz.fsf@alter.siamese.dyndns.org>
 <cover.1263081032.git.trast@student.ethz.ch>
 <201001100107.29920.trast@student.ethz.ch>
 <7vfx6efox9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 18 02:18:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWgGQ-0003HS-0d
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 02:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532Ab0ARBSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 20:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531Ab0ARBSf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 20:18:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab0ARBSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 20:18:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1E5C924F2;
	Sun, 17 Jan 2010 20:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2T4/ZXbbzWLxue7a2a9Q56K1C5E=; b=AD7zcj
	HYhbRs2i4hNKqIWbC5s6/LF/w/dRlnerfwKkwxfswYLKVpJl4ybgbfKcnswQWu47
	SwcIwpeYRfcDAic73fy4FOtmPQNJpxFaAOXHm41ShT95ypjL15PJRNfLzYvuypo8
	e8skfkKTuM25o6Gk8khY5YqnwrIJP9T3khWPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AUuLpwp419FVOoCMK1QQLq8Hj5e5Gh56
	S/0yEcocxTjrxM+GLV48bpHI4g1vc5L+HPyi9khd1tjMkIHWOHN7sjfuMIzyAJcu
	H53JBmCLUt5XmdTaNjMZTFBEk9K77u+NPSPdzIaVRlchfn3Z1JgoPUkP9jtLwHU7
	dzyt4r3JMF8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA1D2924F1;
	Sun, 17 Jan 2010 20:18:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0849E924EE; Sun, 17 Jan
 2010 20:18:25 -0500 (EST)
In-Reply-To: <7vfx6efox9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 09 Jan 2010 22\:34\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 62E4C094-03CF-11DF-BF62-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137353>

I think we have given people enough time to comment, so I am going to
merge 0b444cd (Documentation: spell 'git cmd' without dash throughout,
2010-01-10) which was taken from the tip of your for-next branch and that
has been in 'pu' for the last week.
