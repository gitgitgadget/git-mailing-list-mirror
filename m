From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git submodule enhancements
Date: Wed, 24 Sep 2008 18:39:53 +0200
Message-ID: <48DA6D59.60904@lsrfire.ath.cx>
References: <200809241100.30758.p_christ@hol.gr> <8c5c35580809240213v5198d2abh489915dc1133c75@mail.gmail.com> <200809241314.29661.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Hjemli <hjemli@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Mr. Meitar Moscovitz" <meitarm@gmail.com>
To: "P. Christeas" <p_christ@hol.gr>
X-From: git-owner@vger.kernel.org Wed Sep 24 18:41:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXQR-0007BP-KV
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 18:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbYIXQkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 12:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbYIXQkE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 12:40:04 -0400
Received: from india601.server4you.de ([85.25.151.105]:49744 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbYIXQkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 12:40:03 -0400
Received: from [10.0.1.200] (p57B7C897.dip.t-dialin.net [87.183.200.151])
	by india601.server4you.de (Postfix) with ESMTPSA id F27F12F803F;
	Wed, 24 Sep 2008 18:39:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <200809241314.29661.p_christ@hol.gr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96660>

P. Christeas schrieb:
> On Wednesday 24 September 2008, Lars Hjemli wrote:
>> Btw: why doesn't
>>   $ git submodule foreach 'git archive HEAD > somewhere/$path.tar'
>> work for you?
> In fact, it could. You could also replace HEAD with the $sha1 ..

By the way, have you tried git-archive-all.sh (announced here a month
ago and hosted here: http://github.com/meitar/git-archive-all.sh/wikis)=
?

Ren=C3=A9
