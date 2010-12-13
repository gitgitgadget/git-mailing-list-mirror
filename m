From: Andreas Ericsson <ae@op5.se>
Subject: Re: Please pull gitk.git master branch
Date: Mon, 13 Dec 2010 10:25:32 +0100
Message-ID: <4D05E68C.70306@op5.se>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com> <7vwrne8tow.fsf@alter.siamese.dyndns.org> <7v7hfe74ea.fsf@alter.siamese.dyndns.org> <7vbp4q5ddo.fsf@alter.siamese.dyndns.org> <AANLkTinPqDbvdG9r4UFcKq9BJSw4by4_hJdEN+0oUaJZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Alexandre Erwin Ittner <alexandre@ittner.com.br>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 10:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS4f8-0004Yr-Bh
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab0LMJZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 04:25:36 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:44662 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab0LMJZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:25:36 -0500
Received: by ewy10 with SMTP id 10so3754545ewy.4
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:25:34 -0800 (PST)
Received: by 10.213.7.8 with SMTP id b8mr1175004ebb.44.1292232334697;
        Mon, 13 Dec 2010 01:25:34 -0800 (PST)
Received: from [192.168.1.186] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id w20sm4964269eeh.12.2010.12.13.01.25.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:25:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Thunderbird/3.1.6 ThunderGit/0.1a
In-Reply-To: <AANLkTinPqDbvdG9r4UFcKq9BJSw4by4_hJdEN+0oUaJZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163527>

On 12/13/2010 09:36 AM, Sverre Rabbelier wrote:
> Heya,
> 
> On Mon, Dec 13, 2010 at 08:40, Junio C Hamano<gitster@pobox.com>  wrote:
>>> My _preferred_ outcome is to see that naming the input "po/pt_br.po" and
>>> using the output "po/pt_br.msg" is the BCP, but I'd like somebody to find
>>> out what the accepted practice would be in the Tcl land first.
>>
>> I still don't know what the BCP is in the Tcl community (didn't have time
>> to check, dealing with other topics), but I'll tentatively apply this on
>> top of queue Alexandre's patch and merge the result in 'pu'.
> 
> Pardon my ignorance, what is BCP? None of the definitions I could find
> seemed likely.
> 

Best Coding Practice.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
