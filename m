From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] merge, pull: stop advising 'commit -a' in case of conflict
Date: Fri, 29 Aug 2014 08:44:09 +0200
Message-ID: <vpqegvzu75y.fsf@anie.imag.fr>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
	<1409219218-9475-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140828181638.GB20185@google.com>
	<xmqqppfka2bb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 08:44:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNFv7-0001Jx-UE
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 08:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbaH2GoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 02:44:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48532 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbaH2GoU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 02:44:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7T6i8sN025731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Aug 2014 08:44:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7T6i9Pg017646;
	Fri, 29 Aug 2014 08:44:09 +0200
In-Reply-To: <xmqqppfka2bb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 Aug 2014 11:36:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 Aug 2014 08:44:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7T6i8sN025731
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1409899449.98188@RuGAhAjdMVUDuPDXqmTjqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256138>

Junio C Hamano <gitster@pobox.com> writes:

> Here is how I phrased in the one queued tentatively.

OK with me, thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
