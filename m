From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 19:09:10 +0200
Message-ID: <vpqha5akamh.fsf@anie.imag.fr>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
	<536106EA.5090204@xiplink.com>
	<536129068cc28_1404fdd310fd@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:09:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfY0u-00074v-CV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 19:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759157AbaD3RJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 13:09:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43827 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758836AbaD3RJk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 13:09:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3UH97K6006477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Apr 2014 19:09:08 +0200
Received: from anie.imag.fr (ensi-vpn-228.imag.fr [129.88.57.228])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3UH9ATd012024;
	Wed, 30 Apr 2014 19:09:10 +0200
In-Reply-To: <536129068cc28_1404fdd310fd@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 30 Apr 2014 11:47:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 30 Apr 2014 19:09:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3UH97K6006477
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399482550.04781@3asZoXucGE4R4J9SUzA2Xg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247745>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Marc Branchaud wrote:
>> But I'm definitely biased because I think pull is pretty much broken:
>> 
>> * New users are encouraged to use pull, but all too often the default
>> fetch-then-merge behaviour doesn't match their expectations and they end up
>> starting threads like this one on the mailing list.
>
> Yes, this has been discussed many times in the past, and everyone agrees
> the default behavior is not correct.

You definitely have a strange notion of "everyone".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
