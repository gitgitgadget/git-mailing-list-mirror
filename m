From: "Raoul Bhatia [IPAX]" <r.bhatia@ipax.at>
Subject: Re: feature request: git annotate -w like git blame -w
Date: Mon, 14 Nov 2011 17:21:02 +0100
Organization: IPAX Internet Services
Message-ID: <4EC13FEE.2040401@ipax.at>
References: <4EBD1CF4.7040002@ipax.at> <m3sjlun4o9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:21:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPzHV-00089R-JR
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 17:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab1KNQVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 11:21:07 -0500
Received: from mail.ipax.at ([93.189.24.40]:46892 "EHLO mail.ipax.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab1KNQVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 11:21:06 -0500
Received: from [192.168.1.110] (unknown [78.142.123.177])
	by mail.ipax.at (Postfix) with ESMTPSA id 6150C2400DC;
	Mon, 14 Nov 2011 17:21:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20111031 Thunderbird/7.0.1
In-Reply-To: <m3sjlun4o9.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185390>

On 2011-11-11 14:57, Jakub Narebski wrote:
> "Raoul Bhatia [IPAX]"<r.bhatia@ipax.at>  writes:
>
>> is it possible to add a "git annotate -w" option like git blame has?
>
> Why not use "git blame -c -w"?  `-c' turns on annotate-compatibile
> output.
>
>  From git-annotate(1) manpage:
>
>     The only difference between this command and git-blame(1) is that they  use
>     slightly  different  output formats, and this command exists only for back-
>     ward compatibility to support existing scripts, and provide a more familiar
>     command name for people coming from other SCM systems.

thanks for this clarification. somehow, i missed this part while
scanning the man pages.

thank you and sorry for the noise!
raoul
-- 
____________________________________________________________________
DI (FH) Raoul Bhatia M.Sc.          email.          r.bhatia@ipax.at
Technischer Leiter

IPAX - Aloy Bhatia Hava OG          web.          http://www.ipax.at
Barawitzkagasse 10/2/2/11           email.            office@ipax.at
1190 Wien                           tel.               +43 1 3670030
FN 277995t HG Wien                  fax.            +43 1 3670030 15
____________________________________________________________________
