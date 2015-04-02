From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Trying to push into empty repo, get fatal: bad revision 'HEAD'
Date: Thu, 02 Apr 2015 07:07:19 +0200
Organization: gmx
Message-ID: <79faa1f88bcfa26d2ce8dd65e4e944ae@www.dscho.org>
References: <CAHkN8V8cpZUmCi6=MUcsCOCBe6H_G6btr6WaV2vVrO1Nm_r4tg@mail.gmail.com>
 <xmqqego4ogxw.fsf@gitster.dls.corp.google.com>
 <xmqq8uecocjg.fsf@gitster.dls.corp.google.com>
 <cb4098391d46cc25b3d4d059e35dc806@www.dscho.org>
 <xmqqd23nn2ym.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Samuel Williams <space.ship.traveller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 07:07:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdXLn-0002kH-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 07:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbbDBFHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 01:07:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:60894 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbbDBFHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 01:07:24 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LikQP-1Z9YmL18d3-00cwZd; Thu, 02 Apr 2015 07:07:20
 +0200
In-Reply-To: <xmqqd23nn2ym.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:E8H0iWdpeBjqn1/6b5e5x+v/+mB959jAGlxxRaGFmrADQUHfPCS
 s/iOwuK2Vo3XYR0s9QeTmLnMqOoqmLjFvo3wFHJQCsa2WZA1t/HiYsaXoy0NF925Mfxkr5C
 4OXLy+lOGHK/1ufsmnlPxJFY7pNRSCYMdRMO+cCNmIQn+pAKxinLFbdha6qwQ4k47yMLvZ/
 qB0wyM1wdKCOP4p0p70uQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266630>

Hi Junio,

On 2015-04-01 20:00, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Yeah, and we could refactor that into a global function, too. But for
>> the moment, I think your proposed patch is good enough.
> 
> OK, so can I forge your Acked-by?

You read my mind.

Ciao,
Dscho
