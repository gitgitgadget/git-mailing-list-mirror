From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 00/14] git notes
Date: Fri, 11 Sep 2009 17:11:59 -0700
Message-ID: <7viqfpowc0.fsf@alter.siamese.dyndns.org>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 02:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmGE6-000223-SY
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 02:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbZILAMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 20:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbZILAMS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 20:12:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbZILAMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 20:12:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5B204D1DC;
	Fri, 11 Sep 2009 20:12:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Eyq3E/Mhn8JjJNxPtkVyhE8K/I=; b=Pa0THf
	0nJ2EcOnPxInLOCeEPKqUN4EMVzLu31mOn/IOCJKqFxcnCN2AkrLlAReA5wYDVZH
	ISO4S5R3Z4wZq2oLnd27JajwP+9+PhEd9LtUnhbt5DPeaiUmgW31GRKKyT83HMnF
	l7LuuaJIYe6CGTfirvFitp96jVyOn1lDo8gJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ljjAX2KijAl/HVP6rnQ2KFkd59uzoE4L
	X+o45C11KiuLdfczdBIazZmzUb/a1v81mcOykqhWX9q1dcTmeXE4VMsextU9LJY0
	eO3yY6OkZo3xFWIz5nROdu5m/tl+fDh+MRQBiGGrJnZPscBObt465fXve4boGWmx
	vCvdMvHPxww=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 653CC4D1DB;
	Fri, 11 Sep 2009 20:12:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 897984D1D2; Fri, 11 Sep 2009
 20:12:01 -0400 (EDT)
In-Reply-To: <1252376822-6138-1-git-send-email-johan@herland.net> (Johan
 Herland's message of "Tue\, 08 Sep 2009 04\:26\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB5CC074-9F30-11DE-845F-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128232>

Johan Herland <johan@herland.net> writes:

> Yet another iteration of the 'git notes' feature. Rebased on top of 'next':

By the way I didn't pick this up as it did not apply to any of my
branches.
