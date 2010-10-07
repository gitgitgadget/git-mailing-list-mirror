From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH v2 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Wed, 06 Oct 2010 23:48:04 -0600
Message-ID: <4CAD5F14.3010903@workspacewhiz.com>
References: <20101003043221.1960.73178.stgit@SlamDunk> <20101003043228.1960.88989.stgit@SlamDunk> <AANLkTikU7D5dWAc-04cVUnjPPrC7rjaqjPe_j3rEvn0u@mail.gmail.com> <4CA847D5.4000903@workspacewhiz.com> <7vzkuqy718.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 07:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3jL3-00058G-2s
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 07:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab0JGFsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 01:48:11 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:56880 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab0JGFsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 01:48:10 -0400
Received: (qmail 28764 invoked by uid 399); 6 Oct 2010 23:48:05 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 6 Oct 2010 23:48:05 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <7vzkuqy718.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158371>

  ----- Original Message -----
=46rom: Junio C Hamano
Date: 10/6/2010 10:13 PM
> Joshua Jensen<jjensen@workspacewhiz.com>  writes:
>> In any case, I'd like to find a solution to get this series working
>> for everyone.  I've been out of commission for a month (deploying Gi=
t
>> to 80+ programmers at an organization, by the way), but I'm back now
>> and can work this until it is complete.
> Thanks; I'll queue =C3=86var's v3 (with [v4 2/8]) for now.
That sounds great!

Josh
