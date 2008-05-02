From: Pedro Melo <melo@simplicidade.org>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 10:41:42 +0100
Message-ID: <702ACF8F-B6D0-42FD-9B38-7C5A4F775E90@simplicidade.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri May 02 11:42:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrrmq-00057E-Ph
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 11:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707AbYEBJlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 05:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757132AbYEBJlx
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 05:41:53 -0400
Received: from mail.sl.pt ([212.55.140.13]:41288 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753942AbYEBJlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 05:41:52 -0400
Received: (qmail 11799 invoked from network); 2 May 2008 09:41:46 -0000
Received: from unknown (HELO [10.0.0.128]) (melo@[213.205.86.37])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <gitster@pobox.com>; 2 May 2008 09:41:46 -0000
Received-SPF: none (mail-sl: domain of melo@simplicidade.org does not designate permitted sender hosts)
In-Reply-To: <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80974>


On May 2, 2008, at 7:04 AM, Kevin Ballard wrote:

> On May 2, 2008, at 1:56 AM, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> On Fri, May 02, 2008 at 01:41:05AM -0400, Kevin Ballard wrote:
>>>
>>>> Does anybody have any comments or opinions about this either way?
>>>
>>> I agree with you; I don't like it at all.
>>
>> I do not care either way.  As I do not have LESS defined in my  
>> environment
>> (which makes git use its built-in that contains FX), I actually never
>> noticed the difference before or after that patch.
>
> Even if I put FX into LESS (I have it set normally so it contains  
> R), it still doesn't behave correctly. I compulsively clear my  
> terminal screen whenever I don't need the current contents, but  
> with FX in LESS, `git status` throws the output at the bottom of my  
> terminal, leaving a lot of blank space at the top. This is  
> extremely irritating to me.

hmms... I remember you being a Mac user. I'm on 10.4.11 and with

LESS=iFMRSXW
LESSCHARSET=utf-8

it works as if no pager has been set.

Personally, I like the pager because the best part of git-status is  
at the top, so if I hit git-status thats the one I want to see.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
