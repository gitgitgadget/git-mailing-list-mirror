From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv10 00/11] git notes
Date: Tue, 08 Dec 2009 01:25:36 -0800
Message-ID: <7vskblg6lr.fsf@alter.siamese.dyndns.org>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 10:25:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHwKT-00048I-EI
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 10:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbZLHJZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 04:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbZLHJZk
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 04:25:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbZLHJZi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 04:25:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D47686EC8;
	Tue,  8 Dec 2009 04:25:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rLlLuxcX5hHsdcUgJC2LSkiQVOM=; b=tyntrNiiZHJliTO1y3MJNBL
	3KLtjQNP9E+4NIZpHTl6Q3k8eOGXVurpI8rG7JYy88kgp19MawRqTfhOjx3ysSKx
	Agfp44PX+aORd0yE/kuOnQLP8EpPozlitjULH8eVRyoHSpzNEVUwQqlZ4axPH6ha
	r0s+5ej4fkXxAUaaTwPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nZudVLfcBLRURvSEJe2ivr82VbfVeoovk84D05ULM05EyfQeE
	t5Sh7FgxeT9FiCixq0jmhBa58YLnC57K4L8h1w6Nm0vhjfXDUvRhY/SGAgc46GMr
	s5RvW7lqSanvy+YXDCdTOFYm6/wShq26mOl2QAJMdKZXFvP5pq4dySbSlc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5D5B86EC7;
	Tue,  8 Dec 2009 04:25:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CAE786EC6; Tue,  8 Dec
 2009 04:25:38 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A7BB5020-E3DB-11DE-8FAD-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134847>

Thanks; will re-queue.
