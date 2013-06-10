From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/2]  rm: better error message on failure for multiple files
Date: Mon, 10 Jun 2013 18:06:31 +0200
Message-ID: <vpqppvudk6w.fsf@anie.imag.fr>
References: <1370879981-18937-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4cD-0003Io-Tr
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab3FJQGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:06:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34274 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3FJQGh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:06:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AG6U1x004493
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 18:06:30 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um4c3-0004Kc-VL; Mon, 10 Jun 2013 18:06:31 +0200
In-Reply-To: <1370879981-18937-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	(Mathieu Lienard--Mayor's message of "Mon, 10 Jun 2013 17:59:40
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 18:06:30 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227312>

Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr> writes:

> +static void print_eventual_error_files(struct string_list *files_list,

Too french ;-).

Eventual (en) = final, utlime (fr).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
