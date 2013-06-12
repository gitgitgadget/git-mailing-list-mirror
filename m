From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/2] status: introduce status.short to enable --short by default
Date: Wed, 12 Jun 2013 08:57:55 +0200
Message-ID: <vpqfvwn24uk.fsf@anie.imag.fr>
References: <1370957645-17905-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<7v1u889vkj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 08:58:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umf0R-0001VT-L5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 08:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab3FLG6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 02:58:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37587 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190Ab3FLG6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 02:58:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5C6vtJM029193
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 08:57:55 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Umf0F-0000Nv-TV; Wed, 12 Jun 2013 08:57:55 +0200
In-Reply-To: <7v1u889vkj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 11 Jun 2013 14:38:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 08:57:57 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227588>

Junio C Hamano <gitster@pobox.com> writes:

> I'll queue this patch after tweaking the test part like this.

I agree your version is better, thanks.

Jorge: this means if you have to edit the patch further, you'll have to
start with the version in Junio's pu. But hopefully you won't have to.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
