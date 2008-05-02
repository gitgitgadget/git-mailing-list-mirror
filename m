From: Kevin Ballard <kevin@sb.org>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 12:58:25 -0400
Message-ID: <2161C3E5-69E8-4160-8468-43E8B1049746@sb.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org> <702ACF8F-B6D0-42FD-9B38-7C5A4F775E90@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Fri May 02 18:59:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrybQ-0002Os-CJ
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 18:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbYEBQ63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 12:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbYEBQ63
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 12:58:29 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:46390
	"EHLO randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752017AbYEBQ62 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 12:58:28 -0400
Received: from [192.168.0.215] (c-24-91-11-245.hsd1.nh.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 39C55EEF84;
	Fri,  2 May 2008 09:58:27 -0700 (PDT)
In-Reply-To: <702ACF8F-B6D0-42FD-9B38-7C5A4F775E90@simplicidade.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81011>

On May 2, 2008, at 5:41 AM, Pedro Melo wrote:

>> Even if I put FX into LESS (I have it set normally so it contains  
>> R), it still doesn't behave correctly. I compulsively clear my  
>> terminal screen whenever I don't need the current contents, but  
>> with FX in LESS, `git status` throws the output at the bottom of my  
>> terminal, leaving a lot of blank space at the top. This is  
>> extremely irritating to me.
>
> hmms... I remember you being a Mac user. I'm on 10.4.11 and with
>
> LESS=iFMRSXW
> LESSCHARSET=utf-8
>
> it works as if no pager has been set.

Except that's not true. As I've mentioned before, if I've cleared the  
terminal, and I run less with FX set, and the output is less than the  
height of my terminal, all the output ends up at the bottom of my  
terminal and the rest of the terminal is blank space. It's rather  
annoying, because it's the exact opposite of how I usually work (I  
compulsively clear my terminal so I can work at the top of the window  
instead of the bottom).

-Kevin

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
