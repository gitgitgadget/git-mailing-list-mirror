From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/11] Remove unnecessary historical note from "Object storage format"
Date: Tue, 27 Aug 2013 12:16:14 -0700
Message-ID: <xmqq38pvc5c1.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<2104057570.34585.1377626648812.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOkX-0006nw-37
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab3H0TQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:16:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab3H0TQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:16:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 567093C190;
	Tue, 27 Aug 2013 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nmwJmseJg+MH5pNHMIHJ82e5TiE=; b=JW3Rh9
	shtjXfmjZzHEXqxbxcI7cMRTkYsOaL4cwsUh0La26LUYf36WH3rXozsKMbS6QwYT
	2juPIEBSFhTqz/HBaVFUcxyc08s80VlAUmMvBDA/nU5X5PFgKGn+jUnxuRkew8P1
	5NCcAzFU1wO9z1EW8f/19Vhv8J2X+hjbq9IDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MuqCBdZxttZRJBR6p6/PeBT4L/zklv6N
	Z3XgrAMYgfOpg/xpTTg8ZvPI4GJ0cC2nkp5uNjH0dRHEz1sTy30yZVAB9eBz/PlQ
	JyZEC43beqvB8SmvSVvvqp6M0dYX6HvjUrRIksVFLAJIPkhE1Xi+qO0Ys5htRN12
	5+f3vNCXL80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49AE73C18F;
	Tue, 27 Aug 2013 19:16:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C42F3C18C;
	Tue, 27 Aug 2013 19:16:15 +0000 (UTC)
In-Reply-To: <2104057570.34585.1377626648812.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 20:04:08 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 24CA16DC-0F4D-11E3-82FA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233142>

Good. Thanks.
