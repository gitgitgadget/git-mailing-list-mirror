From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Is there some env variable like GIT_LANG (like LANG)?
Date: Mon, 21 Mar 2011 20:48:53 +0100
Message-ID: <4D87ABA5.1030609@dirk.my1.cc>
References: <4D879E11.6040609@dirk.my1.cc> <7vipvcp8e3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:49:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1l66-00006T-VY
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab1CUTs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 15:48:59 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:47489 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab1CUTs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 15:48:57 -0400
Received: from [84.176.60.154] (helo=[192.168.2.100])
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Q1l5z-0007ZR-40; Mon, 21 Mar 2011 20:48:55 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7vipvcp8e3.fsf@alter.siamese.dyndns.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169653>

Am 21.03.2011 20:43 schrieb Junio C Hamano:
> Dirk S=C3=BCsserott<newsletter@dirk.my1.cc>  writes:
>
>> What would you think of it?
>
> Strongly negative.  I don't want force people to set GIT_LANG HG_LANG
> CVS_LANG and 47 different FROTZ_LANG environment variables.
>
> I would rather just set LANG=3DC LC_ALL=3DC in the terminal I use git=
 in and
> leave everything else in whatever locale the rest of the system is in=
=2E
>

Ok. Accepted. Was just a question. I see your point.
