From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1] Documentation: add setup instructions for Travis CI
Date: Thu, 14 Apr 2016 11:14:07 +0200
Message-ID: <vpqmvowwo0w.fsf@anie.imag.fr>
References: <1460526571-93634-1-git-send-email-larsxschneider@gmail.com>
	<xmqq4mb5l86f.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYBK-MNYZRo+LsBqng47usGPQTyBe01W2SrKDrs3435sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 11:14:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqdM1-00087O-0L
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 11:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbcDNJOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 05:14:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47095 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbcDNJOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 05:14:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3E9E7s5006978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 14 Apr 2016 11:14:07 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3E9E7Tj029052;
	Thu, 14 Apr 2016 11:14:07 +0200
In-Reply-To: <CAGZ79kYBK-MNYZRo+LsBqng47usGPQTyBe01W2SrKDrs3435sQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Apr 2016 10:56:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 14 Apr 2016 11:14:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3E9E7s5006978
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461230048.29214@UtMBF9AiWr9JgUA9ByqzTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291516>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Apr 13, 2016 at 10:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> here, create a "GitHub-Travis CI hints" section just before "MUA
>> specific hints" section,
>
> Somebody (I think it was you, Lars?) at GitMerge suggested to break
> up the SubmittingPatches document into more than one, i.e.
> the MUA hints and the Github-Travis hints could become their own documents,
> and the SubmittingPatches could just contain the bare essentials.

I didn't see it on-list, but there's a PR doing that here:

https://github.com/git/git/pull/223

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
