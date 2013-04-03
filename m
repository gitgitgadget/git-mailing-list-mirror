From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH V3 2/5] Help.c use OPT_BOOL and refactor logic
Date: Wed, 3 Apr 2013 23:24:57 +0100
Organization: OPDS
Message-ID: <548AC0AF83DA42EA8C39C268693606AD@PhilipOakley>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org> <1364942392-576-3-git-send-email-philipoakley@iee.org> <7v62048qxm.fsf@alter.siamese.dyndns.org> <7vhajo76xh.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"W. Trevor King" <wking@tremily.us>,
	"David Aguilar" <davvid@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 00:25:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNW7K-0006Ks-Np
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 00:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868Ab3DCWYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 18:24:50 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:47843 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757332Ab3DCWYt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 18:24:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkQLAPKqXFFOl3a6/2dsb2JhbABDgweJGbdsBAEDAYELF3SCGgUBAQQBCAEBLh4BASELAgMFAgEDFgslFAEEGgYHFwYTCAIBAgMBh30KwGqOL2qCZmEDiEKFcZIrhxiDDDs
X-IronPort-AV: E=Sophos;i="4.87,403,1363132800"; 
   d="scan'208";a="571238347"
Received: from host-78-151-118-186.as13285.net (HELO PhilipOakley) ([78.151.118.186])
  by out1.ip06ir2.opaltelecom.net with SMTP; 03 Apr 2013 23:24:47 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219974>

Sent: Wednesday, April 03, 2013 2:13 AM
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> You are creating a gap in the output so that you can add some more
>> stuff in later patches, which is fine, but I do not think we call
>> that kind of change a "refactor" ;-).
>>
>> The change looks fine.
> 
> I'll queue what I suggested on 'pu' for now.

It looks good. I'm happy with your suggestions as queued.

Acked-by: Philip Oakley <philipoakley@iee.org>

Longer term I'd like to be able to show all the guides as a double -gg
option, but this is a great start.

> 
> Thanks.
> 
> 
> -----
