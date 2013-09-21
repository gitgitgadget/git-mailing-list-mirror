From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Sep 2013, #06; Fri, 20)
Date: Sat, 21 Sep 2013 14:05:53 +0100
Organization: OPDS
Message-ID: <7D71B0A7A7364397B0F61AAB93419321@PhilipOakley>
References: <xmqqli2rp2w4.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:05:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNMsP-0003Ae-Rk
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab3IUNFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 09:05:04 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:10823 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751721Ab3IUNFD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 09:05:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoGAKOYPVJOl3GZ/2dsb2JhbABagweJcbhvgSQXdGmBIRYBBAEBBQgBAS4eAQEsAgMFAgEDFQELJRQBBBoGBxcGARIIAgECAwGFOAeCFiO7DZMKgQADiQCGEpphgyU7
X-IPAS-Result: ApoGAKOYPVJOl3GZ/2dsb2JhbABagweJcbhvgSQXdGmBIRYBBAEBBQgBAS4eAQEsAgMFAgEDFQELJRQBBBoGBxcGARIIAgECAwGFOAeCFiO7DZMKgQADiQCGEpphgyU7
X-IronPort-AV: E=Sophos;i="4.90,952,1371078000"; 
   d="scan'208";a="423409296"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip04ir2.opaltelecom.net with SMTP; 21 Sep 2013 14:04:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235099>

From: "Junio C Hamano" <gitster@pobox.com>
To: <git@vger.kernel.org>
Sent: Friday, September 20, 2013 11:03 PM

>
> * po/dot-url (2013-09-13) 2 commits
>  (merged to 'next' on 2013-09-20 at 6a12786)
> + config doc: update dot-repository notes
> + doc: command line interface (cli) dot-repository dwimmery
>
> Explain how '.' can be used to refer to the "current repository"
> in the documentation.
>
> Will merge to 'master'.
>
>
Thanks.

I was hoping to do a tweak to 'doc: command line interface (cli) 
dot-repository dwimmery' to give it it's own bullet point and a slight 
readjustment of the words regarding repo discovery from sub-directories.

I'll do the tweak on top of 'next' and see if it's acceptable.

I also still have an update for the previous URLs patch that wrong.

Philip
