From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull l10n updates for 1.8.4 round 2
Date: Fri, 09 Aug 2013 14:32:08 -0700
Message-ID: <7vk3ju4kkn.fsf@alter.siamese.dyndns.org>
References: <CANYiYbGhtMBwxJPOZNs=o3sxD=uLtF=0obOpZG-OZs63dQECSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 23:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uID-00080a-5j
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031210Ab3HIVcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:32:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031121Ab3HIVcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:32:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BACA038C60;
	Fri,  9 Aug 2013 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Ysmecj
	eujcrvW60cSw7kF5Vd8jmZ8VvHi5QkV8QSXqXNJFAf7EJ1MQkgwtvadz2FO9J4CR
	xe3TGlBTEh8O0rnfLOTEH3gZqimWbbZBl5vKsBezJYJH8UuZPQj7SBkSw2cgLATm
	BIAN9Z5ZmlO7Ov5ABch3dYlcNIi++JlXtJaqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gom8jfQBPjmB6ASFqLsQTmtL8a7uL4CG
	SqfTtHRY21VdA64D6H/Yl07YU3UWv2bf/SQAd9oY/CtwkjJWE4G0bK4BxspjB6bP
	ul1Vq/3ta5RZBWMUfpuCMFcVbLrlMMP7kIjXz+qjmLvramDZfANVNyy+eNiqlc3g
	Wdq0Nd/hmX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8F0038C5F;
	Fri,  9 Aug 2013 21:32:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 527FD38C5D;
	Fri,  9 Aug 2013 21:32:10 +0000 (UTC)
In-Reply-To: <CANYiYbGhtMBwxJPOZNs=o3sxD=uLtF=0obOpZG-OZs63dQECSA@mail.gmail.com>
	(Jiang Xin's message of "Fri, 9 Aug 2013 15:39:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2600339E-013B-11E3-915B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232033>

Thanks.
