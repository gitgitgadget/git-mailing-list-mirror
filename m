From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [GSoC] Microproject :- Teaching git pull --rebase the --no-autostash flag
Date: Fri, 26 Feb 2016 19:17:26 -0000
Organization: OPDS
Message-ID: <80982D980AF046D88353950D975DA2F5@PhilipOakley>
References: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com> <vpqy4a7y5l9.fsf@anie.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <me@ikke.info>, <pyokagan@gmail.com>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Mehul Jain" <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 20:17:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZNtT-0003Ac-SQ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 20:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423069AbcBZTR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 14:17:29 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:34209 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423067AbcBZTR2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 14:17:28 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CPSADRo9BWPEgvFlxeFgMBAQILAQIBAQEBAYMKUm2HUalRVQGHLYMbJYVoBAKBR00BAQEBAQEHAQEBAUElG0EBBA0Bg2gFAQEBAQIBCAEBLh4BASELAgMFAgEDFQIKJRQBBAgSBgcDDAgGARIIAgECAwGHeQMKDAq1TIN8DYQ5AQsBHYYShDqBdUWFJoEPBY1iiSYBgUSEE4YUhB2MS4cFEocyhEY8LoIAgk6DfQEBAQ
X-IPAS-Result: A2CPSADRo9BWPEgvFlxeFgMBAQILAQIBAQEBAYMKUm2HUalRVQGHLYMbJYVoBAKBR00BAQEBAQEHAQEBAUElG0EBBA0Bg2gFAQEBAQIBCAEBLh4BASELAgMFAgEDFQIKJRQBBAgSBgcDDAgGARIIAgECAwGHeQMKDAq1TIN8DYQ5AQsBHYYShDqBdUWFJoEPBY1iiSYBgUSEE4YUhB2MS4cFEocyhEY8LoIAgk6DfQEBAQ
X-IronPort-AV: E=Sophos;i="5.22,504,1449532800"; 
   d="scan'208";a="662461489"
Received: from host-92-22-47-72.as13285.net (HELO PhilipOakley) ([92.22.47.72])
  by out1.ip04ir2.opaltelecom.net with SMTP; 26 Feb 2016 20:10:56 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287604>

From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
> Hi,
>
> Some minor nits in addition to Paul's comments:
>
>> Subject: Re: [GSoC] Microproject :- Teaching git pull --rebase 
>> the --no-autostash flag
>
> The ":-" is typically Indian. Just use ":" here (without a space
> before).

I think it was we Brit's who are to blame. While less frequent these days it 
was common here in Briton. I certainly use it sometimes ;-)

http://english.stackexchange.com/questions/31060/is-it-proper-to-use-a-colon-followed-immediately-by-a-hyphen

https://www.quora.com/What-is-this-punctuation-called (originalism would 
also suggest USA..)


>
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> With this patch, git pull --rebase will understand --no-autostash command 
>> line flag.
>> This flag will override "rebase.autostash" configuration(if set)
>
> Here and elsewhere: space before "(".
>
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --

Philip 
