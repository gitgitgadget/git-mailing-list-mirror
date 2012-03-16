From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 12:34:27 +0100
Message-ID: <4F632543.50402@seap.minhap.es>
References: <4F63205A.6000202@seap.minhap.es> <vpqlin0n8w5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 11:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8UY0-00013p-Pq
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 11:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032710Ab2CPKiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 06:38:06 -0400
Received: from luthien1.mpt.es ([82.150.0.102]:55944 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032707Ab2CPKiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 06:38:06 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 4BE90B6F7B;
	Fri, 16 Mar 2012 11:35:41 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 3FA912C498;
	Fri, 16 Mar 2012 11:35:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <vpqlin0n8w5.fsf@bauges.imag.fr>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 4BE90B6F7B.07DDA
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332498949.40117@RVPhpcxNgjWciuxr2S/lRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193251>

On 03/16/2012 11:21 AM, Matthieu Moy wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
>> +# You can re-order the commit lines to affect the order on which
>> +# the commits will be applied.
> 
> That's probably the main use of "rebase -i", so it deserves a mention,
> yes.
> 
> Maybe shorten it to one line like
> 
>   You can re-order the lines to change the order of commits in history.

I like it but the word 'history' seems a bit too technical for me, and may
scare the normal user,, what about:

You can re-order the lines to change the order the commits are applied.

> (BTW, is it not 'order in which', not '_on_ which'?)
> 

May be, non-native english speaker here..
