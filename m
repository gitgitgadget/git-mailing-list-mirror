From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv2 8/8] Doc branch: show -vv option and alternative
Date: Wed, 19 Sep 2012 08:20:40 +0100
Organization: OPDS
Message-ID: <7F3428D75DD2413BAF21B1781FEBC0E2@PhilipOakley>
References: <1348010734-664-9-git-send-email-philipoakley@iee.org> <7va9wmirud.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "gitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 09:20:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEEaJ-0000w7-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 09:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662Ab2ISHU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 03:20:27 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:63289 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753417Ab2ISHU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2012 03:20:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar0OAANYWVBZ8rU+/2dsb2JhbABFi0iwAQECAYEFgQmCGwUBAQUIAQEuHgEBGgcLAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBh3MHuk2LVWKBXoJoYAOIIYVEiRKPDYJn
X-IronPort-AV: E=Sophos;i="4.80,446,1344207600"; 
   d="scan'208";a="404124116"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip01ir2.opaltelecom.net with SMTP; 19 Sep 2012 08:20:25 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205911>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> --v::
>> +-v, -vv::
>>  --verbose::
>>  When in list mode,
>>  show sha1 and commit subject line for each head, along with
>>  relationship to upstream branch (if any). If given twice, print
>> - the name of the upstream branch, as well.
>> + the name of the upstream branch, as well (see also `git remote
>> + show <remote>`).
>
> Can you try
>
> -v::
>        -vv::
>        --verbose::
> The description...
>
> instead?  Cf. 
> http://thread.gmane.org/gmane.comp.version-control.git/205184/focus=205315
>

OK. update maybe a couple of days due to other commitments. 
