From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: An interesting opinion on DVCS/git
Date: Mon, 9 Mar 2015 14:47:27 -0000
Organization: OPDS
Message-ID: <4949A08A7B0445C2953FDB0F0C870BF0@PhilipOakley>
References: <54F2CD12.8050609@gmail.com> <CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Stefan Beller" <sbeller@google.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 15:46:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUywp-0001qK-ID
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 15:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbbCIOqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 10:46:19 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:23424 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932350AbbCIOqR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2015 10:46:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DHIABKsf1UPIMkFlxagwZSWoMKgy1ttUmFdoVyBIEmTgEBAQEBAQUBAQEBOCAbhAoFAQEBAQMIAQEZFR4BASwCAwUCAQMOBwEEAgUhAgIUAQQaBgcDFAYBEggCAQIDAQ2IFahIhlOUWSCBIYl2h10vgRYFkA9fgwWHCTmOX4NChBE+MYJDAQEB
X-IPAS-Result: A2DHIABKsf1UPIMkFlxagwZSWoMKgy1ttUmFdoVyBIEmTgEBAQEBAQUBAQEBOCAbhAoFAQEBAQMIAQEZFR4BASwCAwUCAQMOBwEEAgUhAgIUAQQaBgcDFAYBEggCAQIDAQ2IFahIhlOUWSCBIYl2h10vgRYFkA9fgwWHCTmOX4NChBE+MYJDAQEB
X-IronPort-AV: E=Sophos;i="5.11,368,1422921600"; 
   d="scan'208";a="586159900"
Received: from host-92-22-36-131.as13285.net (HELO PhilipOakley) ([92.22.36.131])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 09 Mar 2015 14:46:16 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265170>

From: "Stefan Beller" <sbeller@google.com>
Sent: Monday, March 02, 2015 3:29 AM
> bitquabit.com/post/unorthodocs-abandon-your-dvcs-and-return-to-sanity
> --

The part that the author misses is not all the nice (or not so) stuff 
about having a copy of the full repository locally, for all the reasons 
he mentions, rather it is the *distribution of control*.

In most centralised repo systems there is also centralisation of 
control. The user does not have control. I may initiate a request for 
change, but it's authorisation is always somewhere else, to avoid my 
accidental pollution of the golden source.

The thing that a DVCS brings to the user is an ability to regain a 
little control of their own environment and to include version recording 
within it. The fact that it can be integrated seamlessly into the golden 
source makes it a great tool providing a win-win for all, especially 
when a Hub environment provides a separation between the golden source 
and the user's perambulations and peregrinations that they'd like on a 
safe server.

It is the distribution of Control, not the distribution of Code that 
makes DVCS such a winner (for users). The distribution of all the code 
is icing on the cake (though natural in a FOSS project).
--
Philip 
