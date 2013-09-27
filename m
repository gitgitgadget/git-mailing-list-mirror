From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 18:07:18 +0100
Organization: OPDS
Message-ID: <D4FEE03E0E044EBE858849F4B2F771B4@PhilipOakley>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com> <1380283828-25420-4-git-send-email-artagnon@gmail.com> <C79FDE949E6D43478E1176342FA09E0E@PhilipOakley> <CALkWK0me+DdxVVjZTi3zmOoCc5HcjR8BgqWMNUkHU1qDP4-vfA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 19:07:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPbVY-0007qn-3S
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 19:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201Ab3I0RHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 13:07:08 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:30880 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752196Ab3I0RHG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Sep 2013 13:07:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmQGAPK5RVJOl3GZ/2dsb2JhbABbgweEM4U+t1sKgRwXdGmBIRYBBAEBBQgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQIEgYHFwYTCAIBAgMBhTgHghcNAxOnNogzDYlqgSmLPYJrgnE1gQEDjxOHA44thTSBOoFrOw
X-IPAS-Result: AmQGAPK5RVJOl3GZ/2dsb2JhbABbgweEM4U+t1sKgRwXdGmBIRYBBAEBBQgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQIEgYHFwYTCAIBAgMBhTgHghcNAxOnNogzDYlqgSmLPYJrgnE1gQEDjxOHA44thTSBOoFrOw
X-IronPort-AV: E=Sophos;i="4.90,994,1371078000"; 
   d="scan'208";a="86367450"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip07ir2.opaltelecom.net with SMTP; 27 Sep 2013 18:07:04 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235469>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
> Philip Oakley wrote:
>> "=" and "<>" I can easily understand (binary choice), but ">" and "<" 
>> will
>> need to be clear which way they indicate in terms of matching
>> the "[ahead N]" and  "[behind M]" options.
>
> The ">" corresponds to ahead, while "<" is behind. You'll get used to
> it pretty quickly :)
>

But this documentation section could say ;-)
>>> diff --git a/Documentation/git-for-each-ref.txt
>>> b/Documentation/git-for-each-ref.txt


regards

Philip 
