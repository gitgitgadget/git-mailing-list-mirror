From: Pedro Melo <melo@simplicidade.org>
Subject: Re: Parent-less branches
Date: Sat, 3 May 2008 00:04:46 +0100
Message-ID: <B5BADF6F-7CFF-4A6C-BE06-0994786D8D0F@simplicidade.org>
References: <F26CE1A6-FE85-4AC6-BCE6-B41085A09F0F@simplicidade.org> <7vskx0wf8i.fsf@gitster.siamese.dyndns.org> <0EACFC4A-F2E7-48D3-BE49-10D2B32AB470@wincent.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat May 03 01:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js4K8-0003nZ-IV
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 01:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935367AbYEBXEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 19:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935309AbYEBXEu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 19:04:50 -0400
Received: from mail.sl.pt ([212.55.140.13]:34091 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932691AbYEBXEt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 19:04:49 -0400
Received: (qmail 23346 invoked from network); 2 May 2008 23:04:47 -0000
Received: from unknown (HELO [192.168.1.67]) (melo@[81.193.202.135])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <gitster@pobox.com>; 2 May 2008 23:04:47 -0000
Received-SPF: none (mail-sl: domain of melo@simplicidade.org does not designate permitted sender hosts)
In-Reply-To: <0EACFC4A-F2E7-48D3-BE49-10D2B32AB470@wincent.com>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81044>

Hi,

On May 2, 2008, at 11:32 PM, Wincent Colaiuta wrote:

> El 2/5/2008, a las 23:47, Junio C Hamano escribi=F3:
>> Pedro Melo <melo@simplicidade.org> writes:
>>
>>> inside an existing repository I want to create a new branch =20
>>> without a
>>> parent commit. Is there a set of commands to do this?
[...]
> I wanted to do this just the other day, but I did it all inside the =20
> one repo, and made some notes on the process here:
>
> http://rails.wincent.com/wiki/Creating_independent_branches_with_Git

This is exactly what I needed, thanks!

Best regards,
--=20
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
