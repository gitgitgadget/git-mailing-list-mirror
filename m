From: Sam Vilain <sam@vilain.net>
Subject: Re: Git performance results on a large repository
Date: Fri, 03 Feb 2012 14:57:32 -0800
Message-ID: <4F2C665C.8080909@vilain.net>
References: <CB5179E9.3B751%joshua.redstone@fb.com> <4F2C6276.1070100@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:57:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtS4Z-0001xM-Vk
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab2BCW5f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 17:57:35 -0500
Received: from uk.vilain.net ([92.48.122.123]:40050 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2BCW5e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 17:57:34 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 29C618276; Fri,  3 Feb 2012 22:57:34 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 19BD28075;
	Fri,  3 Feb 2012 22:57:32 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F2C6276.1070100@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189820>

On 2/3/12 2:40 PM, Sam Vilain wrote:
> As the git object storage model is write=E2=80=93only and content=E2=80=
=93addressed,
> it should git this kind of scaling well.
             ^^^

Could have sworn I typed 'suit' there.  My fingers have auto=E2=80=93co=
rrect ;-)

Sam
