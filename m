From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Mon, 28 Jul 2014 23:12:41 +0100
Organization: OPDS
Message-ID: <A586612AA4994E3F94B96620DB314EF3@PhilipOakley>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com><B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley><xmqqegxcdjzl.fsf@gitster.dls.corp.google.com><7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley><xmqqvbqm74v7.fsf@gitster.dls.corp.google.com> <xmqqegx95bxc.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:12:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBtA1-0007Tj-2D
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 00:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbaG1WMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 18:12:43 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:31164 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708AbaG1WMn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2014 18:12:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmYbAAvK1lNZ8YBCPGdsb2JhbABZgw6BKYcvgQTLFwUBAgEBgRAXBQEBAQE4NoN+BQEBBAEIAQEuHgEBIQUGAgMFAgEDFQELJRQBBBoGBwMUBhMIAgECAwGIKQyuC5AyF4wdgy+DNoEbBYo3hn2WAowsPC8
X-IPAS-Result: AmYbAAvK1lNZ8YBCPGdsb2JhbABZgw6BKYcvgQTLFwUBAgEBgRAXBQEBAQE4NoN+BQEBBAEIAQEuHgEBIQUGAgMFAgEDFQELJRQBBBoGBwMUBhMIAgECAwGIKQyuC5AyF4wdgy+DNoEbBYo3hn2WAowsPC8
X-IronPort-AV: E=Sophos;i="5.01,751,1400022000"; 
   d="scan'208";a="710386357"
Received: from host-89-241-128-66.as13285.net (HELO PhilipOakley) ([89.241.128.66])
  by out1.ip01ir2.opaltelecom.net with SMTP; 28 Jul 2014 23:12:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254358>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, July 25, 2014 11:08 PM
>> * po/everyday-doc (2014-01-27) 1 commit
>> - Make 'git help everyday' work

> Let's disect it.  I do not have time/concentration to finish all in
> one message, so I'll do the first two.
>
<snip>

Thanks for the guidance. I'll work on updating the patch in line with 
your comments and see how far I get.

--
Philip 
