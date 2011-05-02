From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify meaning of --html-path,
 --man-path, and --info-path
Date: Mon, 02 May 2011 10:24:05 -0700
Message-ID: <7vmxj5nhhm.fsf@alter.siamese.dyndns.org>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
 <20110502060745.GC14547@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGwr8-0007mt-Jx
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 19:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab1EBRYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 13:24:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1EBRYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 13:24:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F8D754F7;
	Mon,  2 May 2011 13:26:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Jvl78r
	RizAAmwu0B+uDx5R3mgajlQsmttAVgsFCeZ544uAXvoWlu/hFNvWa316PICHad8A
	uVXz3/koAsxsyHWJwqrQFzknXZk8c0fEZGIu3O1cIcgEpevquYn801oW1jdxyUBn
	b91F2IEwNwvgo+2EaVWoyZEnkPy+qyOedEE9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fad+GRXvistD3szyKX4fKk49fd+HSGzu
	c5B7P8iC+XwaVlE9VvE5ymrnSdX1vyS+qVs69NMvmlPdy5h+7bepA15vFkck6RoT
	n97fvZ4QNjT6IBrfo3oCMNRFuvOrobQPZNLV0BKjiauNw8ie5ejyBhta5HFiSVBc
	9zHE5yFfucs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E2A3D54F5;
	Mon,  2 May 2011 13:26:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C399554F4; Mon,  2 May 2011
 13:26:10 -0400 (EDT)
In-Reply-To: <20110502060745.GC14547@elie> (Jonathan Nieder's message of
 "Mon, 2 May 2011 01:07:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 482CCC54-74E1-11E0-BF95-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172604>

Thanks.
