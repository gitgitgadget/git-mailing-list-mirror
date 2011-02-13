From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Remove deprecated commands
Date: Sun, 13 Feb 2011 15:14:02 -0800
Message-ID: <7vzkpzv879.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D4852EE.6080605@lsrfire.ath.cx>
 <20110202005748.GA13803@elie> <4D543FB4.1040709@lsrfire.ath.cx>
 <20110210205620.GD21144@elie> <4D5689FA.90804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 14 00:14:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pol9C-0007Wy-TP
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 00:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab1BMXOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 18:14:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245Ab1BMXON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 18:14:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FBD83E25;
	Sun, 13 Feb 2011 18:15:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RuN9xTKDvBjIK4Wvx6hQWnF6z9Q=; b=dbzC2V
	cYmDR2XZ0Gh012NCxP9p5lHLJLIDLOMRlfmKMYq9gr/pYgQ61UB/VXTePYgU8V/R
	y6EX7UrWVi0RPi0vaiWAlGKVfYF6Ff/cO5rn/7CvQR4RSVJi7iJ/Ln4zSiKoLmRq
	HA9d9l0z4hpkctgas+r7rgQ6ET3pBqaX9o0iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ryh2kUt4Mga2jnyTK5YliMvJZy2mc1jt
	SRADRC5QU/wNgya5LYjWjj/piQH8b0hIt1FbNr2V9l9xU9f7yCjY4Ce9KLsNqKMO
	2EwcIPc58wAlefpiCh3r+p28L3pjE5upvnSUEvovKOo6vsVgWcH7/MvQFGDttOgd
	GRKG2/DNIHo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB0E03E24;
	Sun, 13 Feb 2011 18:15:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8837E3E23; Sun, 13 Feb 2011
 18:15:08 -0500 (EST)
In-Reply-To: <4D5689FA.90804@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat\, 12 Feb 2011 14\:24\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C9C3BEE-37C7-11E0-A1E3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166681>

Thanks; applied.
