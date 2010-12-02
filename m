From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 02 Dec 2010 15:17:24 +0900
Message-ID: <buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
	<1291230820.11917.25.camel@drew-northup.unet.maine.edu>
	<877hftuvvz.fsf@picasso.cante.net>
	<7vfwuhtafr.fsf@alter.siamese.dyndns.org>
	<AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
	<87sjygspgy.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 07:17:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO2U6-0003Q5-Hr
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 07:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab0LBGRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 01:17:33 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:55003 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959Ab0LBGRc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 01:17:32 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.195])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id oB26HPxA002472;
	Thu, 2 Dec 2010 15:17:25 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id oB26HPR08425; Thu, 2 Dec 2010 15:17:25 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.60])
	by vgate02.nec.co.jp (8.14.4/8.14.4) with ESMTP id oB26GVlm027662;
	Thu, 2 Dec 2010 15:17:25 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay51.aps.necel.com with ESMTP; Thu, 2 Dec 2010 15:17:24 +0900
Received: from dhlpc061 ([10.114.96.28] [10.114.96.28]) by relay51.aps.necel.com with ESMTP; Thu, 2 Dec 2010 15:17:24 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 919EF52E21E; Thu,  2 Dec 2010 15:17:24 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <87sjygspgy.fsf@picasso.cante.net> (Jari Aalto's message of "Thu,
	02 Dec 2010 07:39:25 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162677>

Jari Aalto <jari.aalto@cante.net> writes:
>> Additionaly, you must know about the ^ notation. That is the only way
>> refer to the second parent HEAD^2, for example.
>
> If "must" is a requirement, I have to regret that there has yet to have
> been a situation where I would ahve a need to refer to "second parent".
>
> I guess most of the basic features can be used without it.

It doesn't matter.  There needs to be a better reason than "Jari doesn't
like it."

-Miles

-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
