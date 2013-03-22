From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Mar 2013, #06; Thu, 21)
Date: Fri, 22 Mar 2013 00:11:22 -0000
Organization: OPDS
Message-ID: <46A741281AFC4C56B3FBDEFB531FD7D2@PhilipOakley>
References: <7vzjxw8icr.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 01:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIpa9-0001CB-Gw
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 01:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260Ab3CVALO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 20:11:14 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:14963 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753776Ab3CVALN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Mar 2013 20:11:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlUJAAWhS1FOl3xZ/2dsb2JhbABDjWG3dwSBXBd0gh8FAQEFCAEBLh4BASwCAwUCAQMVAQslFAEEGgYHFwYBEggCAQIDAYgHwiiOABaDYWEDiD+FcJk3gS+BWzw
X-IronPort-AV: E=Sophos;i="4.84,888,1355097600"; 
   d="scan'208";a="404031996"
Received: from host-78-151-124-89.as13285.net (HELO PhilipOakley) ([78.151.124.89])
  by out1.ip04ir2.opaltelecom.net with SMTP; 22 Mar 2013 00:11:11 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218773>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, March 21, 2013 11:04 PM
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
[...]
> --------------------------------------------------
> [Stalled]
>
[...]
>
> * po/help-guides (2013-03-03) 5 commits
> - help doc: include --guide option description
> - help.c: add list_common_guides_help() function
> - help.c: add --guide option
> - help.c: use OPT_COUNTUP
> - show 'git help <guide>' usage, with examples
>
> Give more visibility to "concept guides" to help "git help" users.
>
> Expecting a reroll.
> $gmane/217384
>

I'm still planning to do this. Unfortunately my test machine is still 
out of action.

Philip 
