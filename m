From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n update for maint branch
Date: Mon, 06 Jan 2014 09:10:41 -0800
Message-ID: <xmqqppo5jasu.fsf@gitster.dls.corp.google.com>
References: <CANYiYbFc6jEQpwpNOTL9hH3pU-c0y6Umb4wDgeWGEDFfHN-vDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:10:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0DhR-0002Wn-EH
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbaAFRKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:10:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40416 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947AbaAFRKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:10:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C595D55C;
	Mon,  6 Jan 2014 12:10:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oUVatcO5IJ37N0KuYX0W/NQhzIc=; b=SqqWpm
	bPWm4cBuexsUUYLbI/YbR01ilzsxMEgzwG8cU9LB65dIE0xhvn7gAejlK5wr7p7j
	4Jidp+SP36FjqvUtKm6QZ6ozGSYTm8rXO7D/HQmxxOrehmGLtr/H8nskPWMMklVB
	UvGwQwSJ9+YafbhvCKnPYRNg9FUKgd68hrqrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mP95Yqc/6PHSuqdOIOvm9tL1dwYKwmBO
	ofvXBbn9kWzKReJdKVKHN3aAJa3WHldA7SkCVR1qgnRKa7vPHYhLavTt6c7eU5fM
	4k94GR5416Cao5ODOVXimBrjxLVZOllKYeiOEERxkyjw2BOsRAK6qJ0ZFAVhh95A
	nFJdwxFIwRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 662D65D55A;
	Mon,  6 Jan 2014 12:10:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADA495D558;
	Mon,  6 Jan 2014 12:10:43 -0500 (EST)
In-Reply-To: <CANYiYbFc6jEQpwpNOTL9hH3pU-c0y6Umb4wDgeWGEDFfHN-vDQ@mail.gmail.com>
	(Jiang Xin's message of "Mon, 6 Jan 2014 12:34:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A0110AA-76F5-11E3-B084-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240027>

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull l10n update for maint branch. It can be merged to master
> without conflict.

Thanks.
