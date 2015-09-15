From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Sep 2015, #03; Mon, 14)
Date: Tue, 15 Sep 2015 08:17:30 +0100
Organization: OPDS
Message-ID: <CADC2CE86A4B4F918F6558BDD8EA628B@PhilipOakley>
References: <xmqq613cvczi.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 09:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbkUT-0001sy-Dk
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 09:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbbIOHRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 03:17:11 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:50466 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751549AbbIOHRK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2015 03:17:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ANDAAJxfdVPM5BFlxdGQEBAYMHgT2GWW29eAQEgTxNAQEBAQEBBwEBAQFBJBuEHgUBAQEBAwgBAS4eAQEsAgMFAgEDFQELJRQBBBoGBwMUBgESCAIBAgMBiCG8b41aAQsghnOEfYE9hm+BFAEEhzKFf4grAYEapmuDAYFkPTOKKgEBAQ
X-IPAS-Result: A2ANDAAJxfdVPM5BFlxdGQEBAYMHgT2GWW29eAQEgTxNAQEBAQEBBwEBAQFBJBuEHgUBAQEBAwgBAS4eAQEsAgMFAgEDFQELJRQBBBoGBwMUBgESCAIBAgMBiCG8b41aAQsghnOEfYE9hm+BFAEEhzKFf4grAYEapmuDAYFkPTOKKgEBAQ
X-IronPort-AV: E=Sophos;i="5.17,533,1437433200"; 
   d="scan'208";a="248733782"
Received: from host-92-22-65-206.as13285.net (HELO PhilipOakley) ([92.22.65.206])
  by out1.ip07ir2.opaltelecom.net with SMTP; 15 Sep 2015 08:17:07 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277890>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, September 14, 2015 11:43 PM
> --------------------------------------------------

> [New Topics]

> * po/doc-branch-desc (2015-09-14) 1 commit
>  (merged to 'next' on 2015-09-14 at 4934a96)
> + doc: show usage of branch description
>
> The branch descriptions that are set with "git 
> branch --edit-description"
> option were used in many places but they weren't clearly documented.
>
> Will merge to 'master'.
>
Thanks.
Shall I just rework/resend the V2 patch-up ($gmane/277829) that also 
links to 'merge's' usage as a fresh patch (would be tonight UK)?
