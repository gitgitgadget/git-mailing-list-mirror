From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Re* ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Fri, 24 Jun 2011 08:20:22 +0200
Message-ID: <4E042CA6.6040309@web.de>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E0390A7.8040505@web.de> <7vboxo2ne9.fsf@alter.siamese.dyndns.org> <7vy60r27et.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>, Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Andreas_K=F6hler?= <andi5.py@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 08:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZzkj-0007H4-7l
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 08:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab1FXGUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 02:20:24 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:44253 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab1FXGUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 02:20:23 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9E6CA192B59DC;
	Fri, 24 Jun 2011 08:20:22 +0200 (CEST)
Received: from [93.246.52.168] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QZzkc-00024u-00; Fri, 24 Jun 2011 08:20:22 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vy60r27et.fsf_-_@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18BGg9D1YnY75aiaxJkL69n43CEVTVu3/NQ3FUn
	2b4ijPvLMS0lmoITh/beZEGC1cB6sV7shNGao30VhL6f49Gu9t
	rpGl1Jm1u3u9EyocFAPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176305>

Am 24.06.2011 06:13, schrieb Junio C Hamano:
> I suspect this fix will cascade to breakage elsewhere, but I've run out of
> energy and inclination to look at the submodule code tonight, so I'll let
> the list to take it further from here.

I'll won't have much git time today but I'll look into that over the
weekend.
