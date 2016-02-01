From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] Git doc: GPL2 does not apply to repo data
Date: Mon, 1 Feb 2016 10:57:39 -0000
Organization: OPDS
Message-ID: <B311BDED447947CB93BF57DD8714321C@PhilipOakley>
References: <alpine.DEB.2.20.1601280913450.2964@virtualbox> <1454274011-4880-1-git-send-email-philipoakley@iee.org> <xmqq8u35xv00.fsf@gitster.mtv.corp.google.com> <6D15DFBB73355B4E9EFB1AD5EF9FCA31842442AA@NZ-EXCHANGE1.fphcare.com> <alpine.DEB.2.20.1602010827430.2964@virtualbox> <1591708020.2493723.1454312995839.JavaMail.zimbra@imag.fr> <20160201081431.GA26215@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Smith" <Jonathan.Smith@fphcare.co.nz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"GitList" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>,
	"Matthieu Moy" <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 01 11:57:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQCAy-00079v-E2
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 11:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbcBAK5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 05:57:40 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:39097 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753634AbcBAK5j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 05:57:39 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BHPwDiOK9WPN7OYAJdGQEBAQELAQIBAQEBAYMKUm2HTYELr0Zsgw4KGAqFYwQBAwEBgTM9EAEBAQEBAQEGAQEBAUEkG0EOAYNsBQEBAQECAQgBARkVFggBASEFBgEBAwUCAQMOBwMCAgUhAgIUAQQYAgYHAxQGAQcLCAEBAQIDAQwEh3IMCq1/hiCISnuFFIQ3hzIrgQ8FjSWJSgGBOYQNhU+EEBY0hx2FLo4+N4ItGYFRPC4BAYNXhSQBAQE
X-IPAS-Result: A2BHPwDiOK9WPN7OYAJdGQEBAQELAQIBAQEBAYMKUm2HTYELr0Zsgw4KGAqFYwQBAwEBgTM9EAEBAQEBAQEGAQEBAUEkG0EOAYNsBQEBAQECAQgBARkVFggBASEFBgEBAwUCAQMOBwMCAgUhAgIUAQQYAgYHAxQGAQcLCAEBAQIDAQwEh3IMCq1/hiCISnuFFIQ3hzIrgQ8FjSWJSgGBOYQNhU+EEBY0hx2FLo4+N4ItGYFRPC4BAYNXhSQBAQE
X-IronPort-AV: E=Sophos;i="5.22,379,1449532800"; 
   d="scan'208";a="116728325"
Received: from host-2-96-206-222.as13285.net (HELO PhilipOakley) ([2.96.206.222])
  by out1.ip02ir2.opaltelecom.net with SMTP; 01 Feb 2016 11:52:37 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285197>

From: "Jeff King" <peff@peff.net>
> On Mon, Feb 01, 2016 at 08:49:55AM +0100, Matthieu Moy wrote:
>
>> ----- Original Message -----
>> > For less tech-savvy managers, I found that name dropping works quite 
>> > well
>> > (read: naming a couple of well-known companies/products that switched 
>> > to
>> > Git).
>>
>> In the same category: "GitHub has 12 millions users" works rather well.
>
> Who's to say GitHub's business plan isn't to become a copyright troll? :)
>
> On a more serious note, this FAQ (and the one right after) might be
> useful for convincing people:
>
>  http://www.gnu.org/licenses/gpl-faq.en.html#GPLOutput
>

I'd added a link to the GPL2 faq version of that, though my link did take 
the reader to the contents list item.

The oddball is the templates, which could be argued are full GPL2 (see the 
mention of Bison in that same paragraph), and would need a further notice 
about their licence terms (given an insistent copyright holder!)

> Data that git stores is not strictly "output", but I think the answers
> there are relevant. And presumably written or vetted by lawyers, too.
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
