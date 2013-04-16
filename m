From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] i18n: branch: mark strings for translation
Date: Mon, 15 Apr 2013 21:18:16 -0700
Message-ID: <7vsj2rnm5z.fsf@alter.siamese.dyndns.org>
References: <20130416024021.GG3262@elie.Belkin>
 <e31669b2dc24ac07de4ed23e00d5a38de5fcda8b.1366082959.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:18:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxLb-0000cH-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab3DPESU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:18:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab3DPEST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:18:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA6061090E;
	Tue, 16 Apr 2013 04:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QwCvSPWtu2Wz9eUWe30U6QHoK2E=; b=typxYP
	Ck6o+rIY7eZHtn6pwbI8JxCZyTG9i3xe1s0tEbL6L/emKUcVR/Bj5cII0yDA5IRb
	XX5W1B5QthLm2FSEQs4WUC84rrcTzl9donBjeFAt6m5UGz1YTKb41fHnwmRBjuVy
	KgkorsIZKm6XXVkGXUTqfpWEHa0dkmV1ea5dI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TidMPbPv8sU1uGIQ1y4ucjPJlKW7v+G4
	Hofdxq5in2B4kl1UecC2OxK6einCSjQyabwgZl6Rr8e/6GotjWfPDkVIyV73xBPy
	MC9QhEtFO1Wxb/qa5JUy19fKziSdGlNs8TDEeID4DUm03I3X3L+KUhLtV0duRUqI
	McrwnZ8zDzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA401090D;
	Tue, 16 Apr 2013 04:18:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 366D51090C; Tue, 16 Apr
 2013 04:18:18 +0000 (UTC)
In-Reply-To: <e31669b2dc24ac07de4ed23e00d5a38de5fcda8b.1366082959.git.worldhello.net@gmail.com> (Jiang Xin's message of "Tue, 16 Apr 2013 11:37:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA78C39C-A64C-11E2-AEDC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221360>

Thanks, both.  Will replace what is queued with this version.
