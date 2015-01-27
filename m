From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv2] commit: reword --author error message
Date: Tue, 27 Jan 2015 08:37:21 -0000
Organization: OPDS
Message-ID: <A36392C1208647BC9F2CA89478DCC754@PhilipOakley>
References: <xmqqfvba1p07.fsf@gitster.dls.corp.google.com> <7e2e1d1e7f4a25d84a6f7a1c0cb035221529f189.1422286879.git.git@drmicha.warpmail.net> <20150126190711.GA13582@peff.net> <xmqqlhkplz8d.fsf@gitster.dls.corp.google.com> <20150127024553.GA24569@peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	<git@vger.kernel.org>, "Eric Sunshine" <sunshine@sunshineco.com>,
	"Gunnar Wagner" <gunnar.wagner@irisgermanica.com>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 09:37:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG1eF-0004BK-3D
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 09:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898AbbA0IhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 03:37:19 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:26726 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754074AbbA0IhP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2015 03:37:15 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsUNAPlMx1RcEalUPGdsb2JhbABagwaBK4MAgyptxSkEAoEmRAEBAQEBAQUBAQEBOCAbhAcFAQEBAQMIAQEZFR4BASELAgMFAgEDDgcDAgIFIQICFAEEGgYHAxQGARIIAgECAwGIH755hlOOJiyBIY11EQFQgm8ugRMFjm5UmwmEED4xgQuBNwEBAQ
X-IPAS-Result: AsUNAPlMx1RcEalUPGdsb2JhbABagwaBK4MAgyptxSkEAoEmRAEBAQEBAQUBAQEBOCAbhAcFAQEBAQMIAQEZFR4BASELAgMFAgEDDgcDAgIFIQICFAEEGgYHAxQGARIIAgECAwGIH755hlOOJiyBIY11EQFQgm8ugRMFjm5UmwmEED4xgQuBNwEBAQ
X-IronPort-AV: E=Sophos;i="5.09,473,1418083200"; 
   d="scan'208";a="667142838"
Received: from host-92-17-169-84.as13285.net (HELO PhilipOakley) ([92.17.169.84])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 27 Jan 2015 08:37:12 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263061>

From: "Jeff King" <peff@peff.net>
> On Mon, Jan 26, 2015 at 06:43:46PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > ... I somehow had trouble making
>> > sense of Z ("a match...") as a noun.
>>
>> > I wonder if adding back in the missing verb, rather than a colon, 
>> > would
>> > also make more sense:
>> >
>> >   --author '%s' is neither 'Name <email>' nor a match for an 
>> > existing author
>>
>> Then
>>
>> >   --author '%s' is not 'Name <email>' and matches no existing 
>> > author
>>
>> would be the shortest, sweetest and hopefully grammatical, perhaps?
>
> Yes, that one make perfect sense to me.
>
Agreed.
Philip
