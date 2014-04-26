From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Sat, 26 Apr 2014 10:39:02 +0100
Organization: OPDS
Message-ID: <27645ABF2E944872BB3F944B17E9490B@PhilipOakley>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com> <20140425231953.GB3855@sigill.intra.peff.net> <535b0db7e5e31_ba2148d310f4@nysa.notmuch> <BLU0-SMTP3741FBD4980A29338AC8BA8D1450@phx.gbl> <535b4c5a3c91c_3d63109d2f00@nysa.notmuch>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Alex Davidson" <descenterace@hotmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 11:39:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdz4l-0005Y2-8N
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 11:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaDZJjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 05:39:07 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:21592 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028AbaDZJjE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 05:39:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoBbANF9W1MCYJIz/2dsb2JhbABZgwZfA4MphT28LAUBAgEMgQMXdIIgBQEBBAEIAQEZFR4BASYGAgMFAgEDFQUCBSECAhQBBAgSBgcXBgESCAIBAgMBCAKIEgMJDKc8hVmWYQ2HD4EpixiCTYJBNYEVBI9mhzWOeIVUgzI8
X-IPAS-Result: AoBbANF9W1MCYJIz/2dsb2JhbABZgwZfA4MphT28LAUBAgEMgQMXdIIgBQEBBAEIAQEZFR4BASYGAgMFAgEDFQUCBSECAhQBBAgSBgcXBgESCAIBAgMBCAKIEgMJDKc8hVmWYQ2HD4EpixiCTYJBNYEVBI9mhzWOeIVUgzI8
X-IronPort-AV: E=Sophos;i="4.97,932,1389744000"; 
   d="scan'208";a="444661396"
Received: from host-2-96-146-51.as13285.net (HELO PhilipOakley) ([2.96.146.51])
  by out1.ip04ir2.opaltelecom.net with SMTP; 26 Apr 2014 10:39:02 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247152>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
>
> My conclusion is based on logic and reason,

you forget  "And repeatable measurement / evidence" ....

>                                                                  which 
> are the bedstone of science.
> You can make sensible decisions based on that alone, and in fact 
> that's how
> most good decisions are made.
>
> -- 
> Felipe Contreras
> --

At the moment we are missing the repeatable measurements, which can't 
happened until the @{publish}, and others, have been released and used 
for a while[1], otherwise we [prematurely] are back to one size fits all 
solutions.

I suspect your solution may become the lead candidate for @{p}, but as 
they say, "making predictions is hard, especially about the future".

regards

Philip

[1] we don't have a good measurement technique for existing usage 
frequencies (as typed by real users in real life, weighted by user type, 
...) either! 
