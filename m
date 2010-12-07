From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/7] web--browse: coding style
Date: Tue, 07 Dec 2010 15:38:10 -0800
Message-ID: <7v4oapnogt.fsf@alter.siamese.dyndns.org>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 00:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ775-0003du-Ek
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 00:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab0LGXiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 18:38:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab0LGXiW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 18:38:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E04436E1;
	Tue,  7 Dec 2010 18:38:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PFH8UyuwPFbXe2pXwTX/PtME6fQ=; b=w5GA7BI3w74oZCGqL0DpCwi
	Ros2Ele8XKdCDR1oEigSoQIMlDxexC42EO9G/fikdjDar94DLPMNdjbmxfCP9qLn
	NP4JQ26+os3FznImT7SwaGlzqh+jhXKHJ7lzccUWM+B/RmKRUPA1StMjoCDZXKKD
	HIuZys2GuyzjWiwzEhac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=n2ancf7dqk8Gza+yiznfbYKUsavrOJR1dWTRM10h6/GqkTf1A
	P8B6vgrNMP0Pmm5SlaCrkLgxR9bP0M41P6MRRpjWGissQzDih5l06mN1/T3eVbyG
	FGRPakZaORrZA/4ED8Dfmh7iYjv8Yy4TEZ/ZUCPFxCDEPN4smzO4+FMvX8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9D9336DE;
	Tue,  7 Dec 2010 18:38:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78C8D36DA; Tue,  7 Dec 2010
 18:38:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FB4E638-025B-11E0-A8C0-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163148>

Thanks for a patch that is easy to verify.

"git show -w" gives an empty result ;-)
