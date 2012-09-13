From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Suggestions for "What's cooking"
Date: Thu, 13 Sep 2012 08:21:45 +0100
Organization: OPDS
Message-ID: <90925598F9104F7FAC680544FABE0A79@PhilipOakley>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org> <504F8427.1020507@web.de> <7vhar4gxdq.fsf@alter.siamese.dyndns.org> <5050E0CA.7080907@web.de> <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Jens Lehmann" <Jens.Lehmann@web.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 09:21:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC3kD-0001sl-GF
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 09:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab2IMHVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 03:21:41 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:2874 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752719Ab2IMHVk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 03:21:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuMKAP+IUVBZ8rU+/2dsb2JhbABFhgeFP68rAnyBCIIbBQEBBQgBARkVHgEBIQsCAwUCAQMVAQQCBSECAhQBBBoGBxcGARIIAgECAwGHbQMQqGaJPCKJPoEhiW+BSoNbMmADjWOYG4JngWI
X-IronPort-AV: E=Sophos;i="4.80,415,1344207600"; 
   d="scan'208";a="384528971"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip04ir2.opaltelecom.net with SMTP; 13 Sep 2012 08:21:38 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205359>

From: "Philip Oakley" <philipoakley@iee.org>
Sent: Wednesday, September 12, 2012 11:49 PM
> From: "Jens Lehmann" <Jens.Lehmann@web.de>
> Sent: Wednesday, September 12, 2012 8:21 PM
>> Am 11.09.2012 21:41, schrieb Junio C Hamano:
>>> Thanks.  I wish all others paid attention to "What's cooking" like
>>> you did here.
>>>
>>> And if it is hard to do so for whatever reason, suggest a better way
>>> for me to publish "What's cooking" or an equivalent (I am interested
>>> in finding the least bureaucratic way to help people and keep the
>>> balls rolling).
>>
>> I think "What's cooking" makes lots of sense in its current form
>> as one gets a very good overview over current development tracks.
>>
>> Maybe in addition it would be nice to email the author(s) of a
>> series when the state changes or new comments are added (and to
>> only include the relevant part from "What's cooking" there). For
>> me it's not a big problem as I just have to grep for "submodule"
>> to get the bits I care about, but I suspect others might have to
>> invest much more time to check the current state of their series
>> and may appreciate being mailed directly when something happens.
>> Opinions?
>
> My comment, as a simple reader, is that I misread the order of the 
> items, in that I miss-associate the description paragraph with the * 
> title _below_. That is, I see the description first and then read 
> on...
>
> Thinking about it, if the description paragraph was indented by one 
> space then the * title  would create that obvious content indent that 
> (I am) would be expected.
>
> Obviously only a useful suggestion if it's easy to implement...
>
> Philip
Thinking overnight. One very simple option is to just add a double line 
spacing between items to give a clearer break.

 i.e.
previous item ends.LF
LF
LF
* Next Item 
