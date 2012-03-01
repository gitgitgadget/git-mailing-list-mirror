From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Wed, 29 Feb 2012 16:50:33 -0800
Message-ID: <7vehtdqh46.fsf@alter.siamese.dyndns.org>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <rmifwdti2ap.fsf@fnord.ir.bbn.com>
 <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Troxel <gdt@ir.bbn.com>, Jonathan Nieder <jrnieder@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 01:50:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2uED-0004a3-Lm
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 01:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757958Ab2CAAuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 19:50:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757919Ab2CAAug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 19:50:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE587E45;
	Wed, 29 Feb 2012 19:50:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dQ8/tVHht5Ls8zyWjdIKU5X/Xo8=; b=Ir5bPr
	w2UKQUJ1XaGmzhLpJg3p0rknZiiU3o4tngPc6DBw8aIKWR9kISwPfbwrVfqD6WOV
	xM3vyaSYTANUtvmaPEKRuBC1gpXOj2kYWWp4XilskEdsfOMI0Ew2TzGE6W7OB8u9
	xMSuZqMCleGiisv9/g20vUyO0hbga3htzN5fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XyOH3osw2IF1T9Pe/JZIIrAHnOr2ptOz
	+0Xjmeg7leNycER5GLxvxULHSnpz6noP4eNZfxiM3esutxgItUrDYP5W9G6kHZUT
	m5oA3AZsrDMBSO3Mp/+fCjLMWU2KYcpUtSaBswbVeKTJgZzzbMicrzP7MjnLvmg6
	5YTdL1hZEmQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61AC07E44;
	Wed, 29 Feb 2012 19:50:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB46F7E43; Wed, 29 Feb 2012
 19:50:34 -0500 (EST)
In-Reply-To: <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com> (Andrew
 Ardill's message of "Thu, 1 Mar 2012 11:45:52 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E03D15A-6338-11E1-BC1D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191869>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> Additionally, if we are not prepared to use non-Free tools, we should
> probably stop using github. (This example is a little trite, seeing as
> there are non-github alternatives available for grabbing the source
> code.

Just on this part.

Github is not the only place to grab the source code.  Far from it.
