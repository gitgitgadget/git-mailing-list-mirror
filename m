From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: changing colors in the tree view in gitk
Date: Fri, 5 Feb 2016 19:14:46 -0000
Organization: OPDS
Message-ID: <3FAE862069E24321A6E31D9F0CB66E35@PhilipOakley>
References: <CAC4O8c-8cXCfu7GdCS6bx5RMfw_Y8PgPeOhH6Zb5awyi-Qt4tw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Britton Kerin" <britton.kerin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:16:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRlrI-0004Uw-1K
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531AbcBETOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:14:52 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:5274 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756433AbcBETOs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 14:14:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BxSgBX87RWPIGyYwJeGQEBAQELAQIBAQEBAYMKUm2HUIELqW2FeIMbIYViBAQCgTZNAQEBAQEBBwEBAQFBJBtBAQEBAQEBAQEBAQQCAoNpBgEBBAgBARkVHgEBIQsCAwUCAQMVBQIFIQICFAEECBIGBwMUBhMIAgECAwGHdQMWCrB2hiCDZw2EaQR7hReEN4I3gWyDDyuBDwWNJ4lOAYE6hBGGEYNOh2mFL4Z9h0GERjwuAX4hKESCaoEdNYF9gTcBAQE
X-IPAS-Result: A2BxSgBX87RWPIGyYwJeGQEBAQELAQIBAQEBAYMKUm2HUIELqW2FeIMbIYViBAQCgTZNAQEBAQEBBwEBAQFBJBtBAQEBAQEBAQEBAQQCAoNpBgEBBAgBARkVHgEBIQsCAwUCAQMVBQIFIQICFAEECBIGBwMUBhMIAgECAwGHdQMWCrB2hiCDZw2EaQR7hReEN4I3gWyDDyuBDwWNJ4lOAYE6hBGGEYNOh2mFL4Z9h0GERjwuAX4hKESCaoEdNYF9gTcBAQE
X-IronPort-AV: E=Sophos;i="5.22,401,1449532800"; 
   d="scan'208";a="615929151"
Received: from host-2-99-178-129.as13285.net (HELO PhilipOakley) ([2.99.178.129])
  by out1.ip03ir2.opaltelecom.net with SMTP; 05 Feb 2016 19:54:14 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285595>

From: "Britton Kerin" <britton.kerin@gmail.com>
>I upgraded from 2.5 to 2.7 and the branch names went from a light
> green to dark green, the names of the tags are hard to read now.
>
> Is it possible to configure the branch name color in the tree view?
> --
Which Operating System is this on? and which Git version.?


For the Git for Windows, the Mintty window colours can be adjusted. e.g. 
https://code.google.com/archive/p/mintty/wikis/Tips.wiki

Though I just changed my config setting for the awkward to read items (for 
me it was color.branch.upstream=green !)
--

Philip 
