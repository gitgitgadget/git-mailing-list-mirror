From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Industrywide breakthrough innovation - Git as a key role of
 distribution
Date: Mon, 21 Mar 2011 10:28:33 -0700
Message-ID: <7vd3lkqt6m.fsf@alter.siamese.dyndns.org>
References: <AANLkTinkuSJBvftDCh8++UyV5Wc=sMRr1+vc8WbeFYMs@mail.gmail.com>
 <1300716396-sup-4742@nixos> <864o6wiixo.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Weber <marco-oweber@gmx.de>, git <git@vger.kernel.org>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Mon Mar 21 18:28:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1iuV-00050h-6r
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 18:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab1CUR2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 13:28:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab1CUR2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 13:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F1F994EC5;
	Mon, 21 Mar 2011 13:30:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vMLoHpJgHdn0YLNy5XLU8U80t5E=; b=EHE458
	3wwRG/F3axm2DnTPqlRYO+ryTViZ+B4tsCtSoeXdwtVkcs8nDxWTetKw7j5L6oHA
	z4dpmJZqGYjNvYQtm3D414Zkgh0LjfvjvJTULSEhKDew0xPr5/FBbVlEEn3p5DS4
	HE8ObHRQ7/sJn2hFLZVxL46qlqKr6yvRGR114=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kb/lRYd28FjBDFFCFyGuia0Cv9FD/G3b
	TkMurJ/lahpsBKq8nnGAqcUCxXc7a4jalvfz0lfCuI68WCSct274tS6Behq3LIg6
	9fZbqJE1GncdK9ZZu5sHkcWBS6w0zDlvKf+qEl6AgZV0Rsk/dJGkp3NOJQAvNxsg
	0nTEqOU1xVU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF68F4EC0;
	Mon, 21 Mar 2011 13:30:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 976AF4EBD; Mon, 21 Mar 2011
 13:30:12 -0400 (EDT)
In-Reply-To: <864o6wiixo.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Mon, 21 Mar 2011 08:37:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2FB9F34-53E0-11E0-9CD1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169617>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Marc" == Marc Weber <marco-oweber@gmx.de> writes:
>
> Marc> I wrote this mail because I saw your mail - I even clicked on your
> Marc> links - but it didn't make any sense to me previously.
>
> This one didn't make much sense either. I had to read it three times to
> even begin to contemplate "what action am I being asked to do?".

You read it three times?  You have too much time on your hand....
