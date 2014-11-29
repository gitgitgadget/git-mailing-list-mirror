From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Sat, 29 Nov 2014 13:31:18 -0000
Organization: OPDS
Message-ID: <D7697DE2C591421E8588920BD4FE0455@PhilipOakley>
References: <6997784.RuzRO1AFsK@al> <1660121.8PEbpzfRYH@al> <20141124225457.GA9942@peff.net> <283403992.8FOSVk7RPR@al>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Peter Wu" <peter@lekensteyn.nl>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 29 15:05:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuidy-0004gy-Vb
	for gcvg-git-2@plane.gmane.org; Sat, 29 Nov 2014 15:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbaK2OE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2014 09:04:56 -0500
Received: from b216.a.smtp2go.com ([216.22.18.216]:57235 "EHLO
	b216.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaK2OEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2014 09:04:54 -0500
X-Greylist: delayed 2059 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Nov 2014 09:04:54 EST
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260378>

From: "Peter Wu" <peter@lekensteyn.nl>
> Ok, I will make a clear note about the default (without --only) 
> behavior
> having weird behavior for historical reasons. Are you really OK with
> --only=both? It sounds a bit odd (mathematically speaking it is 
> correct
> as fetch and push are both partitions that form the whole set if you
> ignore the historical behavior).
>
How about :

s/--only/--direction/

or some suitable abbreviation (--dirn ?)
--
Philip 
